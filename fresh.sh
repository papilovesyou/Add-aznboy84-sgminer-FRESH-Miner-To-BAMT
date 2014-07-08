#!/bin/sh
mine stop
sleep 5
cd /opt/miners/
git clone https://github.com/aznboy84/freshgpu sgminer-fresh
cd /opt/miners/sgminer-fresh
cp /opt/miners/sgminer-4.1.0-sph/ADL_SDK/* /opt/miners/sgminer-fresh/ADL_SDK/
make clean
sleep 5
chmod +x autogen.sh
./autogen.sh
sleep 2
CFLAGS="-O2 -Wall -march=native -I /opt/AMDAPP/include/" LDFLAGS="-L/opt/AMDAPP/lib/x86" ./configure --enable-opencl
sleep 5
make install
sleep 5
clear
cp example.conf /etc/bamt/aznboy84-fresh.conf
cd /etc/bamt/
patch /etc/bamt/bamt.conf <<.
116a118
> cgminer_opts: --api-listen --config /etc/bamt/aznboy84-fresh.conf
124a128
> # anzboy84 FRESH Freshcoin "FRSH"
129a134
> miner-aznboy84-fresh: 1
.
patch /opt/bamt/common.pl <<.
1477a1478,1480
> } elsif (\${\$conf}{'settings'}{'miner-aznboy84-fresh'}) {
> \$cmd = "cd /opt/miners/sgminer-fresh/;/usr/bin/screen -d -m -S sgminer-fresh /opt/miners/sgminer-fresh/sgminer \$args";
> \$miner = "sgminer-fresh";
.
cd /etc/bamt/
patch /etc/bamt/aznboy84-fresh.conf <<.
22c22
< "kernel" : "ckolivas,ckolivas,ckolivas",
---
> "kernel" : "fresh",
37,39c37,39
< "api-listen" : false,
< "api-mcast-port" : "4028",
< "api-port" : "4028",
---
> "api-listen": true,
> "api-port": "4028",
> "api-allow": "W:127.0.0.1",
>
.
echo 'aznboy84 Miner Installed.'
echo 'Please review your /etc/bamt/bamt.conf to enable.'
echo 'Configure /etc/bamt/aznboy84-fresh.conf with pool'
