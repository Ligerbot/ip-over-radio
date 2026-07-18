echo "This script must be run with sudo"
echo "Enter callsign without any suffix (/qrp, -1, etc):"
read call
echo "Type sudo password and accept all when prompted"
sleep 0.5
apt update
apt install soundmodem ax25-*
sleep 1
echo "If prompted, enter sudo password to write config file /etc/ax25/soundmodem.conf"

cat > /etc/ax25/soundmodem.conf << EOF
<?xml version="1.0"?>
<modem>
 <configuration name="AX25">
  <chaccess txdelay="300" slottime="100" ppersist="40" fulldup="0" txtail="50"/>
  <audio type="alsa" device="pipewire" halfdup="1" capturechannelmode="Mono"/>
  <ptt file="none" gpio="0" hamlib_model="" hamlib_params=""/>
  <channel name="sm0">
   <mod mode="afsk" bps="1200" f0="1200" f1="2200" diffenc="1" inlv="8" fec="1" tunelen="32" synclen="32"/>
   <demod mode="afsk" bps="1200" f0="1200" f1="2200" diffdec="1" inlv="8" fec="3" mintune="16" minsync="16"/>
   <pkt mode="MKISS" ifname="sm0" hwaddr="$call-1" ip="10.0.0.1" netmask="255.255.255.0" broadcast="10.0.0.255" file="/dev/soundmodem0" unlink="1"/>
  </channel>
 </configuration>
</modem>
EOF

setcap cap_net_admin+ep /usr/sbin/soundmodem
echo "Setup finished. To start the ham radio network interface, run the following command (1200 baud will start as soon as command is run):"
echo "/sbin/soundmodem -v 5 -c AX25"
