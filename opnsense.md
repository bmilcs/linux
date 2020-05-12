# BMiLCS | OPNsense

# NOTES
[- NO INTERNET? WAN ISSUES?](https://jrs-s.net/2020/01/19/why-cant-i-get-to-the-internet-on-my-new-opnsense-install/)


# DNS

## [Priority / Behavior](https://forum.opnsense.org/index.php?topic=6332.msg26912#msg26912)
1. DHCP Configured DNS OR Static ARP entries
1. If DHCP is blank, OPNsense's ip address is provided:
    - List upstream providers in "System > Settings > General"
    - DNS is then handled by either:
      - **DNSMASQ**:  Forwards all queries to upstream servers
      - **UNBOUND**:  Forwards all queries to upstream servers AND caches results

## [NAT REDIRECTION](https://docs.netgate.com/pfsense/en/latest/dns/redirecting-all-dns-requests-to-pfsense.html)

- **Firewall > NAT, Port Forward**
- Click (up ^ arrow) **ADD** 

SET | OPT
--|--  
Interface | LAN
Protocol | TCP/UP
Destination | *Invert Match* -> LAN Address
Dest. Port Range | 53 (DNS)
Redirect Target IP | 127.0.0.1
Target Port | 53 (DNS)
NAT Reflection | Disable
  


---
      










Change TCP/IP Stack for VMNic

    esxcli network ip interface ipv4 set --interface-name=vmk1 --type=static --ipv4=10.0.0.253 --netmask=255.255.255.0 --gateway=10.0.0.254
