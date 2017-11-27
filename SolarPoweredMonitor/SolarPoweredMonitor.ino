/* Notes: The pressure sensor has the only accurate temperature sensor. Second most accurate is the humidity sensor's temp.
 *  Depending on power usage, I may want to power the three sensors from a toggled pin. 
 */

//#include "C:\Program Files (x86)\Arduino\hardware\teensy\avr\libraries\Adafruit_GFX\Adafruit_GFX.h" // include the base Adafruit Graphics library
#include <Adafruit_GFX.h>
#include "EPD215.h"               // include the epaper display driver library
#include <Wire.h>                 // include the temperature sensor protocol driver library
#include <TimeLib.h>              // RTC
#include <SparkFunMPL3115A2.h>    // Pressure sensor
#include <Adafruit_Sensor.h>      // magnetometer 
#include <Adafruit_HMC5883_U.h>   // also magnetometer
#include <ADC.h>
#include "pictures.h"             // pixel maps of load screen art      
#include <Snooze.h>               // deep sleepin'       

#define TMP102_I2C_ADDRESS  0x49 // I2C address for our temperature chip
#define TIME_HEADER         "T"   // Header tag for serial time sync message
#define TRUE                1
#define FALSE               0
#define ARRAY_LENGTH        24    // idk why but this gives 24 spots
#define SMALL_ARRAY_LENGTH  6    
#define SLEEP_LENGTH        10000 // number of ms of sleep

#define DEPLOY              1     // 1 = turn off delay(), activate sleep modes.

// initialize epaper with pin numbers for cs, dc, rs, bs, d0, d1 for software SPI
EPD215 epaper( 17, 16, 15, 14, 13, 7 ); // using 7 for DOUT/MOSI so I can use 11 for compare wakeup

//////////////////
// VARIABLES
//////////////////
float temperature;
float temperatureHigh;
float temperatureLow;
float headingDegrees;               // for mag
float pressureValues[] = {0, 0, 0}; // for holding Pa, PSI, temp
const int ADCpin = A8;
const int PGOODpin = 11;             // Wakeup from hibernation when LTC3588 PGOOD pin goes high
int artNumber = 0;                  // to cycle between loading screens

//////////////////
// CIRCULAR ARRAYS FOR PAST DATA
//////////////////
//int pastPressure[ARRAY_LENGTH];
//int pastPressure6[SMALL_ARRAY_LENGTH];
//int pressureArrayWriteIndex = 0;
//int pressureArrayWriteIndex6 = 0;

int pastTemp[ARRAY_LENGTH];
int pastTemp6[SMALL_ARRAY_LENGTH];
int tempArrayWriteIndex = 0;
int tempArrayWriteIndex6 = 0;

//int pastHumidity[ARRAY_LENGTH];
int pastHumidity6[SMALL_ARRAY_LENGTH];
//int humidityArrayWriteIndex = 0;
int humidityArrayWriteIndex6 = 0;

float pastVoltage[ARRAY_LENGTH];
float pastVoltage6[SMALL_ARRAY_LENGTH];
int voltageArrayWriteIndex = 0;
int voltageArrayWriteIndex6 = 0;

//////////////////
// OBJECT INSTANCES
//////////////////
MPL3115A2 myPressure;
/* Assign a unique ID to this sensor at the same time */
Adafruit_HMC5883_Unified mag = Adafruit_HMC5883_Unified(12345);
ADC *adc = new ADC(); // adc object;
sensors_event_t event;

// Load snooze drivers
SnoozeCompare compare;
SnoozeTimer timer;
SnoozeAlarm alarm;

SnoozeBlock config_teensy32_alarm(alarm);
SnoozeBlock config_teensy32_compare(compare);

//---------------------------------------------------------------------------------

void setup() {
  Wire.begin();                  
//  Serial.begin(115200);

  // ADC
  setupADC();

  // RTC
  setupRTC();
  //digitalClockDisplay();

  // Interrupts
  setupAlarms();
  
  // PRESSURE
  setupPressure();

  // COMPASS
  setupCompass();

  // E-PAPER 
  initEpaper();

}

void loop() {
  
  float Vnow = getBusVoltage(TRUE);
  
  if (Vnow >= 2.7) {
    setSyncProvider(getTeensy3Time);
    // HIH-6130
    getHumidity();
    // PRESSURE
    readPressure(pressureValues);
    // COMPASS
    readCompassSimple();
    // E-PAPER
    displayData();
    delay(500);

    // SLEEP
    #if DEPLOY == 0
      delay(SLEEP_LENGTH); // 15000ms = 15 s, 300,000ms = 5 min, 3,600,000ms = 1hr
    #elif DEPLOY == 1
      Snooze.deepSleep( config_teensy32_alarm );  // return module that woke processor
    #endif
  }
  else if ((Vnow < 2.7) && (Vnow >= 2.5)){
    // Tell user power is low and go back to sleep.
    setSyncProvider(getTeensy3Time);
    cryForHelp();
    #if DEPLOY == 0
      delay(SLEEP_LENGTH);
    #elif DEPLOY == 1
      Snooze.deepSleep( config_teensy32_alarm );
    #endif
  }
  else {
    // Immediately go back to sleep. Don't wake up until PGOOD goes high. 
    // System dies when power bus goes below 1.7V (about 1.66V).
    #if DEPLOY == 0
      delay(SLEEP_LENGTH);
    #elif DEPLOY == 1
      Snooze.deepSleep( config_teensy32_compare );
    #endif 
  }
}

//---------------------------------------------------------------------------------

/////////////////
// UTILITIES
/////////////////

void setupAlarms(){
  pinMode(PGOODpin, INPUT);
//  digital.pinMode(PGOODpin, INPUT_PULLDOWN, RISING);
  
  // Set RTC alarm wake up in (hours, minutes, seconds).
  // Must tell the time library to re-sync from the RTC upon wakeup. 
  alarm.setAlarm(1, 0, 0);// hour, min, sec
  
  /********************************************************
  Set Low Power Timer wake up in milliseconds.
  ********************************************************/
  //timer.setTimer(SLEEP_LENGTH);// milliseconds
    
  /********************************************************
   Values greater or less than threshold will trigger CMP
   wakeup. Threshold value is in volts (0-3.3v) using a 64
   tap resistor ladder network at 0.0515625v per tap.

   92% of 3.3 = 3.036 for LTC3588 PGOOD pin to go high
   However during testing 
   
   parameter "type": LOW & FALLING are the same.
   parameter "type": HIGH & RISING are the same.
   
   Teensy 3.x/LC
   Compare pins: 11,12
   ********************************************************/
  compare.pinMode(PGOODpin, HIGH, 3.0); //pin, mode, threshold(v)
}

void pushIntoArray(int* myArray, int& writeIndex, int arraySize, int value){
  noInterrupts();
  if (writeIndex > arraySize) {
//    Serial.print("writeIndex was this so now I'm zeroing it: ");Serial.println(writeIndex);
    writeIndex = 0;
  }
  myArray[writeIndex] = value;
  writeIndex++;
  interrupts();
}

void pushIntoArray_floats(float* myArray, int& writeIndex, int arraySize, float value){
  noInterrupts();
  if (writeIndex > arraySize) {
//    Serial.print("writeIndex was this so now I'm zeroing it (floats): ");Serial.println(writeIndex);
    writeIndex = 0;
  }
  myArray[writeIndex] = value;
  writeIndex++;
  interrupts();
}

int findMaxInt(int* integer_array, int arraySize){
  int maximum = integer_array[0];
  
  for (int i = 0; i < arraySize; i++) {
      if (integer_array[i] > maximum) {
        maximum = integer_array[i];
      }
  }
  return maximum;
}

int findMinInt(int* integer_array, int arraySize){
  int minimum = integer_array[0];
  
  for (int i = 0; i < arraySize; i++) {
      if (integer_array[i] < minimum) {
        minimum = integer_array[i];
      }
  }
  return minimum;
}

float findMaxFloat(float* float_array, int arraySize){
  float maximum = float_array[0];
  
  for (int i = 0; i < arraySize; i++) {
      if (float_array[i] > maximum) {
        maximum = float_array[i];
      }
  }
  return maximum;
}

float findMinFloat(float* float_array, int arraySize){
  float minimum = float_array[0];
  
  for (int i = 0; i < arraySize; i++) {
      if (float_array[i] < minimum) {
        minimum = float_array[i];
      }
  }
  return minimum;
}

float mapfloat(float x, float in_min, float in_max, float out_min, float out_max)
{
 return (x - in_min) * (out_max - out_min) / (in_max - in_min) + out_min;
}

/////////////////
// ADC
/////////////////

void setupADC() {
  pinMode(ADCpin, INPUT);
  adc->setReference(ADC_REFERENCE::REF_1V2, ADCpin);  // internal 1.19V ref. Make sure ADC doesn't see anything above that!
  adc->setAveraging(16); // set number of averages
  adc->setResolution(16); // set bits of resolution
  adc->setConversionSpeed(ADC_CONVERSION_SPEED::VERY_LOW_SPEED); // change the conversion speed  
  adc->setSamplingSpeed(ADC_SAMPLING_SPEED::MED_SPEED); // change the sampling speed
}

float getBusVoltage(bool record) {
  // ADC value must be mapped to the resistor voltage divider which lets it "see" above its own bus voltage. 
  float ADCvalue, ADCvoltage, BUSvoltage;
  float DIVIDER_VOLTAGE = 1.185;
  float MAX_BUS_VOLTAGE = 3.6;
  float FUDGE_FACTOR = 0.05;    // This thing is still off by a few 0.01V.
  ADCvalue = adc->analogRead(ADCpin);
  ADCvoltage = (ADCvalue/adc->getMaxValue(ADCpin)) * DIVIDER_VOLTAGE;
  BUSvoltage = mapfloat(ADCvoltage, 0, DIVIDER_VOLTAGE, 0, MAX_BUS_VOLTAGE);

  if (record) {
    pushIntoArray_floats(pastVoltage, voltageArrayWriteIndex, ARRAY_LENGTH, BUSvoltage);
    pushIntoArray_floats(pastVoltage6, voltageArrayWriteIndex6, SMALL_ARRAY_LENGTH, BUSvoltage);
  }
  return BUSvoltage;
}

/////////////////
// PRESSURE
/////////////////

void setupPressure() {
  //Serial.println("Setting up Pressure sensor");
  myPressure.begin(); // Get sensor online
  myPressure.setModeBarometer();
  myPressure.setOversampleRate(7); // Set Oversample to the recommended 128
  myPressure.enableEventFlags(); // Enable all three pressure and temp event flags
}

void readPressure(float *pressureValues) {
  
  float pressurePa = myPressure.readPressure();
  float pressure_PSI = pressurePa * 0.000145038; // 1 Pa = 0.000145038 PSI
  float temperature = myPressure.readTemp();

  pressureValues[0] = pressurePa;
  pressureValues[1] = pressure_PSI;
  pressureValues[2] = temperature;
  pushIntoArray(pastTemp, tempArrayWriteIndex, ARRAY_LENGTH, (int)temperature);
  pushIntoArray(pastTemp6, tempArrayWriteIndex6, SMALL_ARRAY_LENGTH, (int)temperature);
}

/////////////////
// COMPASS
/////////////////

void setupCompass() {
  /* Initialise the sensor */
  if(!mag.begin())
  {
    //Serial.println("Ooops, no HMC5883 detected ... Check your wiring!");
  }
}

void readCompassSimple() {
  /* Get a new sensor event */ 
   
  mag.getEvent(&event);
 
  /* Display the results (magnetic vector values are in micro-Tesla (uT)) */
//  Serial.print("X: "); Serial.print(event.magnetic.x); Serial.print("  ");
//  Serial.print("Y: "); Serial.print(event.magnetic.y); Serial.print("  ");
//  Serial.print("Z: "); Serial.print(event.magnetic.z); Serial.print("  ");Serial.println("uT");

  // Hold the module so that Z is pointing 'up' and you can measure the heading with x&y
  // Calculate heading when the magnetometer is level, then correct for signs of axis.
  float heading = atan2(event.magnetic.y, event.magnetic.x);
  
  // Once you have your heading, you must then add your 'Declination Angle', which is the 'Error' of the magnetic field in your location.
  // Find yours here: http://www.magnetic-declination.com/
  // Mine is: -13* 2' W, which is ~13 Degrees, or (which we need) 0.22 radians
  // If you cannot find your Declination, comment out these two lines, your compass will be slightly off.
  float declinationAngle = 0.26;  // SEATTLE IS +15 deg = .26 rad
  heading += declinationAngle;
  
  // Correct for when signs are reversed.
  if(heading < 0)
    heading += 2*PI;
    
  // Check for wrap due to addition of declination.
  if(heading > 2*PI)
    heading -= 2*PI;
   
  // Convert radians to degrees for readability.
  headingDegrees = heading * 180/M_PI; 
  
  //Serial.print("Heading: "); Serial.print(headingDegrees, 0); Serial.println(" deg");
}

////////////////
// E-PAPER
////////////////

void initEpaper() {
  //Serial.println("Setting up E-paper");
  epaper.initScreen();           // initialize the epaper hardware
  epaper.updateScreen();         // update the screen with whatever is in the buffer

}

void drawGears() {
  epaper.clearScreen();
  epaper.drawBitmap(0, 0, bitmapGEARS, 112, 208, WHITE);
  epaper.updateScreen();
}

void drawKNEKTEK() {
  epaper.clearScreen();
  epaper.drawBitmap(0, 0, bitmapKNEKTEK, 112, 208, WHITE);
  epaper.updateScreen();
}

void getTemperature() { //get temperature from temperature sensor
  Wire.beginTransmission( TMP102_I2C_ADDRESS ); // for more details on how to read the temperature from this sensor
  Wire.write( 0x00 );                           // please refer to the device datasheet: 
  Wire.endTransmission();                       // http://www.ti.com.cn/cn/lit/ds/symlink/tmp102.pdf
  Wire.requestFrom( TMP102_I2C_ADDRESS, 2 );
  Wire.endTransmission();
  int val = Wire.read() << 4;
  val |= Wire.read() >> 4;
  //temperature = (((( val * 0.0625 ) - 5 ) * 9 ) / 5 ) + 32; // Farenheit
  temperature = ( val * 0.0625 ) - 5; // Celsius
  if ( temperature > temperatureHigh ) temperatureHigh = temperature;
  if ( temperature < temperatureLow ) temperatureLow = temperature;
}

String parseTemperature( float t ) { // convert temperature value to String
  String s;
  if ( t > 100 ) s = String( t / 100 );
  s += String(int( t / 10 ) % 10 );
  s += String(int( t ) % 10 );
  s += ".";
  s += String(int( t * 10 ) % 10 );
  return s;
}

void displayData() {
  if (artNumber % 2 == 0){
    drawGears();
  }
  else {
    drawKNEKTEK();
  }
  //getTemperature();
  epaper.clearScreen();          // clear the screen buffer
  epaper.setCursor( 0, 0 );      // reset the cursor position
  epaper.print("Today: "); epaper.print(month()); epaper.print("/"); epaper.print(day()); epaper.print(", "); epaper.println(year());
  epaper.print("At "); epaper.print(hour());printDigitsOnPaper(minute());printDigitsOnPaper(second());epaper.println();
  epaper.print(   String("Voltage: ")); 
  print_float_on_paper(pastVoltage[voltageArrayWriteIndex - 1], 3);
  epaper.println( String("V" ));
  epaper.println( String( "Humidity: " ) + pastHumidity6[humidityArrayWriteIndex6 - 1] + "%" );     
  epaper.print( String( "Temp: " ) + pressureValues[2] + "C, " ); epaper.print((int)(pressureValues[2] *1.8 + 32)); epaper.println("F");
  epaper.println( String( "Pressure: " ) + (int)pressureValues[0] + "Pa" );  
  epaper.println( String( "Pressure: " ) + pressureValues[1] + "PSI" );
  epaper.print("Heading: "); epaper.print(headingDegrees, 0); epaper.println(" deg");
  epaper.print("X:"); epaper.println(event.magnetic.x);
  epaper.print("Y:"); epaper.println(event.magnetic.y);
  epaper.print("Z:"); epaper.print(event.magnetic.z); epaper.print(" ");epaper.println("uT");  

  epaper.println();
  epaper.println("In last 6 readings");
  epaper.print("Least V: "); epaper.println( findMinFloat(pastVoltage6, SMALL_ARRAY_LENGTH), 4);
  epaper.print("Most V:  "); epaper.println( findMaxFloat(pastVoltage6, SMALL_ARRAY_LENGTH), 4);
  epaper.print("Dry: "); epaper.print(findMinInt(pastHumidity6, SMALL_ARRAY_LENGTH)); epaper.print("%"); 
  epaper.print(", Wet: "); epaper.print(findMaxInt(pastHumidity6, SMALL_ARRAY_LENGTH)); epaper.println("%");
  epaper.print("Hot: "); epaper.print(findMaxInt(pastTemp6, SMALL_ARRAY_LENGTH)); epaper.print(", Cold: "); 
  epaper.println(findMinInt(pastTemp6, SMALL_ARRAY_LENGTH));

  epaper.println();
  epaper.println("In last 24");
  epaper.print("Least V: "); epaper.println( findMinFloat(pastVoltage, ARRAY_LENGTH), 4);
  epaper.print("Most V:  "); epaper.println( findMaxFloat(pastVoltage, ARRAY_LENGTH), 4);
//  epaper.print("Dry: "); epaper.print(findMinInt(pastHumidity, ARRAY_LENGTH)); epaper.print("%"); 
//  epaper.print(", Wet: "); epaper.print(findMaxInt(pastHumidity, ARRAY_LENGTH)); epaper.println("%");
  epaper.print("Hot: "); epaper.print(findMaxInt(pastTemp, ARRAY_LENGTH)); epaper.print(", Cold: "); 
  epaper.println(findMinInt(pastTemp, ARRAY_LENGTH));

  epaper.println(); epaper.print("Waking in one hour");
  
  epaper.updateScreen( pressureValues[2] );   // update the epaper screen with the buffer contents, passing the current temperature to the epaper screen
  
  artNumber++;
  if (artNumber > 100) {
    // Just to prevent some kind of weird overflow bug a decade from now... 
    artNumber = 0;
  }
}

void cryForHelp(){
  epaper.clearScreen();
  epaper.setCursor(0, 0);
  epaper.println("\"Aziz...LIGHT!\"");
  epaper.println("(put me in sun!)"); epaper.println();
  epaper.println("Time of death: "); epaper.print(month()); epaper.print("/"); epaper.print(day()); epaper.print(", "); epaper.println(year());
  epaper.print("At "); epaper.print(hour());printDigitsOnPaper(minute());printDigitsOnPaper(second());epaper.println();
  epaper.print(   String("Voltage: ")); print_float_on_paper(pastVoltage[voltageArrayWriteIndex - 1], 3);
  epaper.drawBitmap(0, 80, bitmapSun, 112, 104, WHITE);
  epaper.updateScreen();
}

void print_float_on_paper(float f, int num_digits) {
    // a modified version of the print_float function from the humidity sensor code
    //int f_int;
    int pows_of_ten[4] = {1, 10, 100, 1000};
    int multiplier, whole, fract, d, n;

    multiplier = pows_of_ten[num_digits];
    if (f < 0.0)
    {
        f = -f;
        epaper.print("-");
    }
    whole = (int) f;
    fract = (int) (multiplier * (f - (float)whole));

    epaper.print(whole);
    epaper.print(".");

    for (n=num_digits-1; n>=0; n--) // print each digit with no leading zero suppression
    {
         d = fract / pows_of_ten[n];
         epaper.print(d);
         fract = fract % pows_of_ten[n];
    }
}      

////////////////
// RTC
////////////////

void setupRTC() {
  //Serial.println("Setting up RTC");
  // set the Time library to use Teensy 3.0's RTC to keep time
  setSyncProvider(getTeensy3Time);

  if(Serial) {  
    if (timeStatus()!= timeSet) {
      Serial.println("Unable to sync with the RTC");
    } else {
        if (Serial.available()) {
        time_t t = processSyncMessage();
        if (t != 0) {
          Teensy3Clock.set(t); // set the RTC
          setTime(t);
          Serial.println("RTC has set the system time");
        }
      }
    }
  }
}

void digitalClockDisplay() {
  // digital clock display of the time
  Serial.print(hour());
  printDigits(minute());
  printDigits(second());
  Serial.print(" ");
  Serial.print(day());
  Serial.print(" ");
  Serial.print(month());
  Serial.print(" ");
  Serial.print(year()); 
  Serial.println(); 
}

time_t getTeensy3Time() {
  return Teensy3Clock.get();
}

unsigned long processSyncMessage() {
  unsigned long pctime = 0L;
  const unsigned long DEFAULT_TIME = 1357041600; // Jan 1 2013 

  if(Serial.find(TIME_HEADER)) {
     pctime = Serial.parseInt();
     return pctime;
     if( pctime < DEFAULT_TIME) { // check the value is a valid time (greater than Jan 1 2013)
       pctime = 0L; // return 0 to indicate that the time is not valid
     }
  }
  return pctime;
}

void printDigits(int digits){
  // utility function for digital clock display: prints preceding colon and leading 0
  Serial.print(":");
  if(digits < 10)
    Serial.print('0');
  Serial.print(digits);
}

void printDigitsOnPaper(int digits){
  // utility function for digital clock display: prints preceding colon and leading 0
  epaper.print(":");
  if(digits < 10)
    epaper.print('0');
  epaper.print(digits);
}
//////////////
// HIH-6130 Humidity and Temp
//////////////

float getHumidity() {
  byte _status;
  unsigned int H_dat, T_dat;
  float RH, T_C;
  
  _status = fetch_humidity_temperature(&H_dat, &T_dat);
  
//  switch(_status)
//  {
//      case 0:  Serial.println("Normal.");
//               break;
//      case 1:  Serial.println("Stale Data.");
//               break;
//      case 2:  Serial.println("In command mode.");
//               break;
//      default: Serial.println("Diagnostic."); 
//               break; 
//  }       

  RH = (float) H_dat * 6.10e-3;
  T_C = (float) T_dat * 1.007e-2 - 40.0;

//  pushIntoArray(pastHumidity, humidityArrayWriteIndex, ARRAY_LENGTH, (int)RH);
  pushIntoArray(pastHumidity6, humidityArrayWriteIndex6, SMALL_ARRAY_LENGTH, (int)RH);
  return(RH);
  
}

byte fetch_humidity_temperature(unsigned int *p_H_dat, unsigned int *p_T_dat)
{
      byte address, Hum_H, Hum_L, Temp_H, Temp_L, _status;
      unsigned int H_dat, T_dat;
      address = 0x27;;
      Wire.beginTransmission(address); 
      Wire.endTransmission();
      delay(100);
      
      Wire.requestFrom((int)address, (int) 4);
      Hum_H = Wire.receive();
      Hum_L = Wire.receive();
      Temp_H = Wire.receive();
      Temp_L = Wire.receive();
      Wire.endTransmission();
      
      _status = (Hum_H >> 6) & 0x03;
      Hum_H = Hum_H & 0x3f;
      H_dat = (((unsigned int)Hum_H) << 8) | Hum_L;
      T_dat = (((unsigned int)Temp_H) << 8) | Temp_L;
      T_dat = T_dat / 4;
      *p_H_dat = H_dat;
      *p_T_dat = T_dat;
      return(_status);
}
   
//void print_float(float f, int num_digits)
//{
//    //int f_int;
//    int pows_of_ten[4] = {1, 10, 100, 1000};
//    int multiplier, whole, fract, d, n;
//
//    multiplier = pows_of_ten[num_digits];
//    if (f < 0.0)
//    {
//        f = -f;
//        Serial.print("-");
//    }
//    whole = (int) f;
//    fract = (int) (multiplier * (f - (float)whole));
//
//    Serial.print(whole);
//    Serial.print(".");
//
//    for (n=num_digits-1; n>=0; n--) // print each digit with no leading zero suppression
//    {
//         d = fract / pows_of_ten[n];
//         Serial.print(d);
//         fract = fract % pows_of_ten[n];
//    }
//}      





