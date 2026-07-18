# Ham Radio AX.25 stack setup

Assuming you have Debian 13, follow these steps:

```bash
sudo apt install soundmodem ax25-*
sudo nano /etc/ax25/soundmodem.conf
```

paste in the following to soundmodem.conf:
```xml
<?xml version="1.0"?>
<modem>
 <configuration name="AX25">
  <chaccess txdelay="300" slottime="100" ppersist="40" fulldup="0" txtail="50"/>
  <audio type="alsa" device="pipewire" halfdup="1" capturechannelmode="Mono"/>
  <ptt file="none" gpio="0" hamlib_model="" hamlib_params=""/>
  <channel name="sm0">
   <mod mode="afsk" bps="1200" f0="1200" f1="2200" diffenc="1" inlv="8" fec="1" tunelen="32" synclen="32"/>
   <demod mode="afsk" bps="1200" f0="1200" f1="2200" diffdec="1" inlv="8" fec="3" mintune="16" minsync="16"/>
   <pkt mode="MKISS" ifname="sm0" hwaddr="{your call and -2 appended to it}" ip="10.0.0.2" netmask="255.255.255.0" broadcast="10.0.0.255" file="/dev/soundmodem0" unlink="1"/>
  </channel>
 </configuration>
</modem>
```

run:

```bash
/sbin/soundmodem -v 5 -c AX25
```

if you get some error then try running:

```bash
sudo setcap cap_net_admin+ep /usr/sbin/soundmodem
```

and retrying the command before
now you should see "sm0" when you run sudo ifconfig. now your ham radio is a network interface if your audio input and output is connected to your radio
