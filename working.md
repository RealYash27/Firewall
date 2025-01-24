

# **Firewall Using `iptables` for Network Security**

## **1. Introduction**

This project aims to build a firewall on Kali Linux using `iptables` to enhance network security. The firewall setup is designed to control incoming traffic, allowing only specific services and IPs while blocking others. It also includes a logging mechanism to track dropped packets and provides a method to save configurations for persistence after reboot.

## **2. Prerequisites**

Before running the firewall script, ensure you have the following prerequisites:

- **Kali Linux** (or any Linux distribution that supports `iptables`)
- **Root (sudo) privileges** to configure firewall rules
- **`iptables`** utility installed (usually pre-installed on Kali Linux)
  
If `iptables` is not installed, install it using the following command:

```bash
sudo apt-get install iptables
```

## **3. Features**

### **3.1. Default Policies**

- The default policy for incoming and forwarding traffic is set to **DROP**, meaning all incoming and forwarded traffic is blocked unless explicitly allowed.
- The output traffic is allowed by default, ensuring your machine can initiate connections.

### **3.2. Loopback Interface Access**

- Traffic to and from the loopback interface (127.0.0.1) is allowed to ensure that local processes and services function correctly without interruption.

### **3.3. Service-Specific Rules**

- The firewall allows traffic on the following ports for essential services:
  - **SSH (Port 22)**: Allows remote access to the machine.
  - **HTTP (Port 80)**: Allows web traffic for unencrypted websites.
  - **HTTPS (Port 443)**: Allows secure web traffic for encrypted websites.

### **3.4. ICMP Echo Request**

- Ping (ICMP Echo Request) traffic is allowed to verify the availability of the firewall and to test network connectivity.

### **3.5. Allow Specific IP Addresses**

- The firewall allows incoming traffic from specific IP addresses. This feature is useful for restricting access to trusted machines while blocking others.

### **3.6. Logging Dropped Packets**

- The firewall logs dropped packets with a specific prefix, `IPTables-Dropped:`, in the system logs. This helps in tracking suspicious or unauthorized access attempts.

### **3.7. Persistent Configuration**

- After configuring the firewall, the settings are saved using `iptables-save` to ensure they persist across reboots.


4. **Check the Status**:
   After running the script, you can verify the active rules with:
   ```bash
   sudo iptables -L -v -n
   ```

## **5. Testing the Firewall**

To ensure the firewall is functioning correctly, use **Nmap** (from a different machine) to test open ports and services.

### **5.1. Ping Scan**

Check if the host is reachable:
```bash
nmap -sn <Kali_Linux_IP_Address>
```

### **5.2. Port Scan**

Scan for open ports (SSH, HTTP, HTTPS):
```bash
nmap -p 22,80,443 <Kali_Linux_IP_Address>
```

### **5.3. Service Version Detection**

Detect the versions of services running on open ports:
```bash
nmap -sV <Kali_Linux_IP_Address>
```

## **6. Analyzing the Logs**

To view dropped packets, check the system logs:
```bash
sudo cat /var/log/syslog | grep IPTables-Dropped
```
This will display logs of all packets that were dropped by the firewall.

## **7. Conclusion**

This project demonstrates how to configure a basic yet effective firewall using `iptables` on Kali Linux. The firewall is designed to allow specific services and IP addresses while blocking others, ensuring that the system remains secure from unauthorized access. The added feature of logging dropped packets helps in auditing and monitoring traffic for suspicious activity. The firewall configuration can be easily expanded to meet more complex security requirements, making it adaptable for various use cases.

## **8. Future Work**

- Integrate intrusion detection and prevention systems (IDS/IPS).
- Expand firewall rules to support more complex use cases, such as multi-layered security setups.
- Implement automated alerting based on specific logging patterns.

