! MS2.1

enable
conf t
no ip domain-lookup
hostname MS2.1
do wr

vlan 30
name RED30
vlan 40
name RED40
exit
do wr

ip routing

interface vlan 30
ip address 192.168.26.1 255.255.255.224
no shutdown
exit
interface vlan 40
ip address 192.168.26.33 255.255.255.224
no shutdown
exit
do wr

interface range fa0/2-4
no shut

channel-protocol lacp
channel-group 3 mode active
exit

interface port-channel 3
no shut

exit

interface range fa0/5-7
no shut

channel-protocol lacp
channel-group 4 mode active
exit

interface port-channel 4
no shut

exit
do wr

ip routing
router eigrp 15
network 192.168.26.0 0.0.0.31
network 192.168.26.32 0.0.0.31
no auto-summary
exit
do wr

! MS2.2

enable
conf t
no ip domain-lookup
hostname MS2.2
do wr

interface range fa0/2-4
no shut
switchport trunk encapsulation dot1q
switchport mode trunk
switchport trunk allowed vlan 30,40
channel-protocol lacp
channel-group 3 mode active
exit

interface port-channel 3
no shut
switchport trunk encapsulation dot1q
switchport mode trunk
switchport trunk allowed vlan 30,40
exit
do wr

int fa0/1
no shut
switchport trunk encapsulation dot1q
switchport mode trunk
switchport trunk allowed vlan 30,40
exit
do wr

! MS2.4

enable
conf t
no ip domain-lookup
hostname MS2.4
do wr

int fa0/1
switchport trunk encapsulation dot1q
switchport mode trunk
switchport trunk allowed vlan 30,40
exit
do wr

int fa0/2
switchport mode access
switchport access vlan 30
exit
do wr


! MS2.3

enable
conf t
no ip domain-lookup
hostname MS2.3
do wr

interface range fa0/5-7
no shut
switchport trunk encapsulation dot1q
switchport mode trunk
switchport trunk allowed vlan 30,40
channel-protocol lacp
channel-group 4 mode active
exit
interface port-channel 4
no shut
switchport trunk encapsulation dot1q
switchport mode trunk
switchport trunk allowed vlan 30,40
exit
do wr

int fa0/1
no shut
switchport trunk encapsulation dot1q
switchport mode trunk
switchport trunk allowed vlan 30,40
exit
do wr

! MS2.5

enable
conf t
no ip domain-lookup
hostname MS2.5
do wr

int fa0/1
no shut
switchport trunk encapsulation dot1q
switchport mode trunk
switchport trunk allowed vlan 30,40
exit
do wr

int fa0/2
no shut
switchport trunk encapsulation dot1q
switchport mode trunk
switchport trunk allowed vlan 30,40
exit
do wr

! S2.1

enable
conf t
no ip domain-lookup
hostname S2.1
do wr

int fa0/2
no shut
switchport mode trunk
switchport trunk allowed vlan 30,40
exit
do wr

int range fa0/3-24
switchport mode access
switchport access vlan 40
exit
do wr
