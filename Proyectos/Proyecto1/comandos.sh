lo que hace el aux

192.168.2.0/24
192.168.1.0/24

# capa 2
enable
conf t
-- 
int fa0/1
switchport mode access
switchport access 10
exit
vlan 10 
exit
vlan 20 
exit
int fa0/2
switchport mode access
switchport access vlan 20
-- Configuración del modo trunkal en 3
(LACP)
int range fa 0/3-5
channel-group 1 mode active
exit
int port-channel 1
no shut
switchport mode trunk
switchport turnk allowed vlan 10,20
exit
do wr


# Capa 3
enable
conf t
int range fa0/3-5
port-channel 1 mode active
exit
int port-channel 1
no shut
switchport trunk encapsulation dot1q
switchport mode trunk
switchport trunk allowed vlan 10,20
exit
do wr
-- Entrutamiento capa 3
(se usa "ip routing") -- le dice al switch para enrutamiento
vlan 10 
exit
vlan 20
exit
int vlan 10 # como enrutamiento interfaces logicas
ip add 192.168.2.1 255.255.255.128
no shut
exit
int vlan 20
ip add 192.168.2.129 255.255.255.128
no shut
exit


# Configuración servidor
--- Crear primer pool para vlan 10
-- Services - DHCP
- Pool name: vlan10
- Default gateway: 192.168.2.1
- Start IP Address: 192.168.2.2
- Subnet Mask: 255.255.255.128
- Maximun Number of Users: 123
--- Crear segundo pool para vlan 20
-- Services - DHCP
- Pool name: vlan20
- Default gateway: 192.168.2.1
- Start IP Address: 192.168.2.129
- Subnet Mask: 255.255.255.128
- Maximun Number of Users: 123

-- Cambiar dirección IP al host (Desktop)
- IP Address: 192.168.1.2
- Subnet Mask: 255.255.255.0
- Default Gateway: 192.168.1.1

# Configuración Switch capa 3 (el mismo que el anterior)
enable
conf t
interface fa0/1
no switchport
ip add 192.168.1.1 255.25.255.0
no shut
exit
do wr
router ospf 2
network 192.168.1.0 0.0.0.255 area 0
network 192.168.2.0 0.0.0.127 area 0
network 192.168.2.128 0.0.0.127 area 0

int vlan 10
ip helper-address 192.168.1.2
exit
int vlan 20
ip helper-address 192.168.1.2