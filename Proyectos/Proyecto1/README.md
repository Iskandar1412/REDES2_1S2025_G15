# Manual Técnico Proyecto 1

## Comandos Generales

- G15 Para todos los dispositivos se aplicaron los siguientes comandos

```shell
enable
conf t
no ip domain-lookup
hostname <nombre>_G15 # <nombre> donde se nombraron los Switches capa 3 SW# mientras que los de capa 2 S<#>
do wr
```

## Direcciones IP

- Dirección IP 192.168.X.0/24</br>
- Dirección 10.0.X.0/24</br>

Como el grupo es 15 Quedarían: 

- 192.168.15.0/24</br>
- 10.0.15.0/24</br>

|VLAN|Cantidad Host|Dir IP|1° Dir Utilizable|n° Dir Utilizable|Dir Broadcast|CDR|
|---|---|---|---|---|---|---|
|15|30| 192.168.15.0    |192.168.15.1     |192.168.15.30   |192.168.15.31   |192.168.15.0/27   |
|25|30| 192.168.15.32   |192.168.15.33    |192.168.15.62   |192.168.15.63   |192.168.32.32/27  |
|35|30| 192.168.15.64   |192.168.15.65    |192.168.15.94   |192.168.15.95   |192.168.32.64/27  |
|45|30| 192.168.15.96   |192.168.15.97    |192.168.15.126  |192.168.15.127  |192.168.32.96/27  |
|55|30| 192.168.15.128  |192.168.15.129   |192.168.15.158  |192.168.15.159  |192.168.32.128/27 |
|65|30| 192.168.15.160  |192.168.15.161   |192.168.15.190  |192.168.15.191  |192.168.32.160/27 |


* 10.0.15.0/24

|Cantidad Host|Dir IP|1° Dir Utilizable|n° Dir Utilizable|Dir Broadcast|CDR|
|---|---|---|---|---|---|
|2| 10.0.15.0|10.0.15.1|10.0.15.2|10.0.15.3|10.0.15.0/30|
|2| 10.0.15.4|10.0.15.5|10.0.15.6|10.0.15.7|10.0.15.4/30|
|2| 10.0.15.8|10.0.15.9|10.0.15.10|10.0.15.11|10.0.15.8/30|
|2| 10.0.15.12|10.0.15.13|10.0.15.14|10.0.15.15|10.0.15.12/30|
|2| 10.0.15.16|10.0.15.17|10.0.15.18|10.0.15.19|10.0.15.16/30|
|2| 10.0.15.20|10.0.15.21|10.0.15.22|10.0.15.23|10.0.15.20/30|


## Rapid PVST (Todos los switches)

```shell
enable
conf t
spanning-tree mode rapid-pvst
do wr
```

## Switches IZQUIERDOS

```shell
# SW5
enable
conf t
int range fa 0/18-20
channel-group 1 mode active
exit
int port-channel 1
no shut
switchport trunk encapsulation dot1q
switchport mode trunk
switchport trunk allowed vlan 15,25
exit
int fa 0/21
switchport trunk encapsulation dot1q
switchport mode trunk
switchport trunk allowed vlan 15,25
exit
do wr
## VTP
enable
conf t
vtp version 2
vtp mode client
vtp domain redes2grupo15
vtp password redes2grupo15
do wr
-----------------------------------------------------
# SW8
enable
conf t
int range fa 0/18-20
channel-group 1 mode active
exit
int port-channel 1
no shut
switchport trunk encapsulation dot1q
switchport mode trunk
switchport trunk allowed vlan 15,25
exit
int fa 0/21
switchport trunk encapsulation dot1q
switchport mode trunk
switchport trunk allowed vlan 15,25
exit
int range fa 0/22-24
channel-group 2 mode active
exit
int port-channel 2
no shut
switchport trunk encapsulation dot1q
switchport mode trunk
switchport trunk allowed vlan 15,25
exit
do wr
## VTP
vtp version 2
vtp mode server
vtp domain redes2grupo15
vtp password redes2grupo15
do wr
## VLANS A CREAR
vlan 15
name VLAN_NARANJA_EDIFICIOIZQ
exit
vlan 25
name VLAN_VERDE_EDIFICIOIZQ
exit
do wr
-----------------------------------------------------
# SW7
enable
conf t
int fa 0/21
switchport trunk encapsulation dot1q
switchport mode trunk
switchport trunk allowed vlan 15,25
exit
int range fa 0/18-20
channel-group 3 mode active
exit
int port-channel 3
no shut
switchport trunk encapsulation dot1q
switchport mode trunk
switchport trunk allowed vlan 15,25
exit
do wr
## VTP
enable
conf t
vtp version 2
vtp mode client
vtp domain redes2grupo15
vtp password redes2grupo15
do wr
-----------------------------------------------------
# SW6
enable
conf t
int fa 0/21
switchport trunk encapsulation dot1q
switchport mode trunk
switchport trunk allowed vlan 15,25
exit
int range fa 0/18-20
channel-group 3 mode active
exit
int port-channel 3
no shut
switchport trunk encapsulation dot1q
switchport mode trunk
switchport trunk allowed vlan 15,25
exit
do wr
## VTP
enable
conf t
vtp version 2
vtp mode client
vtp domain redes2grupo15
vtp password redes2grupo15
do wr
## Switches Capa 2
enable
conf t
int range fa 0/1-2
switchport trunk encapsulation dot1q
switchport mode trunk
switchport trunk allowed vlan 15,25
exit
do wr
-----------------------------------------------------
# SW1
enable
conf t
int range gi 1/0/22-24
channel-group 2 mode active
exit
int port-channel 2
no shut
switchport mode trunk
switchport trunk allowed vlan 15,25
exit
do wr
## VTP
enable
conf t
vtp version 2
vtp mode client
vtp domain redes2grupo15
vtp password redes2grupo15
do wr
```

## Switches DERECHOS

```shell
# SW11
enable
conf t
int range fa 0/18-20
channel-group 1 mode desirable
exit
int port-channel 1
no shut
switchport trunk encapsulation dot1q
switchport mode trunk
switchport trunk allowed vlan 45,55
exit
int fa 0/21
switchport trunk encapsulation dot1q
switchport mode trunk
switchport trunk allowed vlan 45,55
exit
do wr
## VTP
enable
conf t
vtp version 2
vtp mode client
vtp domain redes2grupo15
vtp password redes2grupo15
do wr
-----------------------------------------------------
# SW12
enable
conf t
int range fa 0/18-20
channel-group 1 mode desirable
exit
int port-channel 1
no shut
switchport trunk encapsulation dot1q
switchport mode trunk
switchport trunk allowed vlan 45,55
exit
int fa 0/21
switchport trunk encapsulation dot1q
switchport mode trunk
switchport trunk allowed vlan 45,55
exit
int range fa 0/22-24
channel-group 2 mode desirable
exit
int port-channel 2
no shut
switchport trunk encapsulation dot1q
switchport mode trunk
switchport trunk allowed vlan 45,55
exit
do wr
## VTP
vtp version 2
vtp mode server
vtp domain redes2grupo15
vtp password redes2grupo15
do wr
## VLANS A CREAR
vlan 45
name VLAN_NARANJA_EDIFICIODER
exit
vlan 55
name VLAN_VERDE_EDIFICIODER
exit
do wr
-----------------------------------------------------
# SW9
enable
conf t
int fa 0/21
switchport trunk encapsulation dot1q
switchport mode trunk
switchport trunk allowed vlan 45,55
exit
int range fa 0/18-20
channel-group 3 mode desirable
exit
int port-channel 3
no shut
switchport trunk encapsulation dot1q
switchport mode trunk
switchport trunk allowed vlan 45,55
exit
do wr
## VTP
enable
conf t
vtp version 2
vtp mode client
vtp domain redes2grupo15
vtp password redes2grupo15
do wr
-----------------------------------------------------
# SW10
enable
conf t
int fa 0/21
switchport trunk encapsulation dot1q
switchport mode trunk
switchport trunk allowed vlan 45,55
exit
int range fa 0/18-20
channel-group 3 mode desirable
exit
int port-channel 3
no shut
switchport trunk encapsulation dot1q
switchport mode trunk
switchport trunk allowed vlan 45,55
exit
do wr
## VTP
enable
conf t
vtp version 2
vtp mode client
vtp domain redes2grupo15
vtp password redes2grupo15
do wr
## Switches Capa 2
enable
conf t
int range fa 0/1-2
switchport trunk encapsulation dot1q
switchport mode trunk
switchport trunk allowed vlan 15,25
exit
do wr
-----------------------------------------------------
# SW1
enable
conf t
int range gi 1/0/22-24
channel-group 2 mode desirable
exit
int port-channel 2
no shut
switchport mode trunk
switchport trunk allowed vlan 45,55
exit
do wr
## VTP
enable
conf t
vtp version 2
vtp mode client
vtp domain redes2grupo15
vtp password redes2grupo15
do wr
```

## Configuraciones Switches Capa 2

```shell
# Izquierdo
enable
conf t
int fa 0/24
switchport mode trunk
switchport trunk allowed vlan 15,25
exit
do wr
### S1
int range fa 0/1-2
switchport mode access
switchport access vlan 15
exit
do wr
### S2
int range fa 0/1-2
switchport mode access
switchport access vlan 25
exit
do wr
# Derecho
enable
conf t
int fa 0/24
switchport mode trunk
switchport trunk allowed vlan 45,55
exit
do wr
### S3
int range fa 0/1-2
switchport mode access
switchport access vlan 55
exit
do wr
### S4
int range fa 0/1-2
switchport mode access
switchport access vlan 45
exit
do wr
```

## OSPF

* 192.168.15.0/24

|VLAN|Cantidad Host|Dir IP|1° Dir Utilizable|n° Dir Utilizable|Dir Broadcast|CDR|
|---|---|---|---|---|---|---|
|15|30| 192.168.15.0    |192.168.15.1     |192.168.15.30   |192.168.15.31   |192.168.15.0/27   |
|25|30| 192.168.15.32   |192.168.15.33    |192.168.15.62   |192.168.15.63   |192.168.32.32/27  |
|35|30| 192.168.15.64   |192.168.15.65    |192.168.15.94   |192.168.15.95   |192.168.32.64/27  |
|45|30| 192.168.15.96   |192.168.15.97    |192.168.15.126  |192.168.15.127  |192.168.32.96/27  |
|55|30| 192.168.15.128  |192.168.15.129   |192.168.15.158  |192.168.15.159  |192.168.32.128/27 |
|65|30| 192.168.15.160  |192.168.15.161   |192.168.15.190  |192.168.15.191  |192.168.32.160/27 |

* 10.0.15.0/24

|Cantidad Host|Dir IP|1° Dir Utilizable|n° Dir Utilizable|Dir Broadcast|CDR|
|---|---|---|---|---|---|
|2| 10.0.15.0   |10.0.15.1   |10.0.15.2   |10.0.15.3    |10.0.15.0/30   |
|2| 10.0.15.4   |10.0.15.5   |10.0.15.6   |10.0.15.7    |10.0.15.4/30   |
|2| 10.0.15.8   |10.0.15.9   |10.0.15.10  |10.0.15.11   |10.0.15.8/30   |
|2| 10.0.15.12  |10.0.15.13  |10.0.15.14  |10.0.15.15   |10.0.15.12/30  |
|2| 10.0.15.16  |10.0.15.17  |10.0.15.18  |10.0.15.19   |10.0.15.16/30  |
|2| 10.0.15.20  |10.0.15.21  |10.0.15.22  |10.0.15.23   |10.0.15.20/30  |

```shell
# SW1
ip routing
int gi 1/1/2
no switchport
ip add 10.0.15.9 255.255.255.252
no shut
exit
int gi 1/1/3
no switchport
ip add 10.0.15.17 255.255.255.252
no shut
exit
int gi 1/1/1
no switchport
ip add 10.0.15.21 255.255.255.252
no shut
exit
do wr
## Asignación IP Routers
interface vlan 15
ip address 192.168.15.1 255.255.255.224
no shut
exit
interface vlan 25
ip address 192.168.15.33 255.255.255.224
no shut
exit
do wr
## Router OSPF
router ospf 1
network 10.0.15.8 0.0.0.3 area 0
network 10.0.15.16 0.0.0.3 area 0
network 10.0.15.20 0.0.0.3 area 0
network 192.168.15.0 0.0.0.31 area 0
network 192.168.15.32 0.0.0.31 area 0
exit
do wr
## IP HELPER
int vlan 15
ip helper-address 10.0.15.2
exit
int vlan 25
ip helper-address 10.0.15.2
exit
do wr
-----------------------------------------------------
# SW3 
ip routing
int gi 1/1/1
no switchport
ip add 10.0.15.14 255.255.255.252
no shut
exit
int gi 1/1/3
no switchport
ip add 10.0.15.18 255.255.255.252
no shut
exit
int gi 1/1/2
no switchport
ip add 10.0.15.26 255.255.255.252
no shut
exit
do wr
## Asignación IP Routers
interface vlan 45
ip address 192.168.15.97 255.255.255.224
no shut
exit
interface vlan 55
ip address 192.168.15.129 255.255.255.224
no shut
exit
do wr
## Router OSPF
router ospf 1
network 10.0.15.12 0.0.0.3 area 0
network 10.0.15.16 0.0.0.3 area 0
network 10.0.15.24 0.0.0.3 area 0
network 192.168.15.96 0.0.0.31 area 0
network 192.168.15.128 0.0.0.31 area 0
exit
do wr
## IP HELPER
int vlan 45
ip helper-address 10.0.15.6
exit
int vlan 55
ip helper-address 10.0.15.6
exit
do wr
-----------------------------------------------------
# SW4
ip routing
int gi 1/1/2
no switchport
ip add 10.0.15.10 255.255.255.252
no shut
exit
int gi 1/1/1
no switchport
ip add 10.0.15.13 255.255.255.252
no shut
exit
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
do wr
## Router OSPF
router ospf 1
network 10.0.15.8 0.0.0.3 area 0
network 10.0.15.12 0.0.0.3 area 0
network 10.0.15.0 0.0.0.3 area 0
network 10.0.15.4 0.0.0.3 area 0
exit
do wr
-----------------------------------------------------
# SW2
ip routing
int gi 1/1/1
no switchport
ip add 10.0.15.22 255.255.255.252
no shut
exit
int gi 1/1/2
no switchport
ip add 10.0.15.25 255.255.255.252
no shut
exit
do wr
## Router OSPF
router ospf 1
network 10.0.15.20 0.0.0.3 area 0
network 10.0.15.24 0.0.0.3 area 0
exit
do wr
```
