# Manual Técnico

## Comandos

#### Dominios e IP'S

#### VLAN

* VLAN 

Grupo 15 -> 6 (1 + 5)
```
// Primaria      -> 16
   - 192.168.16.0/24
// Básicos       -> 26
   - 192.168.26.0/24
// Diversificado -> 36
   - 192.168.36.0/24
```

#### Configuraciones Generales (Switches/Routers)

- hostname (SW< A >_G< B > - Switch/RT< A >_G< B > - Router)
- Server: redes2grupo<B> (tanto para nombre como para password)
    - Donde
        - A: Número Switch
        - B: # Grupo

```
enable // ingreso
conf t // configuración
no ip domain-lookup
hostname SW<A>_G15
do wr
```

#### Configuraciones Switches (Conectados a PC y otros switches)

- Ver cuales son los puertos conectados a PC (preferencia pc primeros y switches últimos valores)

```
interface range fastEthernet 0/2-24 // que del 2 en adelante no están conectados a dispositivos finales
switchport mode trunk
switchport trunk allowed vlan all
```

- En caso de las que están solo conectados entre switches (del 1 al 24) modo trunk
- Los que serán servidores solo los puertos que están conectados a los swiches con el modo trunk

#### VLAN (Creación -> En servidores únicamente)

```
vlan <#Vlan>
name <NOMBRE_VLAN>
```

```
vlan 16
name PRIMARIA
exit
vlan 26
name BASICOS
exit
vlan 36
name DIVERSIFICADO
exit
```

- Ver VLANS creadas
```
do sh vlan
```

#### Propagar VLAN (VTP Version 2)

* VTP2 VS VTP1 -> la 2 tiene autenticación

- Servidor 

```
vtp version 2
vtp mode server
vtp domain redes2grupo15
vtp password redes2grupo15
```

- Tranparentes (No se usarán)

```
vtp version 2
vtp mode transparent
vtp domain redes2grupo15
```

- Clientes

```
vtp version 2
vtp mode client
vtp domain redes2grupo15
vtp password redes2grupo15
```

#### Asignar VLAN a usuarios finales

```
interface fastEtherne 0/1 // En este caso los usuarios finales están en el 1 (no hay más equipos)
switchport mode access
switchport access vlan <VLAN>
```

- Ver status de vtp: do sh vtp status



### Configuracion de STP

Se configuro el stp a cada switch de la topologia, se configuro rapid-PVST a los switches de la parte izquierda (desde SW0_G15 a SW10_G15) y PVST a los switches de la parte derecha (desde SW20_G15 a SW30_G15). <br><br>
Los comandos utilizados para configurar el STP son los siguiente: <br><br>

```
enable
configure terminal
spanning-tree vlan 1 root primary
exit
wr
```
y para validar que se configuro correctamente se utilizo el siguiente comando: <br><br>
```
show spanning-tree
```

#### Configuracion de Rapid-PVST y PVST
los switches al configurarle el STP tienen por defecto el PVST, y para configurarle el Rapid-PVST se utilizaron los siguientes comandos. <br><br>

```
enable 
configure terminal
spanning-tree mode rapid-pvst
exit
wr
```

y para validar que se configuro correctamente se utilizo el siguiente comando: <br><br>
```
show spanning-tree
```

### Seguridad de Interfaces de red

Para mayor seguridad en la topologia se aplicaron politicas de seguridad sobre las interfaces de los equipos de la capa 2, por lo que se realizaron las siguientes politicas: <br><br>

#### Desactivar protocolos DTP

Se desactivo el protocolo DTP de los puertos troncales de los switches para que estos no cambien de modo troncal a modo acceso y provocar fallas de conectividad o seguridad.

<br>
Los comandos utilizados para desactivar este protocolo son los siguientes: <br><br>

```
enable 
configure terminal
interface Fa0/23
switchport mode trunk
switchport nonegotiate
end
write memory

```

 Y para validar si este protocolo ya esta desactivado se debe ejecutar el siguiente comando: <br> 

 ```
show interfaces Fa0/24 switchport 

```
Esto mostrara una salida similar a la siguiente 


 ```
Name: Fa0/24
Switchport: Enabled
Administrative Mode: trunk
Operational Mode: trunk
Administrative Trunking Encapsulation: dot1q
Operational Trunking Encapsulation: dot1q
Negotiation of Trunking: Off                <-------Validar off
Access Mode VLAN: 1 (default)
Trunking Native Mode VLAN: 1 (default)
Voice VLAN: none
Administrative private-vlan host-association: none
Administrative private-vlan mapping: none
Administrative private-vlan trunk native VLAN: none
Administrative private-vlan trunk encapsulation: dot1q
Administrative private-vlan trunk normal VLANs: none
Administrative private-vlan trunk private VLANs: none
Operational private-vlan: none
Trunking VLANs Enabled: All
Pruning VLANs Enabled: 2-1001
Capture Mode Disabled
Capture VLANs Allowed: ALL
Protected: false
Unknown unicast blocked: disabled
Unknown multicast blocked: disabled
Appliance trust: none

```

#### Activar el port-security de los puertos

Se activa el port-security unicamente en los puertos donde se conectan los dispositivos finales, ya que se utiliza para evitar dispositivos no autorizados, y asi tener una mejor seguridad en nuestra red.<br><br>

Los comandos utilizados son los siguientes: 

 ```
enable
configure terminal
interface Fa0/1
switchport mode access    
switchport port-security  
switchport port-security maximum 2  
switchport port-security violation restrict  
switchport port-security aging time 5 
exit
exit
wr

```

Para validar que se ejecutaron correctamente los comandos podemos utilizar el siguiente comando: <br>

 ```
show port-security interface Fa0/1 
```

Y obtendremos una salida similar a la siguiente: 

 ```
SW30_G15#show port-security interface Fa0/1 
%SYS-5-CONFIG_I: Configured from console by console

Port Security              : Enabled   <-- VEMOS QUE ESTA ACTIVO
Port Status                : Secure-up
Violation Mode             : Restrict
Aging Time                 : 5 mins
Aging Type                 : Absolute
SecureStatic Address Aging : Disabled
Maximum MAC Addresses      : 2
Total MAC Addresses        : 0
Configured MAC Addresses   : 0
Sticky MAC Addresses       : 0
Last Source Address:Vlan   : 0000.0000.0000:0
Security Violation Count   : 0 
```

#### Configurar port-security mac-address

Se activa el port-security mac-address en los puertos donde se conectan los dispositivos finales, para restringir el uso del puerto a un unico host, y asi tener una mejor seguridad en nuestra red.<br><br>

Los comandos utilizados son los siguientes: 

 ```
enable
configure terminal
interface Fa0/1   
switchport port-security  
switchport port-security maximum 1 
switchport port-security mac-address <dirección_MAC>
switchport port-security violation shutdown  
switchport no shutdown
exit
exit
write memory

```

Para ver la seguridad del puerto podemos utilizar el siguiente comando: <br>

 ```
show port-security interface Fa0/1 
```

Y obtendremos una salida similar a la siguiente: 

 ```
SW8_G15#show port-security interface Fa0/1 

Port Security              : Enabled
Port Status                : Secure-up
Violation Mode             : Shutdown
Aging Time                 : 5 mins
Aging Type                 : Absolute
SecureStatic Address Aging : Disabled
Maximum MAC Addresses      : 1
Total MAC Addresses        : 1
Configured MAC Addresses   : 1
Sticky MAC Addresses       : 0
Last Source Address:Vlan   : 0000.0000.0000:0
Security Violation Count   : 0
```

Para ver la dirección mac aprendida en el puerto podemos utilizar el siguiente comando: <br>

 ```
show port-security address 
```

Y obtendremos una salida similar a la siguiente: 

 ```
SW8_G15#show port-security address
               Secure Mac Address Table
-----------------------------------------------------------------------------
Vlan    Mac Address       Type                          Ports   Remaining Age
                                                                   (mins)
----    -----------       ----                          -----   -------------
  26    <dirección mac>   SecureConfigured              Fa0/1        -
-----------------------------------------------------------------------------
```