#!/bin/bash

# Define a log prefix for dropped packets
LOG_PREFIX="IPTables-Dropped: "

# Flush existing rules to start fresh
sudo iptables -F

# Set default policy to drop all incoming traffic
sudo iptables -P INPUT DROP
sudo iptables -P FORWARD DROP
sudo iptables -P OUTPUT ACCEPT

# Allow loopback interface (important for local processes)
sudo iptables -A INPUT -i lo -j ACCEPT
sudo iptables -A OUTPUT -o lo -j ACCEPT

# Allow incoming traffic on essential ports
sudo iptables -A INPUT -p tcp --dport 22 -j ACCEPT  # SSH
sudo iptables -A INPUT -p tcp --dport 80 -j ACCEPT  # HTTP
sudo iptables -A INPUT -p tcp --dport 443 -j ACCEPT # HTTPS

# Allow ping (ICMP Echo Requests) to check if the machine is reachable
sudo iptables -A INPUT -p icmp --icmp-type echo-request -j ACCEPT

# Allow incoming traffic from a specific IP address (Example: 192.168.0.126)
sudo iptables -A INPUT -s 192.168.0.126 -j ACCEPT

# Log dropped packets for further analysis
sudo iptables -A INPUT -j LOG --log-prefix "$LOG_PREFIX"

# Save the iptables configuration to persist after reboot
sudo iptables-save > /etc/iptables/rules.v4

# Display current iptables rules
sudo iptables -L -v -n
