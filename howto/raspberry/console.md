# Raspbeery PI console

In case of trouble or a headless system, you need to enable the console.

## Basics

For this you best need:

- A Raspberry PI with a Hat
- A serial debug cable
- or something similar

See below.  Then on another computer do:

```
screen /dev/ttyUSB0 115200
```

- If `screen` is missing use `sudo apt install screen` (on Debian/Raspbian.  The package usually is named `screen` everywhere)
- If you get a "Permission Denied" either use a user in the `dialout` group or run this as `root`

If serial console is properly configured and everything is properly connected, then you will be able to see some boot messages and be able to login to the PI.

Notes:

- By default the action key of Screen is `Ctrl+A`.  Some systems reconfigure this to `Ctrl+B` or something different.
  - Use `Ctrl+A d` to detach - the screen session continues to run in background!
  - Use `screen -r` to get back to the screen session
  - Use `Ctrl+A SPC` (the space bar) to switch to the next screen (in case there is any.  Those are on your local computer, not the PI!)
  - Use `Crtl+A k` to really kill the connection, so that the USB debug cable becomes free for another program
- Another way to get a serial terminal was (please do not ask me why this only works from commandline and needs these trainload of parameters)  
  `GDK_BACKEND=x11 putty /dev/ttyUSB0 -serial -sercfg 115200,8,n,1,N`


## How to enable the console

Sorry, I do not know yet!  Here are some hints:

Use `sudo raspbi-config`

- "3 Interface Options"
- "I5 Serial Port"
- chose `Yes`
- Reboot

To be able to do so I plugged the SD into a PI400 first, configured it, then shut down the PI400 and then plugged it into the PI Zero again.

> The same way I was able to enable the Wireless properly.  So after the PI400 was able to connect with the SD inserted, the PI Zero connected as well with the same SD.

I am pretty sure there must be a way to enable Serial Debug by changing some files on the SD card.
However how to do this changed recently, so the current Raspbian no more supports any of the old guides out there.


## How to correctly connect the USB debug cable

**WARNING!** Doing things improperly may kill your PI, your USB debug cable or the computer which is attached to the USB cable!

> If you break it, I am not responsible for this!  So only do this at your own risk!
> You have been warned that I might err and following my guide may harm your hardware!
> Also things out there may change any time, and I cannot make sure to update this here accordingly!

The first thing I did was to check the USB debug cable:

- Plug the USB side into my Laptop (it is running Linux)
- Now take some Multimeter and check, that there is 5V between the black and the red wire
- The red wire must be the positive side, the black wire must be GND

If this is OK, then tape the red wire away.  You usually do not need it!

> Only use the red wire if you need to power your PI.  This only works up to 2.5W, so you can only power low power devices like the PI Zero with it.
>
> And if your cable has a different wiring, be careful not to follow the coloring shown below, because you will likely destroy something.

Now on the Hat locate Pin 1.

- On the PI400 it is printed on the casing.
- On the PI Zero it is the one next to the SD card holder.  From below you see that the soldering point is square (all others are round).

Do not use the row of Pin 1.  Use the other row.  Start counting from Pin 1, though.  The sequence on the second row (starting from the column of Pin 1) is:

- Empty (do not connect Red here yet)
- Empty (do not connect Red here yet)
- Black
- White
- Green

Note that most pictures out there show White and Green in this sequence.
Some of my cables conforms to this, too.
But others (identical looking ones) have Green and White switched at my side.

I do not know which way is right and which cable is wrong.
So if the serial does not work, try to exchange Green and White.
**But never switch them with red or black and never switch red and black**
(as long as red is VCC and black is GND, as measured at first)!

> Test it!  Do not trust your cable!  Better double safe than sorry.

If you want to power up your PI Zero from the Debug cable, attach Red as the last cable.  You can use any of the two Empty slots, because both are VCC.

> If you do not want to power your PI from the cable, leave Red away.  It is not needed.
> You only need GND and the two data lanes.

Note that you might need to hit `Enter` (or Return) to see the Login prompt.

I first tested this on a PI400, then I adopted it to my PI Zero.  Just because the PI400 has a keyboard, so I was able to enter commands there until it worked.

> With some settings in `/boot/config.txt` you might affect the UART.
> Especially if you use something on SPI.
>
> In that case you will notice strange looking characters to be displayed.
> In that case you must either use SPI or the serial console, but not both.
> (Note that often they do not tell this.  Perhaps they just do not know or are very careless.)

## What cable do I use?

I really have no idea!  It's blue (as in the pictures of the Internet) but there is nothing printed on it.  And I bought two similar ones from different sources.

When connecting the cable following is shown in `suid dmesg`:

```
[631662.983719] usb 1-5: new full-speed USB device number 18 using xhci_hcd
[631663.133635] usb 1-5: New USB device found, idVendor=10c4, idProduct=ea60, bcdDevice= 1.00
[631663.133659] usb 1-5: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[631663.133667] usb 1-5: Product: CP2102 USB to UART Bridge Controller
[631663.133674] usb 1-5: Manufacturer: Silicon Labs
[631663.133679] usb 1-5: SerialNumber: 0001
[631663.137265] cp210x 1-5:1.0: cp210x converter detected
[631663.140021] usb 1-5: cp210x converter now attached to ttyUSB0
```

Perhaps look for `PI debug cable` on Amazon.  Please look very closely to the product before you buy!

- The cable or adapter should not be more expensive than 10 EUR
  - including shipping
- There are adapters out there using CP2102 like mine
  - These are recomended by me because this seems to be the best current chipset
  - Perhaps look elsewhere than on Amazon, because they want 30 EUR for this one, which is shady extortion!
- AFAICS you can buy CH340 adapters instead, too!
  - CH340 is an older chipset which is less compatible but should be fairly stable, too.
- **But stay away from adapters using PL2303!**
  - They seem to have extreme problems
  - Funny pricing here (all including shipping): 7 EUR for 1 cable, 9 EUR for 2 and 9 EUR for 3
- Also there seem to be may counterfait/fake products out there who are PL2303 but state they are something different
  - So be sure it is not a PL2303 by looking at the output (or Windows driver pane) when you plug it into your computer
  - **If it is a fake product, file a case for fraud at the Police!**  Then send the case id to Amazon, so they can expell this fake seller.
- Note that you might have problems using two of the cables on the same computer, because they all share the same USB serial number
