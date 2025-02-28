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

## Rapid PVST (Todos los switches)

```shell
enable
conf t
spanning-tree mode rapid-pvst
do wr
```

# Switches IZQUIERDOS

```shell
# SW5
enable
conf t
int range fa 0/18-20
channe-group 1 mode active
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
ip routing
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

# Switches DERECHOS (FALTANTE)

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
ip routing
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
# SW3
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

# Configuraciones Switches Capa 2

```shell
# Izquierdo
enable
conf t
int fa 0/24
switchport mode trunk
switchport trunk allowed vlan 15,25
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
```

## Configuracion PAGP & LACP

Para los switches de arriba los que conectarán lateralmente con los otros edificios se aplicará

### PAGP Lado Derecho

```shell

```

### LACP Lado Izquierdo

```shell
# Router Inicial (SW8)

```

## Configuración VLAN
```shell

```

* VTP Clientes

```shell

```
