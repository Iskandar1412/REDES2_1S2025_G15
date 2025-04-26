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

interface vlan 30
ip address 192.168.26.1 255.255.255.224
no shutdown
exit
interface vlan 40
ip address 192.168.26.33 255.255.255.224
no shutdown
exit
do wr

interface fa0/1
no shut
no switchport
ip add 192.168.26.85 255.255.255.252
exit

interface range fa0/2-4
no shut
no switchport
channel-protocol lacp
channel-group 3 mode active
exit

interface port-channel 3
no shut
no switchport
ip add 192.168.26.65 255.255.255.252
exit

interface range fa0/5-7
no shut
no switchport
channel-protocol lacp
channel-group 4 mode active
exit

interface port-channel 4
no shut
no switchport
ip add 192.168.26.77 255.255.255.252
exit
do wr

ip routing
router eigrp 15
network 192.168.26.0 0.0.0.31
network 192.168.26.32 0.0.0.31
network 192.168.26.64 0.0.0.3
network 192.168.26.76 0.0.0.3
network 192.168.26.84 0.0.0.3
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
no switchport
channel-protocol lacp
channel-group 3 mode active
exit

interface port-channel 3
no shut
no switchport
ip add 192.168.26.66 255.255.255.252
exit
do wr

int fa0/1
no shut
no switchport
ip add 192.168.26.69 255.255.255.252
exit
do wr

ip routing
router eigrp 15
network 192.168.26.64 0.0.0.3
network 192.168.26.68 0.0.0.3
no auto-summary
exit
do wr

! MS2.4

enable
conf t
no ip domain-lookup
hostname MS2.4
do wr

int fa0/1
no shut
no switchport
ip add 192.168.26.70 255.255.255.252
exit
do wr

int fa0/2
no shut
no switchport
ip add 192.168.26.73 255.255.255.252
exit
do wr

ip routing
router eigrp 15
network 192.168.26.68 0.0.0.3
network 192.168.26.72 0.0.0.3
no auto-summary
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
no switchport
channel-protocol lacp
channel-group 4 mode active
exit
interface port-channel 4
no shut
no switchport
ip add 192.168.26.78 255.255.255.252
exit
do wr

int fa0/1
no shut
no switchport
ip add 192.168.26.81 255.255.255.252
exit
do wr

ip routing
router eigrp 15
network 192.168.26.76 0.0.0.3
network 192.168.26.80 0.0.0.3
no auto-summary
exit
do wr

! R2.1

enable
conf t
no ip domain-lookup
hostname R2.1
do wr

int gi0/1
no shut
ip add 192.168.26.82 255.255.255.252
exit
do wr

int gi0/0
no shut
exit
do wr

int gi0/0.30
no shut
encapsulation dot1Q 30
exit
do wr

int gi0/0.40
no shut
encapsulation dot1Q 40
exit
do wr

router eigrp 15
network 192.168.26.76 0.0.0.3
network 192.168.26.80 0.0.0.3
no auto-summary
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
