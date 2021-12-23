#!/bin/sh
OS_INFO=$(uname -a)
echo "# Architecture : $OS_INFO "
OS_INFO=$(cat /proc/cpuinfo | grep 'physical id' | wc -l)
echo "# Physical CPU : $OS_INFO"
OS_INFO=$(cat /proc/cpuinfo | grep 'processor' | wc -l)
echo "# vCPU : $OS_INFO"
TOTAL=$(free -m | grep 'Mem' | awk '{print $2}')
FREE=$(free -m | grep 'Mem' | awk '{print $4}')
PERCENT=$(free -m | grep 'Mem' | awk '{printf("%.2f", ($3*100/$2))}')
echo "# Memory Usage : $FREE/$TOTAL ($PERCENT%)"
TOTAL=$(df -Bg | grep 'LVMGroup' | awk '{SUM += $2} END {print SUM}')
FREE=$(df -Bm | grep 'LVMGroup' | awk '{SUM += $4} END {print SUM}')
PERCENT=$(df -Bg | grep 'LVMGroup' | awk '{SUM += $5} END {print SUM}')
echo "# Disk Usage : $FREE/$TOTAL""Gb ($PERCENT%)"
OS_INFO=$(mpstat | grep 'all' | awk '{print $6}')
echo "# CPU load : $OS_INFO%"
OS_INFO=$(who -b | awk '{print $3" "$4}')
echo "# Last boot : $OS_INFO"
OS_INFO=$(lsblk | grep 'lvm' | wc -l)
if [ $OS_INFO -eq 0 ]; then echo "# LVM use : no"
else echo "# LVM use : yes"
fi
OS_INFO=$(netstat -natp | grep 'tcp ' | grep 'LISTEN' | wc -l)
echo "# TCP Connections : $OS_INFO ESTABLISHED"
OS_INFO=$(users | wc -w)
echo "# User log : $OS_INFO"
OS_INFO=$(hostname -I)
MAC=$(ip a | grep 'link/ether' | awk '{print $2}')
echo "# Network : IP $OS_INFO($MAC)"
OS_INFO=$(cat /var/log/sudo/sudo.log | grep 'COMMAND=' | wc -l)
echo "# Sudo : $OS_INFO cmd"