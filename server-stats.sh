#!/bin/bash

# Get total CPU load
cpu_load=$(top -bn1 | grep "Cpu(s)" | awk '{print $2}')
echo -e "\nTotal CPU load: $cpu_load%"

# Get total memory usage
mem_info=$(free -m)
total_mem=$(echo "$mem_info" | awk 'NR==2{print $2}')
used_mem=$(echo "$mem_info" | awk 'NR==2{print $3}')
free_mem=$(echo "$mem_info" | awk 'NR==2{print $7}')
mem_percent=$(echo "scale=2; $used_mem/$total_mem*100" | bc)
echo "Memory usage: $used_mem MB out of $total_mem MB ($mem_percent%)"

# Get total disk usage
disk_info=$(df -h /)
used_disk=$(echo "$disk_info" | awk 'NR==2{print $3}')
free_disk=$(echo "$disk_info" | awk 'NR==2{print $4}')
disk_percent=$(echo "$disk_info" | awk 'NR==2{print $5}')
echo "Disk usage: $used_disk out of $(echo "$disk_info" | awk 'NR==2{print $2}') ($disk_percent)"

# Top 5 processes by CPU load
echo -e "\nTop 5 processes by CPU load:"
ps -eo pid,%cpu,comm --sort=-%cpu | head -n 6

# Top 5 processes by memory usage
echo -e "\nTop 5 processes by memory usage:"
ps -eo pid,%mem,comm --sort=-%mem | head -n 6

# System information
os_version=$(uname -a)
uptime_info=$(uptime -p)
load_avg=$(uptime | awk '{print $10 $11 $12}')
user_count=$(who | wc -l)
failed_logins=$(grep "Failed password" /var/log/auth.log | wc -l)

echo -e "\nOS version: $os_version"
echo "Uptime: $uptime_info"
echo "Average load: $load_avg"
echo "Number of users in the system: $user_count"
echo "Failed login attempts: $failed_logins"
