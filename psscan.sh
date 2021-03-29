#!/bin/bash
if (( $# != 4 )); then
    >&2 echo "Illegal number of parameter"
    >&2 echo "Usage: psscan.sh <ip> <name> <interface>"
    exit 2
fi

echo "================================"
echo "Addres: $1"
echo "Name: $2"
echo "Interface: $3"
echo "================================"

tcp=$(sudo masscan -p1-65535 $1 --rate=1000 -e $3 |awk -F " " '{print $4}'|awk -F "/" '{print $1}'|sort -n|tr '\n' ','|sed 's/,$//')
[[ ! -z "$tcp" ]] && sudo nmap -Pn -sV -T5 -sC -p$tcp $1 -oA $2-tcp.txt || echo "Not TCP ports"
echo "================================"

udp=$(sudo masscan -pU:1-65535 $1 --rate=1000 -e $3 |awk -F " " '{print $4}'|awk -F "/" '{print $1}'|sort -n|tr '\n' ','|sed 's/,$//')
[[ ! -z "$udp" ]] && sudo nmap -Pn -sU -T5 -sV -sC -p$udp $1 -oA $2-udp.txt || echo "Not UDP ports"
echo "================================"
