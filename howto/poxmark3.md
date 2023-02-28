> Not finished yet

I recently bought a Bambulab X1 as I am possibly the bloodiest layman of 3D printing .. ever.

This machine uses RFID for filament detection and
[these RFIDs recently were analyzed](https://github.com/Bambu-Research-Group/RFID-Tag-Guide).

Hence I got curious and also bought the cheapest version of a Proxmark3 Easy at <https://amazon.de/> I could find.

But I am completely new to RFID as well.  I use RFID, but never had a reader.
Hence I write down how to get started etc.


# Proxmark3 Easy and Linux

> This is from Ubuntu 22.04 but probably loooks the same on Raspbian
>
> For all who buy a ProxMark3 can also buy a PI400 to get started with Linux to use the Proxmark3.
> Both are very similar in price, hence it only doubles the cost.  
> (Or you stay with your Windows, but then this here is not the right thing to do.)

The Proxmark3 Easy hardware bought probably is a China Clone.  It's packaging states:

```
Produkt: Leepesx Proxmark3 NF
Barcode: X001NMXE9B
Price:   ~70 EUR
Address: SOLID AUTHORITY LIMITED
         Woodfarm Cottages
         Kennelsford Road Upper
         Palmerstown
         Dublin 20
         Dublin
         Ireland
```

The packaging included a wrong USB cable.  Mini-USB was sent, needed is Micro-USB.
Not much of a problem, but "interesting" at this price tag.


## 1st step:  Disable ModemManager

I use Linux.  So **the first and apparently most important thing to do is to tame ModemManager**
as [given in the instructions](https://github.com/RfidResearchGroup/proxmark3/blob/master/doc/md/Installation_Instructions/ModemManager-Must-Be-Discarded.md):

```
mkdir -p /etc/systemd/system/ModemManager.service.d &&
cat >>/etc/systemd/system/ModemManager.service.d/proxmark3.conf <<EOF
[Service]
Environment="MM_FILTER_RULE_TTY_ACM_INTERFACE=0"
EOF
systemctl daemon-reload
systemctl restart ModemManager
```

Then test it (important!):

```
mmcli -G DEBUG
journalctl -f|grep "ModemManager.*\[filter\]"
```

Plug in the Proxmark3 to USB, you must see something like:

```
Feb 28 16:56:31 hostname ModemManager[484698]: <debug> [filter] (tty/ttyACM0) port filtered: forbidden
```

If you do not see the `forbidden` something is wrong.  
Unplug, interrupt `journalctl` (read: Press `Ctrl+C`) , and try again.  
Be sure to follow each step in exactly the shown sequence.


## 2nd Step:  Look into `dmesg`

Run

```
dmesg -w
```

and then plug in the Proxmark3 USB cable.  You will see something like

```
[1879538.773901] usb 1-3: new full-speed USB device number 39 using xhci_hcd
[1879539.031427] usb 1-3: New USB device found, idVendor=2d2d, idProduct=504d, bcdDevice= 0.01
[1879539.031432] usb 1-3: New USB device strings: Mfr=1, Product=0, SerialNumber=0
[1879539.031433] usb 1-3: Manufacturer: proxmark.org
[1879539.051484] cdc_acm 1-3:1.0: ttyACM0: USB ACM device
```

```
ls -al /dev/ttyACM0
```

gives

```
crw-rw---- 1 root dialout 166, 0 Feb 28 18:15 /dev/ttyACM0
```

```
id | grep dialout
```

should give something like (here `nonet` is the user ID):

```
uid=1001(nonet) gid=1001(nonet) groups=1001(nonet),20(dialout)
```

If `dialout` is missing, then you need to be added to the group:

```
sudo adduser `id -n` dialout
```

Important: After such changes you must logout and login to get the new group assigned.
