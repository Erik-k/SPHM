EESchema Schematic File Version 2
LIBS:SolarClapboard-rescue
LIBS:power
LIBS:device
LIBS:transistors
LIBS:conn
LIBS:linear
LIBS:regul
LIBS:74xx
LIBS:cmos4000
LIBS:adc-dac
LIBS:memory
LIBS:xilinx
LIBS:microcontrollers
LIBS:dsp
LIBS:microchip
LIBS:analog_switches
LIBS:motorola
LIBS:texas
LIBS:intel
LIBS:audio
LIBS:interface
LIBS:digital-audio
LIBS:philips
LIBS:display
LIBS:cypress
LIBS:siliconi
LIBS:opto
LIBS:atmel
LIBS:contrib
LIBS:valves
LIBS:74xgxx
LIBS:ac-dc
LIBS:actel
LIBS:allegro
LIBS:Altera
LIBS:analog_devices
LIBS:battery_management
LIBS:bbd
LIBS:bosch
LIBS:brooktre
LIBS:cmos_ieee
LIBS:dc-dc
LIBS:diode
LIBS:elec-unifil
LIBS:ESD_Protection
LIBS:ftdi
LIBS:gennum
LIBS:hc11
LIBS:ir
LIBS:Lattice
LIBS:leds
LIBS:maxim
LIBS:mechanical
LIBS:microchip_dspic33dsc
LIBS:microchip_pic10mcu
LIBS:microchip_pic12mcu
LIBS:microchip_pic16mcu
LIBS:microchip_pic18mcu
LIBS:microchip_pic24mcu
LIBS:microchip_pic32mcu
LIBS:modules
LIBS:motor_drivers
LIBS:motors
LIBS:msp430
LIBS:nordicsemi
LIBS:nxp
LIBS:nxp_armmcu
LIBS:onsemi
LIBS:Oscillators
LIBS:Power_Management
LIBS:powerint
LIBS:pspice
LIBS:references
LIBS:relays
LIBS:rfcom
LIBS:sensors
LIBS:silabs
LIBS:stm8
LIBS:stm32
LIBS:supertex
LIBS:switches
LIBS:transf
LIBS:triac_thyristor
LIBS:ttl_ieee
LIBS:video
LIBS:wiznet
LIBS:Worldsemi
LIBS:Xicor
LIBS:zetex
LIBS:Zilog
LIBS:SolarClapboard-cache
EELAYER 25 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 2 2
Title ""
Date ""
Rev ""
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L CONN_01X34 J31
U 1 1 59C3EB0D
P 5900 3300
F 0 "J31" H 5900 5050 50  0000 C CNN
F 1 "Z5263CT-ND" V 6000 3300 50  0000 C CNN
F 2 "" H 5900 3300 50  0001 C CNN
F 3 "" H 5900 3300 50  0001 C CNN
	1    5900 3300
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR021
U 1 1 59C3F01A
P 5300 5350
F 0 "#PWR021" H 5300 5100 50  0001 C CNN
F 1 "GND" H 5300 5200 50  0000 C CNN
F 2 "" H 5300 5350 50  0001 C CNN
F 3 "" H 5300 5350 50  0001 C CNN
	1    5300 5350
	1    0    0    -1  
$EndComp
Wire Wire Line
	5700 2850 5300 2850
Wire Wire Line
	5300 2850 5300 5350
Wire Wire Line
	5700 3750 5300 3750
Connection ~ 5300 3750
Text HLabel 1300 3150 0    60   Input ~ 0
SCL
Text HLabel 1300 3300 0    60   Input ~ 0
SDA
Text HLabel 1300 3450 0    60   Input ~ 0
CS
Text HLabel 1300 3600 0    60   Input ~ 0
D/C
Text HLabel 1300 3750 0    60   Input ~ 0
RESET
Text HLabel 1300 3900 0    60   Input ~ 0
BUSY
Text HLabel 1300 4050 0    60   Input ~ 0
SCK
Text HLabel 1300 4200 0    60   Input ~ 0
MOSI
Text HLabel 1100 1750 0    60   Input ~ 0
VCC
Text HLabel 1300 4500 0    60   Input ~ 0
GND
$Comp
L GND #PWR022
U 1 1 59C401DC
P 1400 4600
F 0 "#PWR022" H 1400 4350 50  0001 C CNN
F 1 "GND" H 1400 4450 50  0000 C CNN
F 2 "" H 1400 4600 50  0001 C CNN
F 3 "" H 1400 4600 50  0001 C CNN
	1    1400 4600
	1    0    0    -1  
$EndComp
Wire Wire Line
	1300 4500 1400 4500
Wire Wire Line
	1400 4500 1400 4600
$Comp
L C_Small C12
U 1 1 59C4291C
P 1350 1850
F 0 "C12" H 1360 1920 50  0000 L CNN
F 1 "1uF" H 1450 1850 50  0000 L CNN
F 2 "Capacitors_SMD:C_1206_HandSoldering" H 1350 1850 50  0001 C CNN
F 3 "" H 1350 1850 50  0001 C CNN
F 4 "25V" H 1500 1750 60  0000 C CNN "Voltage"
	1    1350 1850
	1    0    0    -1  
$EndComp
$Comp
L C_Small C13
U 1 1 59C42B0E
P 1700 1850
F 0 "C13" H 1710 1920 50  0000 L CNN
F 1 "1uF" H 1800 1850 50  0000 L CNN
F 2 "Capacitors_SMD:C_1206_HandSoldering" H 1700 1850 50  0001 C CNN
F 3 "" H 1700 1850 50  0001 C CNN
F 4 "25V" H 1850 1750 60  0000 C CNN "Voltage"
	1    1700 1850
	1    0    0    -1  
$EndComp
$Comp
L L L1
U 1 1 59C42B41
P 2150 1750
F 0 "L1" V 2200 1750 50  0000 C CNN
F 1 "47uH" V 2100 1750 50  0000 C CNN
F 2 "Inductors_SMD:L_Coilcraft_XAL5030" H 2150 1750 50  0001 C CNN
F 3 "" H 2150 1750 50  0001 C CNN
F 4 "800mA" V 2150 1750 60  0001 C CNN "Current"
	1    2150 1750
	0    -1   -1   0   
$EndComp
$Comp
L C_Small C14
U 1 1 59C42C29
P 2500 1850
F 0 "C14" H 2510 1920 50  0000 L CNN
F 1 "2.2uF" H 2600 1850 50  0000 L CNN
F 2 "Capacitors_SMD:C_1206_HandSoldering" H 2500 1850 50  0001 C CNN
F 3 "" H 2500 1850 50  0001 C CNN
F 4 "50V" H 2650 1750 50  0000 C CNN "Voltage"
	1    2500 1850
	1    0    0    -1  
$EndComp
Wire Wire Line
	5350 3550 5700 3550
Wire Wire Line
	5350 3550 5350 3650
Wire Wire Line
	5350 3650 5700 3650
$Comp
L MBR0530 D3
U 1 1 59C42D63
P 3000 1750
F 0 "D3" H 3000 1850 50  0000 C CNN
F 1 "MBR0530" H 3000 1900 50  0000 C CNN
F 2 "Diodes_SMD:SOD-123" H 3000 1575 50  0001 C CNN
F 3 "" H 3000 1750 50  0001 C CNN
	1    3000 1750
	-1   0    0    1   
$EndComp
$Comp
L MBR0530 D5
U 1 1 59C42DD6
P 2500 2350
F 0 "D5" H 2500 2450 50  0000 C CNN
F 1 "MBR0530" H 2500 2250 50  0000 C CNN
F 2 "Diodes_SMD:SOD-123" H 2500 2175 50  0001 C CNN
F 3 "" H 2500 2350 50  0001 C CNN
	1    2500 2350
	0    -1   -1   0   
$EndComp
$Comp
L MBR0530 D4
U 1 1 59C42E25
P 2850 2150
F 0 "D4" H 2850 2250 50  0000 C CNN
F 1 "MBR0530" H 2850 2050 50  0000 C CNN
F 2 "Diodes_SMD:SOD-123" H 2850 1975 50  0001 C CNN
F 3 "" H 2850 2150 50  0001 C CNN
	1    2850 2150
	1    0    0    -1  
$EndComp
$Comp
L C_Small C15
U 1 1 59C42E6A
P 3350 1850
F 0 "C15" H 3360 1920 50  0000 L CNN
F 1 "1uF" H 3450 1850 50  0000 L CNN
F 2 "Capacitors_SMD:C_1206_HandSoldering" H 3350 1850 50  0001 C CNN
F 3 "" H 3350 1850 50  0001 C CNN
F 4 "50V" H 3500 1750 50  0000 C CNN "Voltage"
	1    3350 1850
	1    0    0    -1  
$EndComp
$Comp
L C_Small C16
U 1 1 59C42EC1
P 3150 2300
F 0 "C16" H 3160 2370 50  0000 L CNN
F 1 "1uF" H 3250 2300 50  0000 L CNN
F 2 "Capacitors_SMD:C_1206_HandSoldering" H 3150 2300 50  0001 C CNN
F 3 "" H 3150 2300 50  0001 C CNN
F 4 "50V" H 3300 2200 50  0000 C CNN "Voltage"
	1    3150 2300
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR023
U 1 1 59C43106
P 1350 2250
F 0 "#PWR023" H 1350 2000 50  0001 C CNN
F 1 "GND" H 1350 2100 50  0000 C CNN
F 2 "" H 1350 2250 50  0001 C CNN
F 3 "" H 1350 2250 50  0001 C CNN
	1    1350 2250
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR024
U 1 1 59C4344F
P 2500 2600
F 0 "#PWR024" H 2500 2350 50  0001 C CNN
F 1 "GND" H 2500 2450 50  0000 C CNN
F 2 "" H 2500 2600 50  0001 C CNN
F 3 "" H 2500 2600 50  0001 C CNN
	1    2500 2600
	1    0    0    -1  
$EndComp
Wire Wire Line
	1100 1750 2000 1750
Connection ~ 1350 1750
Connection ~ 1700 1750
Wire Wire Line
	2300 1750 2850 1750
Connection ~ 2500 1750
Wire Wire Line
	3150 1750 3750 1750
Wire Wire Line
	1350 1950 1350 2250
Wire Wire Line
	1700 1950 1700 2150
Wire Wire Line
	1700 2150 1350 2150
Connection ~ 1350 2150
Wire Wire Line
	2500 2500 2500 2600
Wire Wire Line
	2500 2200 2500 1950
$Comp
L GND #PWR025
U 1 1 59C435DC
P 3350 2000
F 0 "#PWR025" H 3350 1750 50  0001 C CNN
F 1 "GND" H 3350 1850 50  0000 C CNN
F 2 "" H 3350 2000 50  0001 C CNN
F 3 "" H 3350 2000 50  0001 C CNN
	1    3350 2000
	1    0    0    -1  
$EndComp
Wire Wire Line
	3350 1950 3350 2000
Connection ~ 2500 2150
Wire Wire Line
	2700 2150 2500 2150
Wire Wire Line
	3000 2150 3750 2150
Wire Wire Line
	3150 2150 3150 2200
Wire Wire Line
	3150 2400 3150 2600
Wire Wire Line
	3150 2600 2500 2600
Connection ~ 3150 2150
Connection ~ 3350 1750
Text Label 3550 1750 0    60   ~ 0
VGH
Text Label 3500 2150 0    60   ~ 0
PRVGL
$Comp
L Q_NMOS_GDS Q1
U 1 1 59C43D37
P 2700 1100
F 0 "Q1" V 2900 1150 50  0000 L CNN
F 1 "AO3418" V 2900 800 50  0000 L CNN
F 2 "TO_SOT_Packages_SMD:SOT-23" H 2900 1200 50  0001 C CNN
F 3 "" H 2700 1100 50  0001 C CNN
	1    2700 1100
	0    -1   1    0   
$EndComp
Wire Wire Line
	2700 900  3150 900 
Wire Wire Line
	2500 1200 2500 1750
Wire Wire Line
	2900 1200 3150 1200
Text Label 2950 1200 0    60   ~ 0
RESE
Text Label 2950 900  0    60   ~ 0
GDR
$Comp
L R_Small R10
U 1 1 59C44064
P 3050 1350
F 0 "R10" H 3080 1370 50  0000 L CNN
F 1 "2.2R 1%" H 3080 1310 50  0000 L CNN
F 2 "" H 3050 1350 50  0001 C CNN
F 3 "" H 3050 1350 50  0001 C CNN
	1    3050 1350
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR026
U 1 1 59C440D3
P 3050 1500
F 0 "#PWR026" H 3050 1250 50  0001 C CNN
F 1 "GND" H 3050 1350 50  0000 C CNN
F 2 "" H 3050 1500 50  0001 C CNN
F 3 "" H 3050 1500 50  0001 C CNN
	1    3050 1500
	1    0    0    -1  
$EndComp
Wire Wire Line
	3050 1500 3050 1450
Wire Wire Line
	3050 1250 3050 1200
Connection ~ 3050 1200
$Comp
L C_Small C17
U 1 1 59C44AA9
P 1250 6750
F 0 "C17" H 1260 6820 50  0000 L CNN
F 1 "1uF" H 1350 6750 50  0000 L CNN
F 2 "Capacitors_SMD:C_1206_HandSoldering" H 1250 6750 50  0001 C CNN
F 3 "" H 1250 6750 50  0001 C CNN
F 4 "25V" H 1400 6650 60  0000 C CNN "Voltage"
	1    1250 6750
	1    0    0    -1  
$EndComp
$Comp
L C_Small C18
U 1 1 59C44B40
P 1650 6750
F 0 "C18" H 1660 6820 50  0000 L CNN
F 1 "1uF" H 1750 6750 50  0000 L CNN
F 2 "Capacitors_SMD:C_1206_HandSoldering" H 1650 6750 50  0001 C CNN
F 3 "" H 1650 6750 50  0001 C CNN
F 4 "25V" H 1800 6650 60  0000 C CNN "Voltage"
	1    1650 6750
	1    0    0    -1  
$EndComp
$Comp
L C_Small C19
U 1 1 59C44B8C
P 2050 6750
F 0 "C19" H 2060 6820 50  0000 L CNN
F 1 "1uF" H 2150 6750 50  0000 L CNN
F 2 "Capacitors_SMD:C_1206_HandSoldering" H 2050 6750 50  0001 C CNN
F 3 "" H 2050 6750 50  0001 C CNN
F 4 "25V" H 2200 6650 60  0000 C CNN "Voltage"
	1    2050 6750
	1    0    0    -1  
$EndComp
$Comp
L C_Small C20
U 1 1 59C44BDF
P 2450 6750
F 0 "C20" H 2460 6820 50  0000 L CNN
F 1 "1uF" H 2550 6750 50  0000 L CNN
F 2 "Capacitors_SMD:C_1206_HandSoldering" H 2450 6750 50  0001 C CNN
F 3 "" H 2450 6750 50  0001 C CNN
F 4 "25V" H 2600 6650 60  0000 C CNN "Voltage"
	1    2450 6750
	1    0    0    -1  
$EndComp
$Comp
L C_Small C21
U 1 1 59C44C2D
P 2800 6750
F 0 "C21" H 2810 6820 50  0000 L CNN
F 1 "1uF" H 2900 6750 50  0000 L CNN
F 2 "Capacitors_SMD:C_1206_HandSoldering" H 2800 6750 50  0001 C CNN
F 3 "" H 2800 6750 50  0001 C CNN
F 4 "25V" H 2950 6650 60  0000 C CNN "Voltage"
	1    2800 6750
	1    0    0    -1  
$EndComp
$Comp
L C_Small C22
U 1 1 59C44C7C
P 3150 6750
F 0 "C22" H 3160 6820 50  0000 L CNN
F 1 "1uF" H 3250 6750 50  0000 L CNN
F 2 "Capacitors_SMD:C_1206_HandSoldering" H 3150 6750 50  0001 C CNN
F 3 "" H 3150 6750 50  0001 C CNN
F 4 "25V" H 3300 6650 60  0000 C CNN "Voltage"
	1    3150 6750
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR027
U 1 1 59C44CCD
P 1250 7000
F 0 "#PWR027" H 1250 6750 50  0001 C CNN
F 1 "GND" H 1250 6850 50  0000 C CNN
F 2 "" H 1250 7000 50  0001 C CNN
F 3 "" H 1250 7000 50  0001 C CNN
	1    1250 7000
	1    0    0    -1  
$EndComp
Wire Wire Line
	1250 7000 1250 6850
Wire Wire Line
	1650 6850 1650 6950
Wire Wire Line
	1250 6950 3150 6950
Connection ~ 1250 6950
Wire Wire Line
	2050 6950 2050 6850
Connection ~ 1650 6950
Wire Wire Line
	2450 6950 2450 6850
Connection ~ 2050 6950
Wire Wire Line
	2800 6950 2800 6850
Connection ~ 2450 6950
Wire Wire Line
	3150 6950 3150 6850
Connection ~ 2800 6950
Wire Wire Line
	1250 6650 1250 6300
Wire Wire Line
	1650 6650 1650 6300
Wire Wire Line
	2050 6650 2050 6300
Wire Wire Line
	2450 6650 2450 6300
Wire Wire Line
	2800 6650 2800 6300
Wire Wire Line
	3150 6650 3150 6300
Text Label 1250 6550 1    60   ~ 0
VGL
Text Label 2050 6550 1    60   ~ 0
VSH
Text Label 2450 6550 1    60   ~ 0
VGH2
Text Label 2800 6550 1    60   ~ 0
VSL
Text Label 3150 6550 1    60   ~ 0
VCOM
Text Label 1650 6550 1    60   ~ 0
VDD
NoConn ~ 5700 1650
NoConn ~ 5700 1750
NoConn ~ 5700 1850
NoConn ~ 5700 1950
NoConn ~ 5700 2050
NoConn ~ 5700 2150
NoConn ~ 5700 4550
NoConn ~ 5700 4650
NoConn ~ 5700 4750
NoConn ~ 5700 4850
NoConn ~ 5700 4950
Wire Wire Line
	5700 2250 5250 2250
Wire Wire Line
	5700 2350 5250 2350
Wire Wire Line
	5700 2450 5250 2450
Wire Wire Line
	5700 2550 5250 2550
Wire Wire Line
	5700 2650 5250 2650
Wire Wire Line
	5700 2750 5250 2750
Wire Wire Line
	5700 2950 5350 2950
Wire Wire Line
	5700 3050 5350 3050
Wire Wire Line
	5700 3150 5350 3150
Wire Wire Line
	5700 3250 5350 3250
Wire Wire Line
	5700 3350 5350 3350
Wire Wire Line
	5700 3450 5350 3450
Wire Wire Line
	5700 3850 5350 3850
Wire Wire Line
	5200 3950 5700 3950
Wire Wire Line
	5700 4050 5350 4050
Wire Wire Line
	5700 4150 5350 4150
Wire Wire Line
	5700 4250 5350 4250
Wire Wire Line
	5700 4350 5350 4350
Wire Wire Line
	5700 4450 5350 4450
Text Label 5350 2250 0    60   ~ 0
GDR
Text Label 5350 2350 0    60   ~ 0
RESE
Text Label 5350 2450 0    60   ~ 0
VGL
Text Label 5350 2550 0    60   ~ 0
VGH
Text Label 5350 2650 0    60   ~ 0
TSCL
Text Label 5350 2750 0    60   ~ 0
TSDA
Text Label 5350 2850 0    60   ~ 0
BS1
Text Label 5400 2950 0    60   ~ 0
BUSY
Text Label 5400 3050 0    60   ~ 0
~RES
Text Label 5400 3150 0    60   ~ 0
~D/C
Text Label 5400 3250 0    60   ~ 0
~CS
Text Label 5400 3350 0    60   ~ 0
SCK
Text Label 5400 3450 0    60   ~ 0
MOSI
Text Label 5400 3550 0    60   ~ 0
VCC
Text Label 5400 3650 0    60   ~ 0
VCC
Text Label 5400 3750 0    60   ~ 0
VSS
Text Label 5400 3850 0    60   ~ 0
VDD
Text Label 5400 3950 0    60   ~ 0
VPP
Text Label 5400 4050 0    60   ~ 0
VSH
Text Label 5400 4150 0    60   ~ 0
VGH2
Text Label 5400 4250 0    60   ~ 0
VSL
Text Label 5400 4350 0    60   ~ 0
PRVGL
Text Label 5400 4450 0    60   ~ 0
VCOM
Text Label 1200 1750 0    60   ~ 0
VCC
NoConn ~ 1300 3150
NoConn ~ 1300 3300
NoConn ~ 5250 2650
NoConn ~ 5250 2750
$Comp
L TEST_1P TP16
U 1 1 59CC61A6
P 1750 3750
F 0 "TP16" H 1750 3950 50  0000 C CNN
F 1 "TEST_1P" H 1750 3950 50  0001 C CNN
F 2 "Wire_Pads:SolderWirePad_single_1-2mmDrill" H 1950 3750 50  0001 C CNN
F 3 "" H 1950 3750 50  0001 C CNN
	1    1750 3750
	1    0    0    -1  
$EndComp
Wire Wire Line
	1300 4200 1900 4200
Wire Wire Line
	1300 4050 1850 4050
Wire Wire Line
	1300 3900 1800 3900
Wire Wire Line
	1300 3750 1750 3750
Wire Wire Line
	1300 3600 1700 3600
Wire Wire Line
	1300 3450 1650 3450
Text Label 1350 3900 0    60   ~ 0
BUSY
Text Label 1350 4200 0    60   ~ 0
MOSI
Text Label 1350 4050 0    60   ~ 0
SCK
Text Label 1350 3750 0    60   ~ 0
~RES
Text Label 1350 3600 0    60   ~ 0
~D/C
Text Label 1350 3450 0    60   ~ 0
~CS
$Comp
L TEST_1P TP12
U 1 1 59E046D1
P 1650 3450
F 0 "TP12" H 1650 3650 50  0000 C CNN
F 1 "TEST_1P" H 1650 3650 50  0001 C CNN
F 2 "Wire_Pads:SolderWirePad_single_1-2mmDrill" H 1850 3450 50  0001 C CNN
F 3 "" H 1850 3450 50  0001 C CNN
	1    1650 3450
	1    0    0    -1  
$EndComp
$Comp
L TEST_1P TP15
U 1 1 59E0474B
P 1700 3600
F 0 "TP15" H 1700 3800 50  0000 C CNN
F 1 "TEST_1P" H 1700 3800 50  0001 C CNN
F 2 "Wire_Pads:SolderWirePad_single_1-2mmDrill" H 1900 3600 50  0001 C CNN
F 3 "" H 1900 3600 50  0001 C CNN
	1    1700 3600
	1    0    0    -1  
$EndComp
$Comp
L TEST_1P TP17
U 1 1 59E04A7A
P 1800 3900
F 0 "TP17" H 1800 4100 50  0000 C CNN
F 1 "TEST_1P" H 1800 4100 50  0001 C CNN
F 2 "Wire_Pads:SolderWirePad_single_1-2mmDrill" H 2000 3900 50  0001 C CNN
F 3 "" H 2000 3900 50  0001 C CNN
	1    1800 3900
	1    0    0    -1  
$EndComp
$Comp
L TEST_1P TP18
U 1 1 59E04AD0
P 1850 4050
F 0 "TP18" H 1850 4250 50  0000 C CNN
F 1 "TEST_1P" H 1850 4250 50  0001 C CNN
F 2 "Wire_Pads:SolderWirePad_single_1-2mmDrill" H 2050 4050 50  0001 C CNN
F 3 "" H 2050 4050 50  0001 C CNN
	1    1850 4050
	1    0    0    -1  
$EndComp
$Comp
L TEST_1P TP19
U 1 1 59E04B2D
P 1900 4200
F 0 "TP19" H 1900 4400 50  0000 C CNN
F 1 "TEST_1P" H 1900 4400 50  0001 C CNN
F 2 "Wire_Pads:SolderWirePad_single_1-2mmDrill" H 2100 4200 50  0001 C CNN
F 3 "" H 2100 4200 50  0001 C CNN
	1    1900 4200
	1    0    0    -1  
$EndComp
$Comp
L TEST_1P TP29
U 1 1 59E05B20
P 1400 4500
F 0 "TP29" H 1400 4700 50  0000 C CNN
F 1 "TEST_1P" H 1400 4700 50  0001 C CNN
F 2 "Wire_Pads:SolderWirePad_single_1-2mmDrill" H 1600 4500 50  0001 C CNN
F 3 "" H 1600 4500 50  0001 C CNN
	1    1400 4500
	1    0    0    -1  
$EndComp
$Comp
L TEST_1P TP14
U 1 1 59E4F023
P 1700 1750
F 0 "TP14" H 1700 1950 50  0000 C CNN
F 1 "TEST_1P" H 1700 1950 50  0001 C CNN
F 2 "Wire_Pads:SolderWirePad_single_1-2mmDrill" H 1900 1750 50  0001 C CNN
F 3 "" H 1900 1750 50  0001 C CNN
	1    1700 1750
	1    0    0    -1  
$EndComp
$Comp
L TEST_1P TP23
U 1 1 59E8F351
P 3150 900
F 0 "TP23" H 3150 1100 50  0000 C CNN
F 1 "TEST_1P" H 3150 1100 50  0001 C CNN
F 2 "Wire_Pads:SolderWirePad_single_1-2mmDrill" H 3350 900 50  0001 C CNN
F 3 "" H 3350 900 50  0001 C CNN
	1    3150 900 
	1    0    0    -1  
$EndComp
$Comp
L TEST_1P TP24
U 1 1 59E8F46C
P 3150 1200
F 0 "TP24" H 3150 1400 50  0000 C CNN
F 1 "TEST_1P" H 3150 1400 50  0001 C CNN
F 2 "Wire_Pads:SolderWirePad_single_1-2mmDrill" H 3350 1200 50  0001 C CNN
F 3 "" H 3350 1200 50  0001 C CNN
	1    3150 1200
	1    0    0    -1  
$EndComp
$Comp
L TEST_1P TP26
U 1 1 59E8F4DC
P 3750 1750
F 0 "TP26" H 3750 1950 50  0000 C CNN
F 1 "TEST_1P" H 3750 1950 50  0001 C CNN
F 2 "Wire_Pads:SolderWirePad_single_1-2mmDrill" H 3950 1750 50  0001 C CNN
F 3 "" H 3950 1750 50  0001 C CNN
	1    3750 1750
	1    0    0    -1  
$EndComp
$Comp
L TEST_1P TP27
U 1 1 59E8F569
P 3750 2150
F 0 "TP27" H 3750 2350 50  0000 C CNN
F 1 "TEST_1P" H 3750 2350 50  0001 C CNN
F 2 "Wire_Pads:SolderWirePad_single_1-2mmDrill" H 3950 2150 50  0001 C CNN
F 3 "" H 3950 2150 50  0001 C CNN
	1    3750 2150
	1    0    0    -1  
$EndComp
$Comp
L TEST_1P TP28
U 1 1 59EAAE72
P 5200 3950
F 0 "TP28" H 5200 4150 50  0000 C CNN
F 1 "TEST_1P" H 5200 4150 50  0001 C CNN
F 2 "Wire_Pads:SolderWirePad_single_1-2mmDrill" H 5400 3950 50  0001 C CNN
F 3 "" H 5400 3950 50  0001 C CNN
	1    5200 3950
	1    0    0    -1  
$EndComp
$Comp
L TEST_1P TP11
U 1 1 59F570F7
P 1250 6300
F 0 "TP11" H 1250 6500 50  0000 C CNN
F 1 "TEST_1P" H 1250 6500 50  0001 C CNN
F 2 "Wire_Pads:SolderWirePad_single_1-2mmDrill" H 1450 6300 50  0001 C CNN
F 3 "" H 1450 6300 50  0001 C CNN
	1    1250 6300
	1    0    0    -1  
$EndComp
$Comp
L TEST_1P TP13
U 1 1 59F571F7
P 1650 6300
F 0 "TP13" H 1650 6500 50  0000 C CNN
F 1 "TEST_1P" H 1650 6500 50  0001 C CNN
F 2 "Wire_Pads:SolderWirePad_single_1-2mmDrill" H 1850 6300 50  0001 C CNN
F 3 "" H 1850 6300 50  0001 C CNN
	1    1650 6300
	1    0    0    -1  
$EndComp
$Comp
L TEST_1P TP20
U 1 1 59F57276
P 2050 6300
F 0 "TP20" H 2050 6500 50  0000 C CNN
F 1 "TEST_1P" H 2050 6500 50  0001 C CNN
F 2 "Wire_Pads:SolderWirePad_single_1-2mmDrill" H 2250 6300 50  0001 C CNN
F 3 "" H 2250 6300 50  0001 C CNN
	1    2050 6300
	1    0    0    -1  
$EndComp
$Comp
L TEST_1P TP21
U 1 1 59F572F8
P 2450 6300
F 0 "TP21" H 2450 6500 50  0000 C CNN
F 1 "TEST_1P" H 2450 6500 50  0001 C CNN
F 2 "Wire_Pads:SolderWirePad_single_1-2mmDrill" H 2650 6300 50  0001 C CNN
F 3 "" H 2650 6300 50  0001 C CNN
	1    2450 6300
	1    0    0    -1  
$EndComp
$Comp
L TEST_1P TP22
U 1 1 59F5737D
P 2800 6300
F 0 "TP22" H 2800 6500 50  0000 C CNN
F 1 "TEST_1P" H 2800 6500 50  0001 C CNN
F 2 "Wire_Pads:SolderWirePad_single_1-2mmDrill" H 3000 6300 50  0001 C CNN
F 3 "" H 3000 6300 50  0001 C CNN
	1    2800 6300
	1    0    0    -1  
$EndComp
$Comp
L TEST_1P TP25
U 1 1 59F57403
P 3150 6300
F 0 "TP25" H 3150 6500 50  0000 C CNN
F 1 "TEST_1P" H 3150 6500 50  0001 C CNN
F 2 "Wire_Pads:SolderWirePad_single_1-2mmDrill" H 3350 6300 50  0001 C CNN
F 3 "" H 3350 6300 50  0001 C CNN
	1    3150 6300
	1    0    0    -1  
$EndComp
$EndSCHEMATC
