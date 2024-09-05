#!/bin/bash

source .venv/bin/activate

# Path to your Python executable
PYTHON_EXECUTABLE=$(which python)

# Path to your Python script that manages the TUN/TAP device
SCRIPT_PATH="main_server.py"

NIC="tun0"
SUBNET="172.16.0.2/24"

# create the tun device
# sudo ip tuntap add dev $NIC mode tun

# sudo ip link set dev $NIC up

# sudo ip addr flush dev $NIC
# sudo ip addr add $SUBNET dev $NIC


# echo "Tun device $NIC created with ip address $SUBNET"

# get the ip address of the neverssl.com server using dig

sleep 1

sudo sysctl -w net.ipv4.ip_forward=1
sudo iptables -t nat -A POSTROUTING -s $SUBNET ! -d $SUBNET -j MASQUERADE

echo "Masquerading all packets from $SUBNET to the internet"

sudo $PYTHON_EXECUTABLE $SCRIPT_PATH --tun-name $NIC --port 8080

sudo ip tuntap del dev $NIC mode tun

echo "Tun device $NIC deleted"