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
ip address 192.168.22.1 255.255.255.224
no shutdown
exit
interface vlan 40
ip address 192.168.22.33 255.255.255.224
no shutdown
exit
do wr

interface range fa0/2-4
no switchport
channel-protocol lacp
channel-group 3 mode active
exit
interface port-channel 3
no switchport
ip address 192.168.22.65 255.255.255.252
exit

interface range fa0/5-7
no switchport
channel-protocol lacp
channel-group 4 mode active
exit
interface port-channel 4
no switchport
ip address 192.168.22.69 255.255.255.252
exit
do wr

ip routing
router eigrp 15
network 192.168.22.0 0.0.0.31
network 192.168.22.32 0.0.0.31
network 192.168.22.64 0.0.0.3
network 192.168.22.68 0.0.0.3
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
no switchport
channel-protocol lacp
channel-group 3 mode active
exit
interface port-channel 3
no switchport
ip address 192.168.22.66 255.255.255.252
exit
do wr

int fa0/1
no switchport
ip address 192.168.22.73 255.255.255.252
exit
do wr

ip routing
router eigrp 15
network 192.168.22.72 0.0.0.3
network 192.168.22.64 0.0.0.3
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
no switchport
ip address 192.168.22.74 255.255.255.252
exit
do wr

int fa0/2
no switchport
ip address 192.168.22.85 255.255.255.252
exit
do wr

ip routing
router eigrp 15
network 192.168.22.72 0.0.0.3
network 192.168.22.84 0.0.0.3
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
no switchport
channel-protocol lacp
channel-group 4 mode active
exit
interface port-channel 4
no switchport
ip address 192.168.22.70 255.255.255.252
exit
do wr

int fa0/1
no switchport
ip address 192.168.22.77 255.255.255.252
exit
do wr

ip routing
router eigrp 15
network 192.168.22.68 0.0.0.3
network 192.168.22.76 0.0.0.3
no auto-summary
exit
do wr

! MS2.5

enable
conf t
no ip domain-lookup
hostname MS2.5
do wr

int fa0/1
no switchport
ip address 192.168.22.78 255.255.255.252
exit
do wr

int fa0/2
no switchport
ip address 192.168.22.81 255.255.255.252
exit
do wr

ip routing
router eigrp 15
network 192.168.22.80 0.0.0.3
network 192.168.22.76 0.0.0.3
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
no switchport
ip address 192.168.22.82 255.255.255.252
exit
do wr

int range fa0/3-24
switchport mode access
switchport access vlan 40
exit
do wr