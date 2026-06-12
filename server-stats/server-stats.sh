#!/bin/bash

echo "========================================="
echo "        SERVER PERFORMANCE STATS"
echo "========================================="
echo

# -----------------------------------------
# CPU Usage
# -----------------------------------------
CPU_IDLE=$(top -bn1 | grep "Cpu(s)" | awk '{print $8}' | cut -d. -f1)
CPU_USAGE=$((100 - CPU_IDLE))

echo "CPU Usage:"
echo "Used: ${CPU_USAGE}%"
echo

# -----------------------------------------
# Memory Usage
# -----------------------------------------
MEM_TOTAL=$(free -m | awk '/Mem:/ {print $2}')
MEM_USED=$(free -m | awk '/Mem:/ {print $3}')
MEM_FREE=$(free -m | awk '/Mem:/ {print $4}')

MEM_PERCENT=$(awk "BEGIN {printf \"%.2f\", ($MEM_USED/$MEM_TOTAL)*100}")

echo "Memory Usage:"
echo "Total : ${MEM_TOTAL} MB"
echo "Used  : ${MEM_USED} MB"
echo "Free  : ${MEM_FREE} MB"
echo "Usage : ${MEM_PERCENT}%"
echo

# -----------------------------------------
# Disk Usage
# -----------------------------------------
DISK_TOTAL=$(df -h / | awk 'NR==2 {print $2}')
DISK_USED=$(df -h / | awk 'NR==2 {print $3}')
DISK_FREE=$(df -h / | awk 'NR==2 {print $4}')
DISK_PERCENT=$(df -h / | awk 'NR==2 {print $5}')

echo "Disk Usage:"
echo "Total : ${DISK_TOTAL}"
echo "Used  : ${DISK_USED}"
echo "Free  : ${DISK_FREE}"
echo "Usage : ${DISK_PERCENT}"
echo

# -----------------------------------------
# Top 5 CPU Consuming Processes
# -----------------------------------------
echo "Top 5 Processes by CPU Usage:"
ps -eo pid,user,%cpu,command --sort=-%cpu | head -n 6
echo

# -----------------------------------------
# Top 5 Memory Consuming Processes
# -----------------------------------------
echo "Top 5 Processes by Memory Usage:"
ps -eo pid,user,%mem,command --sort=-%mem | head -n 6
echo

# -----------------------------------------
# Stretch Goals
# -----------------------------------------
echo "Operating System:"
cat /etc/os-release | grep PRETTY_NAME | cut -d= -f2 | tr -d '"'
echo

echo "System Uptime:"
uptime -p
echo

echo "Load Average:"
uptime | awk -F'load average:' '{print $2}'
echo

echo "Logged In Users:"
who | awk '{print $1}' | sort | uniq
echo

echo "========================================="
echo "            END OF REPORT"
echo "========================================="