# LADO IZQUIERDO
# SW4
enable
conf t
no ip domain-lookup
hostname SW4_G15
spanning-tree mode rapid-pvst
vtp version 2
vtp mode server
vtp domain grupo15
vtp password grupo15
vlan 15
name VLAN_NARANJA_IZQUIERDA
exit
vlan 25
name VLAN_VERDE_IZQUIERDA
exit
int range fa0/1-24
switchport trunk encapsulation dot1q
switchport mode trunk
switchport trunk allowed vlan all
exit
int range fa 0/22-24
channel-protocol lacp
channel-group 2 mode active
no shut
exit
int port-channel 2
switchport trunk encapsulation dot1q
switchport mode trunk
switchport trunk allowed vlan all
no shut
exit
int range fa 0/1-3
channel-protocol lacp
channel-group 3 mode active
no shut
exit
int port-channel 3
switchport trunk encapsulation dot1q
switchport mode trunk
switchport trunk allowed vlan all
no shut
exit
do wr

# SW1
enable
conf t
no ip domain-lookup
hostname SW1_G15
spanning-tree mode rapid-pvst
vtp version 2
vtp mode client
vtp domain grupo15
vtp password grupo15
int range fa0/1-24
switchport trunk encapsulation dot1q
switchport mode trunk
switchport trunk allowed vlan all
exit
int range fa 0/1-3
channel-protocol lacp
channel-group 3 mode active
no shut
exit
int port-channel 3
switchport trunk encapsulation dot1q
switchport mode trunk
switchport trunk allowed vlan all
no shut
exit
do wr

# SW3
enable
conf t
no ip domain-lookup
hostname SW3_G15
spanning-tree mode rapid-pvst
vtp version 2
vtp mode client
vtp domain grupo15
vtp password grupo15
int range fa0/1-24
switchport trunk encapsulation dot1q
switchport mode trunk
switchport trunk allowed vlan all
exit
int range fa 0/1-3
channel-protocol lacp
channel-group 4 mode active
no shut
exit
int port-channel 4
switchport trunk encapsulation dot1q
switchport mode trunk
switchport trunk allowed vlan all
no shut
exit
do wr

# SW2
enable
conf t
no ip domain-lookup
hostname SW2_G15
spanning-tree mode rapid-pvst
vtp version 2
vtp mode client
vtp domain grupo15
vtp password grupo15
int range fa0/1-24
switchport trunk encapsulation dot1q
switchport mode trunk
switchport trunk allowed vlan all
exit
int range fa 0/1-3
channel-protocol lacp
channel-group 4 mode active
no shut
exit
int port-channel 4
switchport trunk encapsulation dot1q
switchport mode trunk
switchport trunk allowed vlan all
no shut
exit
do wr

# S1
enable
conf t
no ip domain-lookup
hostname S1_G15
spanning-tree mode rapid-pvst
vtp version 2
vtp mode client
vtp domain grupo15
vtp password grupo15
int fa 0/24
switchport mode trunk
switchport trunk allowed vlan all
exit
int range fa 0/1-2
switchport mode access
switchport access vlan 15
exit
do wr

# S2
enable
conf t
no ip domain-lookup
hostname S2_G15
spanning-tree mode rapid-pvst
vtp version 2
vtp mode client
vtp domain grupo15
vtp password grupo15
int fa 0/24
switchport mode trunk
switchport trunk allowed vlan all
exit
int range fa 0/1-2
switchport mode access
switchport access vlan 25
exit
do wr

# LADO DERECHO
# SW12
enable
conf t
no ip domain-lookup
hostname SW12_G15
spanning-tree mode rapid-pvst
vtp version 2
vtp mode server
vtp domain grupo15
vtp password grupo15
vlan 45
name VLAN_NARANJA_DERECHA
exit
vlan 55
name VLAN_VERDE_DERECHA
exit
int range fa0/1-24
switchport trunk encapsulation dot1q
switchport mode trunk
switchport trunk allowed vlan all
exit
int range fa 0/22-24
channel-protocol pagp
channel-group 6 mode desirable
no shut
exit
int port-channel 6
switchport trunk encapsulation dot1q
switchport mode trunk
switchport trunk allowed vlan all
no shut
exit
int range fa 0/1-3
channel-protocol pagp
channel-group 7 mode desirable
no shut
exit
int port-channel 7
switchport trunk encapsulation dot1q
switchport mode trunk
switchport trunk allowed vlan all
no shut
exit
do wr

# SW11
enable
conf t
no ip domain-lookup
hostname SW11_G15
spanning-tree mode rapid-pvst
vtp version 2
vtp mode client
vtp domain grupo15
vtp password grupo15
int range fa0/1-24
switchport trunk encapsulation dot1q
switchport mode trunk
switchport trunk allowed vlan all
exit
int range fa 0/1-3
channel-protocol pagp
channel-group 7 mode desirable
no shut
exit
int port-channel 7
switchport trunk encapsulation dot1q
switchport mode trunk
switchport trunk allowed vlan all
no shut
exit
do wr

# SW9
enable
conf t
no ip domain-lookup
hostname SW9_G15
spanning-tree mode rapid-pvst
vtp version 2
vtp mode client
vtp domain grupo15
vtp password grupo15
int range fa0/1-24
switchport trunk encapsulation dot1q
switchport mode trunk
switchport trunk allowed vlan all
exit
int range fa 0/1-3
channel-protocol pagp
channel-group 8 mode desirable
no shut
exit
int port-channel 8
switchport trunk encapsulation dot1q
switchport mode trunk
switchport trunk allowed vlan all
no shut
exit
do wr

# SW10
enable
conf t
no ip domain-lookup
hostname SW10_G15
spanning-tree mode rapid-pvst
vtp version 2
vtp mode client
vtp domain grupo15
vtp password grupo15
int range fa0/1-24
switchport trunk encapsulation dot1q
switchport mode trunk
switchport trunk allowed vlan all
exit
int range fa 0/1-3
channel-protocol pagp
channel-group 8 mode desirable
no shut
exit
int port-channel 8
switchport trunk encapsulation dot1q
switchport mode trunk
switchport trunk allowed vlan all
no shut
exit
do wr

# S3
enable
conf t
no ip domain-lookup
hostname S1_G15
spanning-tree mode rapid-pvst
vtp version 2
vtp mode client
vtp domain grupo15
vtp password grupo15
int fa 0/24
switchport mode trunk
switchport trunk allowed vlan all
exit
int range fa 0/1-2
switchport mode access
switchport access vlan 55
exit
do wr

# S4
enable
conf t
no ip domain-lookup
hostname S2_G15
spanning-tree mode rapid-pvst
vtp version 2
vtp mode client
vtp domain grupo15
vtp password grupo15
int fa 0/24
switchport mode trunk
switchport trunk allowed vlan all
exit
int range fa 0/1-2
switchport mode access
switchport access vlan 45
exit
do wr

# CENTRO
# SW5
enable
conf t
no ip domain-lookup
hostname SW5_G15
vtp version 2
vtp mode client
vtp domain grupo15
vtp password grupo15
ip routing
int range gi 1/0/22-24
switchport mode trunk
switchport trunk allowed vlan all
channel-protocol lacp
channel-group 2 mode active
no shut
exit
int port-channel 2
switchport mode trunk
switchport trunk allowed vlan all
no shut
exit
int gi 1/1/1
no switchport
ip add 10.0.15.10 255.255.255.252
no shut
exit
int gi 1/1/2
no switchport
ip add 10.0.15.22 255.255.255.252
no shut
exit
int gi 1/1/3
no switchport
ip add 10.0.15.17 255.255.255.252
no shut
exit
int vlan 15
ip add 192.168.15.1 255.255.255.224
no shut
exit
int vlan 25
ip add 192.168.15.33 255.255.255.224
no shut
exit
router eigrp 15
network 10.0.15.8 0.0.0.3
network 10.0.15.20 0.0.0.3
network 10.0.15.16 0.0.0.3
network 192.168.15.0 0.0.0.31
network 192.168.15.32 0.0.0.31
no auto-summary
exit
int vlan 15
ip helper-address 10.0.15.2
ip helper-address 10.0.15.1
exit
int vlan 25
ip helper-address 10.0.15.2
ip helper-address 10.0.15.1
exit
do wr

# SW7
enable
conf t
no ip domain-lookup
hostname SW7_G15
vtp version 2
vtp mode client
vtp domain grupo15
vtp password grupo15
ip routing
int range gi 1/0/22-24
switchport mode trunk
switchport trunk allowed vlan all
channel-protocol pagp
channel-group 6 mode desirable
no shut
exit
int port-channel 6
switchport mode trunk
switchport trunk allowed vlan all
no shut
exit
int gi 1/1/1
no switchport
ip add 10.0.15.26 255.255.255.252
no shut
exit
int gi 1/1/2
no switchport
ip add 10.0.15.14 255.255.255.252
no shut
exit
int gi 1/1/3
no switchport
ip add 10.0.15.18 255.255.255.252
no shut
exit
int vlan 45
ip add 192.168.15.97 255.255.255.224
no shut
exit
int vlan 55
ip add 192.168.15.129 255.255.255.224
no shut
exit
router eigrp 15
no auto-summary
network 10.0.15.24 0.0.0.3
network 10.0.15.12 0.0.0.3
network 10.0.15.16 0.0.0.3
network 192.168.15.96 0.0.0.31
network 192.168.15.128 0.0.0.31
no auto-summary
exit
int vlan 45
ip helper-address 10.0.15.5
ip helper-address 10.0.15.6
exit
int vlan 55
ip helper-address 10.0.15.5
ip helper-address 10.0.15.6
exit
do wr

# SW6
enable
conf t
no ip domain-lookup
hostname SW6_G15
ip routing
int gi 1/1/1
no switchport
ip add 10.0.15.25 255.255.255.252
no shut
exit
int gi 1/1/2
no switchport
ip add 10.0.15.21 255.255.255.252
no shut
exit
vlan 35
name ADMINISTRADOR
exit
int vlan 35
ip add 192.168.15.65 255.255.255.224
exit
int gi 1/0/1
switchport mode access
switchport access vlan 35
exit
router eigrp 15
no auto-summary
network 10.0.15.24 0.0.0.3
network 10.0.15.20 0.0.0.3
network 192.168.15.64 0.0.0.31
no auto-summary
exit
do wr

# SW8
enable
conf t
no ip domain-lookup
hostname SW8_G15
ip routing
int gi 1/0/1
no switchport
ip add 10.0.15.1 255.255.255.252
no shut
exit
int gi 1/0/2
no switchport
ip add 10.0.15.5 255.255.255.252
no shut
exit
int gi 1/1/1
no switchport
ip add 10.0.15.9 255.255.255.252
no shut
exit
int gi 1/1/2
no switchport
ip add 10.0.15.13 255.255.255.252
no shut
exit
router eigrp 15
no auto-summary
network 10.0.15.0 0.0.0.3
network 10.0.15.4 0.0.0.3
network 10.0.15.8 0.0.0.3
network 10.0.15.12 0.0.0.3
no auto-summary
exit
do wr

# ACL
# SW5
enable
conf t
ip access-list extended VLAN15_ACL
 deny icmp 192.168.15.0 0.0.0.31 192.168.15.64 0.0.0.31 echo
 permit icmp 192.168.15.0 0.0.0.31 192.168.15.64 0.0.0.31 echo-reply
 deny ip 192.168.15.0 0.0.0.31 192.168.15.32 0.0.0.31
 deny ip 192.168.15.0 0.0.0.31 192.168.15.128 0.0.0.31
 permit ip any any
exit
ip access-list extended VLAN25_ACL
 deny icmp 192.168.15.32 0.0.0.31 192.168.15.64 0.0.0.31 echo
 permit icmp 192.168.15.32 0.0.0.31 192.168.15.64 0.0.0.31 echo-reply
 deny ip 192.168.15.32 0.0.0.31 192.168.15.0 0.0.0.31
 deny ip 192.168.15.32 0.0.0.31 192.168.15.96 0.0.0.31
 permit ip any any
exit
interface Vlan15
 ip access-group VLAN15_ACL in
exit
interface Vlan25
 ip access-group VLAN25_ACL in
exit
do wr

# SW7
enable
conf t
ip access-list extended VLAN45_ACL
 deny icmp 192.168.15.96 0.0.0.31 192.168.15.64 0.0.0.31 echo
 permit icmp 192.168.15.96 0.0.0.31 192.168.15.64 0.0.0.31 echo-reply
 deny ip 192.168.15.96 0.0.0.31 192.168.15.32 0.0.0.31
 deny ip 192.168.15.96 0.0.0.31 192.168.15.128 0.0.0.31
 permit ip any any
exit
ip access-list extended VLAN55_ACL
 deny icmp 192.168.15.128 0.0.0.31 192.168.15.64 0.0.0.31 echo
 permit icmp 192.168.15.128 0.0.0.31 192.168.15.64 0.0.0.31 echo-reply
 deny ip 192.168.15.128 0.0.0.31 192.168.15.0 0.0.0.31
 deny ip 192.168.15.128 0.0.0.31 192.168.15.96 0.0.0.31
 permit ip any any
exit
interface Vlan45
 ip access-group VLAN45_ACL in
exit
interface Vlan55
 ip access-group VLAN55_ACL in
exit
do wr