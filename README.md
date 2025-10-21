

# Overview

The SerLCD v2.5 is a simple and cost-effective solution for interfacing with Liquid Crystal Displays (LCDs) based on the HD44780 controller. The display settings are stored in onboard EEPROM upon power-up. A series of ASCII-formatted characters are sent to communicate and configure various features on the LCD. A complete table of commands can be found in the **"SparkFun SerLCD v2.5 Application Note"** file or refer to **Serial Baud Example**.
## Used Model:
**Serial Enabled 20x4 LCD - Black on Green 5V, LCD-09568**

#### Notable Commands:

| Function               | Command |
|------------------------|---------|
| Set Baud rate to 9600  | 0x7C, 0x0D |
| Backlight Fully ON     | 0x7C, 0x9D |
| Ignore RX ON/OFF       | 0x7C, 0x1A |
| Reset to 9600 Baud     | 0x12 (send during first 500ms of boot-up) |


## Default Communication (9600, 8, 1, 1, N):

- **9600 baud**
- **8 bits of data**
- **1 start bit**
- **1 stop bit**
- **No parity**



## Usage in ESE 280 and ESE 381

As of 2024, this specific model of **SerLCD v2.5** is used exclusively for **ESE 280** and **ESE 381**. For simplicity, the SerLCD will always operate using the default communication settings.

## Manual Rest Method:
During lab exercises, the SerLCD may receive random unknown signals(yolo-ing a transmission operation) that can change its baud rate, causing the device to become inoperable under the specified default conditions. 

Once the baud rate of the LCD changes, the controlling device must match the new baud rate; otherwise, communication is not possible. On power-on of the LCD, a start-up message will appear which include the baud rate of the LCD. Otherwise resetting the baud rate of the SerLCD then becomes a guessing game of finding the correct baud rate. Once the correct baud rate is identified, the controlling device can communicate the command to restore the default settings. 

## Alternative Reset Method:
### Program Software Reset:
To avoid baud rate mismatches, **send `CTRL-R` (`0x12`) at 9600 baud within the first 500ms of boot-up (while the splash screen is active)**. This will reset the device to its default communication settings.

### Direct Hardware Reset: 
The below methods require the LCD to be set with "Ignore RX OFF" which enable the RX pin to be shorted to ground. 

If you get OpenLCD stuck into an unknown baud rate, unknown I2C address, etc, there is a safety mechanism built-in. Connect the RX pin to GND of the LCD. Then connect another wire from the GND pin to the actual ground of the circuit. There should be two wires coming from GND of the LCD, one directly to connected to ground and another connected to the RX pin of the LCD. Now power on the LCD. 

You should see the splash screen rebooting the LCD to the default setting ending with a message: "System reset Power cycle me" and the backlight will begin to blink. Now power down OpenLCD and remove the RX/GND jumper. OpenLCD is now reset to 9600 Baud with a I2C address of 0x72. 

Note: This feature can be disabled. See *Ignore Emergency Reset* for more information.




