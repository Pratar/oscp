#!/bin/bash

for ip in $(seq 200 254); do
	ping -c 1 10.11.1.$ip | grep "bytes from"| cut -d" " -f4|cut -d":" -f1 &
done
