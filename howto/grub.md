# HowTo Grub2

## Console+Serial+KVM

On a VM it is good to have a fallback serial console, to be able to access the console of a VM via commandline (`virsh console $DOMAIN`) as well as via `virt-manager` graphically, just in case.

`/etc/default/grub`

```
GRUB_CMDLINE_LINUX="console=tty0 console=ttyS0,115200n8"
GRUB_SERIAL_COMMAND="serial --speed=115200 --unit=0 --word=8 --parity=no --stop=1"
GRUB_TERMINAL="console serial"
```

```
update-grub
systemctl enable serial-getty@ttyS0.service
systemctl start  serial-getty@ttyS0.service
```

### VM settings

You need to have a serial line configured in your VM (`virsh edit $DOMAIN`):

```
<domain type='kvm'>
  <devices>
[..]
    <serial type='pty'>
      <target port='0'/>
    </serial>
    <console type='pty'>
      <target type='serial' port='0'/>
    </console>
[..]
  </devices>
</domain>
```

Note: I do not know it this suffices.  Perhaps there is a bit more XML configuration needed.
