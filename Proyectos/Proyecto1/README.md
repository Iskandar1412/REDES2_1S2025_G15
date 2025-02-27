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


## Configuracion PAGP & LACP

Para los switches de arriba los que conectarán lateralmente con los otros edificios se aplicará

### PAGP Lado Derecho

```shell
# Router Inicial (SW12)
enable
conf t
int range fa 0/22-24
channel-protocol pagp
channel-group 2 mode desirable
no shut
exit
do wr

# Segundo Router (SW3)
enable
conf t
int range gi 1/0/22-24
channel-protocol pagp
channel-group 2 mode auto
no shut
exit
do wr
```

### LACP Lado Izquierdo

```shell
# Router Inicial (SW8)
enable
conf t
int range fa 0/22-24
channel-protocol lacp
channel-group 1 mode active
no shut
exit
do wr

# Segundo Router (SW1)
enable
conf t
int range gi 1/0/22-24
channel-protocol lacp
channel-group 1 mode active
no shut
exit
do wr
```

## Configuración VLAN
```shell
# SW4
## Configuración VTP Server
enable
conf t
vtp mode server
vtp domain grupo15
vtp password grupo15
do wr
## Configuración VLAN
vlan 15
name VLAN_ADMIN
exit
do wr

# SW8
## Configuración VTP Server
enable
conf t
vtp mode server
vtp domain grupo15
vtp password grupo15
do wr
## Configuración VLAN
vlan 25
name VLAN_NARANJA_IZQ
exit
vlan 35
name VLAN_VERDE_IZQ
exit
do wr

# SW12
## Configuración VTP Server
enable
conf t
vtp mode server
vtp domain grupo15
vtp password grupo15
do wr
## Configuración VLAN
vlan 45
name VLAN_NARANJA_DER
exit
vlan 55
name VLAN_VERDE_DER
exit
do wr
```

## Configuración LACP/PAGP
```shell
# SW8
int range fa 0/22-24
switchport trunk encapsulation dot1q
channel-protocol lacp
switchport trunk allowed vlan 25,35
channel-group 1 mode active
exit
do wr

# SW1
int range gi 1/0/22-24
switchport mode trunk
channel-protocol lacp
switchport trunk allowed vlan 25,35
channel-group 1 mode active
exit
do wr

# SW12
int range fa 0/22-24
switchport trunk encapsulation dot1q
channel-protocol pagp
switchport trunk allowed vlan 45,55
channel-group 2 mode desirable
exit
do wr

# SW3
int range gi 1/0/22-24
switchport mode trunk
channel-protocol pagp
switchport trunk allowed vlan 45,55
channel-group 2 mode auto
exit
do wr
```