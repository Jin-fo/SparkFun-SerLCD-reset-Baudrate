# SerLCD v2.5 Overview

The SerLCD v2.5 is a simple and cost-effective solution for interfacing with Liquid Crystal Displays (LCDs) based on the HD44780 controller. The display settings are stored in onboard EEPROM upon power-up. A series of ASCII-formatted characters are sent to communicate and configure various features on the LCD. A complete table of commands can be found in the **"SparkFun SerLCD v2.5 Application Note"** file or refer to **Serial Baud Example**.

## Notable Commands:

| Function               | Command |
|------------------------|---------|
| Set Baud rate to 9600  | `0x7C 0x0D` |
| Backlight Fully ON     | `0x7C 0x9D` |
| Reset to 9600 Baud     | `0x12` (send during first 500ms of boot-up) |

## Default Communication (9600, 8, 1, 1, N):

- **9600 baud**
- **8 bits of data**
- **1 start bit**
- **1 stop bit**
- **No parity**

### Used Model:
**Serial Enabled 20x4 LCD - Black on Green 5V, LCD-09568**

## Usage in ESE 280 and ESE 381

As of 2024, this specific model of **SerLCD v2.5** is used exclusively for **ESE 280** and **ESE 381**. For simplicity, the SerLCD will always operate using the default communication settings.

## Resetting the SerLCD in Case of Baud Rate Issues

During lab exercises, the SerLCD may receive random unknown signals(yolo-ing a transmission operation) that can change its baud rate, causing the device to become inoperable under the specified default conditions. 

Once the baud rate of the LCD changes, the controlling device must match the new baud rate; otherwise, communication is not possible. Resetting the SerLCD then becomes a guessing game of finding the correct baud rate. Once the correct baud rate is identified, the reset command can be sent to restore default settings.

## Alternative Reset Method:
### Software Reset:
To avoid baud rate mismatches, **send `CTRL-R` (`0x12`) at 9600 baud within the first 500ms of boot-up (while the splash screen is active)**. This will reset the device to its default communication settings.

### Emergency Hardware Reset: 
If you get OpenLCD stuck into an unknown baud rate, unknown I2C address, etc, there is a safety mechanism built-in. Tie the RX pin to ground and power up OpenLCD. You should see the splash screen 
then "System reset Power cycle me" and the backlight will begin to blink. Now power down OpenLCD and remove the RX/GND jumper. OpenLCD is now reset to 9600bps with a I2C address of 0x72. 
Note: This feature can be disabled if necessary. See *Ignore Emergency Reset* for more information.
