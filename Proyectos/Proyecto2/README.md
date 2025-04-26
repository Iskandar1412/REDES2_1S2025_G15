# Manual Técnico
## Topología

### Completa

[](./img/TopologiaCompleta.png)

### Telecom 1

[](./img/Telecom.png)

### Redes Nacionales

[](./img/RedesNacionales.png)

### Conexiones Futuras

[](./img/ConexionesFuturas.png)

## Direcciones

### Telecom 1
### Redes Nacionales

| UTILIZADAS | RED | PRIMERA | ULTIMA | BROADCAST | MASCARA | WILDCARD | CIDR |
| --- | --- | --- | --- | --- | --- | --- | --- |
| VLAN 30 | 192.168.26.0 | 192.168.26.1 | 192.168.26.30 | 192.168.26.31 | 255.255.255.224 | 0.0.0.31 | /27 | 
| VLAN 40 | 192.168.26.32 | 192.168.26.33 | 192.168.26.62 | 192.168.26.63 | 255.255.255.224 | 0.0.0.31 | /27 | 
| MS2.1 - MS2.2 | 192.168.26.64 | 192.168.26.65 | 192.168.26.66 | 192.168.26.67 | 255.255.255.252 | 0.0.0.3 | /30 | 
| MS2.2 - MS2.4 | 192.168.26.68 | 192.168.26.69 | 192.168.26.70 | 192.168.26.71 | 255.255.255.252 | 0.0.0.3 | /30 | 
| MS2.4 - Rinalambrico | 192.168.26.72 | 192.168.26.73 | 192.168.26.74 | 192.168.26.75 | 255.255.255.252 | 0.0.0.3 | /30 | 
| MS2.1 - MS2.3 | 192.168.26.76 | 192.168.26.77 | 192.168.26.78 | 192.168.26.79 | 255.255.255.252 | 0.0.0.3 | /30 | 
| MS2.3 - R2.1 | 192.168.26.80 | 192.168.26.81 | 192.168.26.82 | 192.168.26.83 | 255.255.255.252 | 0.0.0.3 | /30 | 
| S2.1 - MS2.1 | 192.168.26.84 | 192.168.26.85 | 192.168.26.86 | 192.168.26.87 | 255.255.255.252 | 0.0.0.3 | /30 | 


### Conexiones Futuras

| UTILZADAS | RED	| PRIMERA |	ULTIMA | BROADCAST |
| --- | --- | --- | --- | --- | 
| VLAN 50 | 192.168.36.0 | 192.168.36.1 | 192.168.36.62 | 192.168.36.63 |
| VLAN 60 | 192.168.36.64 | 192.168.36.65 | 192.168.36.126 | 192.168.36.127 |
| R3.1 | 192.168.36.128 | 192.168.36.129 | 192.168.36.130 | 192.168.36.131 |
| R3.2 | 192.168.36.132 | 192.168.36.133 | 192.168.36.134 | 192.168.36.135 |
| LACP5 | 192.168.36.136 | 192.168.36.137 | 192.168.36.138 | 192.168.36.139 |
| LACP6 | 192.168.36.140 | 192.168.36.141 | 192.168.36.142 | 192.168.36.143 |
| MS3.1 | 192.168.36.144 | 192.168.36.145 | 192.168.36.146 | 192.168.36.147 |


## Comandos Utilizados 

### Telecom 1

### Redes Nacionales

#### Configuraciones

> Multilayer Switch2.1 (Global)

```sh
ip routing

interface FastEthernet0/1
no switchport
ip address 192.168.26.86 255.255.255.252
duplex auto
speed auto

interface range FastEthernet0/2 - 4
no switchport
no ip address
channel-protocol lacp
channel-group 3 mode active
exit

interface range FastEthernet0/6 - 8
no switchport
no ip address
channel-protocol lacp
channel-group 4 mode active
exit

interface Port-channel3
no switchport
ip address 192.168.26.66 255.255.255.252
exit

interface Port-channel4
no switchport
ip address 192.168.26.77 255.255.255.252
exit

do wr
```

> VLAN 30

```sh
# Multilayer Switch2.2
interface FastEthernet0/1
no switchport
ip address 192.168.26.69 255.255.255.252
exit

interface range FastEthernet0/2 - 4
no switchport
no ip address
channel-protocol lacp
channel-group 3 mode active
exit

interface Port-channel3
no switchport
ip address 192.168.26.65 255.255.255.252
exit

router eigrp 2
network 192.168.26.68 0.0.0.3
network 192.168.26.64 0.0.0.3
auto-summary
exit

do wr

# Multilayer Switch2.4
interface FastEthernet0/1
no switchport
ip address 192.168.26.70 255.255.255.252
exit

interface FastEthernet0/2
no switchport
ip address 192.168.26.73 255.255.255.252
exit

router eigrp 2
network 192.168.26.72 0.0.0.3
network 192.168.26.0 0.0.0.31
network 192.168.26.68 0.0.0.3
no auto-summary
exit

do wr
```

- Configuración Wireless Router

![](./img/WirelessRouter.png)


> VLAN 40

```sh
# Multilayer Switch6
interface FastEthernet0/1
no switchport
ip address 192.168.26.81 255.255.255.252
exit

interface range FastEthernet0/6 - 8
no switchport
no ip address
channel-protocol lacp
channel-group 4 mode active
exit

interface Port-channel4
no switchport
ip address 192.168.26.78 255.255.255.252
exit

router eigrp 2
network 192.168.26.76 0.0.0.3
network 192.168.26.80 0.0.0.3
no auto-summary
exit

do wr

# Multilayer Switch2.5
interface Vlan30
mac-address 0006.2a35.c701
no ip address
exit

interface Vlan40
mac-address 0006.2a35.c702
ip address 192.168.26.33 255.255.255.224
exit

interface FastEthernet0/1
no switchport
ip address 192.168.26.82 255.255.255.252
exit

interface FastEthernet0/2
switchport access vlan 40
switchport trunk allowed vlan 40
switchport trunk encapsulation dot1q
switchport mode trunk
exit

router eigrp 2
network 192.168.26.80 0.0.0.3
network 192.168.26.32 0.0.0.31
auto-summary
exit

do wr

# Switch0
interface FastEthernet0/2
switchport trunk allowed vlan 30,40
switchport mode trunk
exit

interface range FastEthernet0/3 - 24
switchport access vlan 40
switchport mode access
exit

do wr
```

### Conexiones Futuras

#### Configuraciones

```sh
# Multilayer Switch3.1
interface range FastEthernet0/2 - 4
no switchport
no ip address
channel-protocol lacp
channel-group 5 mode active
exit

interface range FastEthernet0/5 - 7
no switchport
no ip address
channel-protocol lacp
channel-group 6 mode active
exit

interface Port-channel5
no switchport
ip address 192.168.36.138 255.255.255.252
ip helper-address 192.168.36.68
exit

interface Port-channel6
no switchport
ip address 192.168.36.142 255.255.255.252
ip helper-address 192.168.36.68
exit

router ospf 3
log-adjacency-changes
network 192.168.36.132 0.0.0.3 area 0
network 192.168.36.140 0.0.0.3 area 0
exit

do wr

# Multilayer Switch3.2
interface range FastEthernet0/2 - 4
no switchport
no ip address
channel-protocol lacp
channel-group 5 mode active
exit

interface Port-channel5
no switchport
ip address 192.168.36.137 255.255.255.252
ip helper-address 192.168.36.68
exit

interface GigabitEthernet0/1
no switchport
ip address 192.168.36.130 255.255.255.252
exit

router ospf 3
log-adjacency-changes
network 192.168.36.128 0.0.0.3 area 0
network 192.168.36.136 0.0.0.3 area 0
exit

do wr

# Router3.1
interface GigabitEthernet0/0
no ip address
duplex auto
speed auto
exit

interface GigabitEthernet0/0.50
encapsulation dot1Q 50
ip address 192.168.36.2 255.255.255.192
ip helper-address 192.168.36.68
standby 50 ip 192.168.36.1
standby 50 preempt
exit

interface GigabitEthernet0/0.60
encapsulation dot1Q 60
ip address 192.168.36.66 255.255.255.192
ip helper-address 192.168.36.68
standby 60 ip 192.168.36.65
standby 60 preempt
exit

interface GigabitEthernet0/1
ip address 192.168.36.129 255.255.255.252
ip helper-address 192.168.36.68
duplex auto
speed auto
exit

router ospf 3
log-adjacency-changes
network 192.168.36.0 0.0.0.63 area 0
network 192.168.36.64 0.0.0.63 area 0
network 192.168.36.128 0.0.0.3 area 0
exit

do wr

# Multilayer Switch3.3
interface FastEthernet0/5
no switchport
no ip address
channel-protocol lacp
channel-group 6 mode active
exit

interface Port-channel6
no switchport
ip address 192.168.36.141 255.255.255.252
ip helper-address 192.168.36.68
exit

interface GigabitEthernet0/1
no switchport
ip address 192.168.36.134 255.255.255.252
exit

router ospf 3
log-adjacency-changes
network 192.168.36.132 0.0.0.3 area 0
network 192.168.36.140 0.0.0.3 area 0
exit

do wr

# Router3.2
interface GigabitEthernet0/0
no ip address
duplex auto
speed auto
exit

interface GigabitEthernet0/0.50
encapsulation dot1Q 50
ip address 192.168.36.3 255.255.255.192
ip helper-address 192.168.36.68
standby 50 ip 192.168.36.1
standby 50 priority 110
standby 50 preempt
exit

interface GigabitEthernet0/0.60
encapsulation dot1Q 60
ip address 192.168.36.67 255.255.255.192
ip helper-address 192.168.36.68
standby 60 ip 192.168.36.65
standby 60 priority 110
standby 60 preempt
exit

interface GigabitEthernet0/1
ip address 192.168.36.133 255.255.255.252
ip helper-address 192.168.36.68
duplex auto
speed auto
exit

router ospf 3
log-adjacency-changes
network 192.168.36.0 0.0.0.63 area 0
network 192.168.36.64 0.0.0.63 area 0
network 192.168.36.132 0.0.0.3 area 0
exit

do wr

# Switch3.1
interface range FastEthernet0/1 - 10
switchport mode trunk
exit

interface range FastEthernet0/11 - 16
switchport access vlan 50
switchport mode access
exit

interface range FastEthernet0/17 - 24
switchport mode trunk
exit

do wr
```

