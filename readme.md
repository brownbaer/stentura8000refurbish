# Stentura 8000 Refurbish 

This project is to help users refurbish older machine that have extremely basic serial connections and upgrade them to have a singular power and serial connection through an Arduino's USB port. 

Features of this project are:
- Bypassing faulty electronics on 6000, 8000, and XL models.
- Consolidating both power and serial connection through USB rather than a power plug + serial connector (with adapter)
- Cheapest build possible (without tools)
- Easiest build with least amount of technical knowledge required
- Ability to upgrade to additional features, such as a display, new case, SD card reader, etc.
- Uses TXbolt protocol by default 
- Works immediately with Plover and Plover2Cat, Alleycat, and other hobbyist steno software, and while untested, presumably works with professional software as well
 

The aim was to help make stenography more accessible to the community, especially those who are on limited incomes suffering from RSI or tendinitis issues and require lever machines to properly learn without encountering pain associated with switch keyboards. As someone who repairs older niche hobbyist machines (such as Singer/Brother/Toyota knitting machines) this also helps keep older machines in use for longer and a more viable option compared to newer models which is a huge barrier when they can easily cost thousands of dollars upfront - for a ***used one***.

This guide has been made with the expecation that the user has basic soldering, wiring, and coding skills. You don't have to be ***good*** at it, just enough to stick things together. 


## Hardware
| Module                                                                                                                                                                    | Approximate Price       |
|:--------------------------------------------------------------------------------------------------------------------------------------------------------------------------|:-------------|
| [Arduino ItsyBitsy 32u4 5V ](https://www.adafruit.com/product/3677) or any equivalent board - get one that comes with the usb cable if you can| $9.95 USD or less    |
| [CD74HC4067 - 16 Channel Analog Digital Multiplexer Breakout Board ] (https://www.amazon.ca/gp/product/B0BCGM84JZ) | $11.00 for 1, or $17 for 2 |
| [Header Pins, Male, 2.54mm, in a strip of at least 30 pins. Depending on your build you may use 90 degree angled  ones] (https://www.amazon.ca/dp/B00WS2R2L8/) | Around $10-15, depending on style |
| [Medium Breadboard with sticky backing] (https://www.amazon.ca/Breadboard-Solderless-Prototype-PCB-Board/dp/B07589R1Q3/) | $16 for 3 | 


You will also need: 
- Soldering Iron and tools/materials
- **A 10k resistor** 
- Female to Male Dupont jumper ribbon cables, a strip of at least 30 ***and/or*** other connecting cables like solid core, male to male dupont jumper cables, etc. 
- Philips screwdriver (bit size 1 and 2)
- Flat head screw driver (bit size 1 and 2)
- 0.35mm Hex Screw (or hex screwdriver that came with the machine to adjust the key sensitivity)

Optionally, you can also make the unit look nicer and the process a bit easier with a few extras:
- Old/clean pill bottle or sour cream container
- Mounting pins
- Superglue
- JST/whatever connectors, crimper
- Expansion Board TCA9548A I2C IIC Multiplexer Breakout Board
- Heat shrink wire tubes/sheathes
- SD card reader with micro SD card 
- 20x4 or 16x4 LCD screen
- Electrical or Medical Tape
- An M0 Express ItsyBitsy, ESP32 with bluetooth, etc. instead of the Itsybitsy 32u4 5v.
- etc.

## Dismantling the Stentura 8000
### Remove the case
Turn the unit over. Slide the battery out by grasping the back of it (by the hole for the tripod mount) and pulling it away from the machine.

Now, remove as many screws as possible. Eventually the bottom should start to fall away from the main unit when you attempt to lift the bottom case - You may have the plastic plugs at the back that are threaded through the case into the screen's contrast pots pop out - don't worry. Remove the bottom case (carefully) and unplug every ribbon cable or collection of cables from the motherboard that's attached to the bottom of the case - most cables are quite short and brittle, so be careful. This can be a bit difficult as you'll probably need to hold the case in one hand just above the mother board/floppy drive while unplugging everything you can find with the other. You may end up flipping the machine a few times to get everything disconnected. The display screen's cable is especially a pain to remove from the bottom. Unless the electronics still work and you are keen on keeping them you an be rough with everything except the small controller board on the top side of the machine which handles the inputs from the keys.

Replace the bottom case and flip the machine over. Pop the tabs just below the LCD screen and open the top like you would to adjust the key sensitivity. Make sure the screen's ribbon cable is unplugged, then slide/wiggle the entire piece housing the screen off. 

You should be able to to remove the mechanical parts and motherboard in one piece from the case at this point - if not, keep looking for screws you may have missed and remove them. The motherboard is held on to the mechanical part of the writer through 2 screws near the back - just look beside where the cable plugs are and you'll find them. Remove those and the motherboard should come off in one piece.

Throw all the bits, bobs, and screws into the old sourcream container or pill bottle. If you'll be reusing the case you'll need these.

> Note: Older models will probably have brittle and cracked old cases that fall apart the second you try to dismantle it. You should be able to super glue these pieces back on, replace it with bonding putty, or just make a new case all together. Don't feel bad if it completely falls apart in your hands.

### Remove any extraneous parts (Optional)
You can safely remove any part of the machine that does not; help the keys move, move the lever that raises the printing stamps/keys when the number bar is depressed, and any electronic connector or cable the controller circuit board on top of the printing keys is attached to. 

In my machine I removed as much as possible, including the paper roller motor, floppy drive, etc. You should keep the mounting plate on the bottom (where a tripod would have attached) regardless if you plan to use it as it creates a nice flat base for the machine to sit on. 

## Remove the Controller Circuit Board and Motherboard
The controller circuit board is the tiny green circuit board on the top of the machine. When removing this you want to be extremely careful not to cause any of the extremely tiny wires to snap. You may need to remove an extra part or two under the left  If you do... Well, I hope you like soldering and are **extremely** good at it.

Put this aside somewhere safe for now. 

> Note, Stenturas 6000s, 8000s, and XL variations may have one individual wire per key, for a total of around 25 wires. Models that came afterwards may use the Protege style where the controller board is larger and contains shift registers. If you have a model with this type of circuit board you'll only need to solder a few wires to the edge under the tape instead. You can read more about it here: https://hackaday.com/2015/07/06/stenography-yes-with-arduinos/

### Clean the Machine (Optional)
Scrub off old grease with papertowel or alcohol swabs. If you're lucky you'll get to clean off nicotine residue if the old owner was a smoker as well :V

## Resolder the Controller Board

You have two options with this. You can either pop the plug connector off the mobo (desolder it) and place it on something else like a perf board, then solder jumper cables, connecting cables, anything like that, or:

Cut every connecting wire off because you broke some while trying to wiggle it off the machine, dooming yourself to solder hell. 

When you remove the tape you'll see 24 square pads of solder with a small circle of solder as the 25th on the far right. From left to right, the solder pads are:

>GROUND,unused/skip,S,T,K,P,W,H,R,A,O,*,E,U,F,R,P,B,L,G,T,S,D,Z,#

If you are soldering new connections to the controller board take care not to remove too much solder, or to allow the solder to heat up completely. The small, copper leafs on the underside are what make contact with the key plates and send the electronics a signal that the key was pressed. If you do, flip the circuit board over and use a pair of tweezers to adjust it back. 

> Tip: Just solder a strip of 25 header pins (with jumper cables already attached) onto the controller board instead of trying to solder individual wires. They ***will*** break off no matter how careful you are and you'll have to just resolder it all again. 

If you are one of the blessed few who don't need to resolder the actual wiring then the plug follows nearly the same format. The pins should be arranged this way, but double check by tracing the number bar (#), ground, and first wire of each bank of keys. The ground can be one wire or several since there are 24 keys and 26 pins on the plug. Additionally the wires are so thin on the plug it's actually held down under a strip of insulated wiring. 

>(1 BLANK)# STKPWHRAO*EUFRPBLGTSDZ GRNDx1-3

### Reattach the Controller Board

Find the small screws that were holding the controller board above the keys and reattach it. Use some medical or electrical tape to cover the soldering if you did a terrible job.

## Set up the Arduino ItsyBitsy

[Download and install the Arduino IDE program] (https://www.arduino.cc/en/software)

Once you have that installed you'll need to install the board data. You can do so by following the steps on this page.

[Introducing ItsyBitsy 32u4 - Arduino IDE Setup] (https://learn.adafruit.com/introducting-itsy-bitsy-32u4/arduino-ide-setup)

While this is going on go ahead and place the ItsyBitsy onto one edge of the breadboard and the multiplexer on the other just behind it. Make sure the usb port is sticking out over the side. On a medium sized breadboard of 30 rows both should just barely fit. 

## Wire up the Multiplexer (Mux)

If you're following the default code then connect in this order:

| Arduino PIN                                                                                                                                                                    | Multiplexer PIN     |
|:--------------------------------------------------------------------------------------------------------------------------------------------------------------------------|:-------------|
| A0 | SIG  |
| A1 | S3 |
| A2 | S2 |
| A3 | S1 |
| A4 | S0 |
| Breadboard Ground Rail | EN |
| Breadboard 5v Power Rail | VCC |
| Breadboard Ground Rail | GND |

**Attach the 10k resistor between the SIG pin and the 5v power rail.** 

| Stentura Controller Board PIN/Solder Pad                                                                                                                                                                 | Multiplexer PIN     |
|:--------------------------------------------------------------------------------------------------------------------------------------------------------------------------|:-------------|
| First Wire/Solder Pad | Breadboard Ground Rail  |
| Second  | skip/do not attach any wires |
| S- | C0 |
| T- | C1 |
| K- | C2 |
| P- | C3 |
|etc...| |

Continue until all 16 channel pins on the multiplexer are filled, in steno order. 

Finally, attach the remaining controller board wires directly to the following Arduino pins:

| Stentura Controller Board PIN/Solder Pad                                                                                                                                                                 | Arduino PIN     |
|:--------------------------------------------------------------------------------------------------------------------------------------------------------------------------|:-------------|
| 5 | -L |
| 7 | -G |
| 9 | -T |
| 10 | -S |
| 11 | -D |
| 12 | -Z |
| 13 | # (number bar)| 


## Load the Code into the Arduino ItsyBitsy

[Follow the instructions on this page to load the code into the ItsyBitsy.] (https://learn.adafruit.com/introducting-itsy-bitsy-32u4/using-with-arduino-ide)

Close Arduino IDE. 

Open Plover and click Configure -> Machine. Switch it to TXbolt and check that the baud rate is at 9600 by default. Scan ports and select the one that the ItsyBitsy is on.

You're done!

Now just use your hex allen key or screwdriver to adjust the sensitivity of each key until you find a comfortable setting. 


# TO DO: 
- TROUBLESHOOTING SECTION
- add images
- add video?
- add code
