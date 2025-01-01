# Raspberry PI bluetooth

So you have installed a PI, booted it up and now you want to connect Mouse and Keyboard via Bluetooth.

But ..

.. it is a Raspberry PI Zero with nothing attached yet.  So you must do this via `ssh`, VNC or [Serial Console](console.md).

> I use the latter, because for some unknown reason the RPI imager is unable to activate wLAN correctly at my side.
> So the PI Zero has no network connection, hence the only way to connect is through Serial Console or something via OTG.

Then you do following as the logged in user (not `root`):

```
rfkill unblock bluetooth
service restart bluetooth
bluetoothctl
```

and in `bluetoothctl` enter:

```
power on
agent on
scan on
```

> Do not bother if commands like `rfkill` or `service start` or `agent on` fail because everything is already set up and running.
>
> If they fail because something else, then you have to resolve the problem first, of course.  Note that I **cannot help** you then!

Now put the device into discovery mode (usually long press of Bluetooth button until it starts blinking).

> I use a BT Mouse, just because I then can operate the desktop afterwards

You now will see something like

```
[NEW] Device AA:BB:CC:DD:EE:FF device name
```

The `AA:BB:CC:DD:EE:FF` is the MAC address of the device.  To pair it say:

```
pair  AA:BB:CC:DD:EE:FF
trust AA:BB:CC:DD:EE:FF
```

My mouse is immediately connected afterwards.  Now I can use the Desktop's method to connect the keyboard, because this involves entering of a PIN.
If this is needed, the "agent" tells you the PIN you need to enter.  If successful, the device then is paired.

Helpful commands in `bluethoothctl`:

- `devices` to list all paired devices

Notes:

- If you move the SD card to another PI, you need to repair, because each PI has a different Bluetooth MAC.
- So you must do this on the real target device.
