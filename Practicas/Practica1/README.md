# Manual Técnico

## Comandos

#### Dominios e IP'S

#### VLAN

* VLAN 

Grupo 15 -> 6 (1 + 5)
```
-- Lado Izquierdo
// Primaria      -> 16
   - 192.168.16.0/24
// Básicos       -> 26
   - 192.168.26.0/24
// Diversificado -> 36
   - 192.168.36.0/24
-- Lado Derecho
// Primaria      -> 46
   - 192.168.46.0/24
// Básicos       -> 56
   - 192.168.56.0/24
// Diversificado -> 66
   - 192.168.66.0/24
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

#### Configuración Secret (Servidor)

```
-- CONFIGURAR PASS MODO PRIVILEGIADO
enable
conf terminal
enable secret redes2grupo15
do wr

# CONFIGURAR PASSWORD PARA ACCESOS POR CONSOLA
line console 0
password redes2grupo15
login
exit

# CONFIGURAR PASSWORD PARA ACCESOS REMOTOS
line vty 0 4
password redes2grupo15
login
exit

# ENCRIPTAR CONTRASEÑAS VISIBLES
service password-encryption
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
# LADO IZQUIERDO
vlan 16
name PRIMARIA
exit
vlan 26
name BASICOS
exit
vlan 36
name DIVERSIFICADO
exit

# LADO DERECHO
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

#### Vlan en ROUTER

```
-- ROUTER IZQUIERDO
interface GigabitEthernet0/1.16
encapsulation dot1Q 16
ip address 192.168.16.1 255.255.255.0
exit
interface GigabitEthernet0/1.26
encapsulation dot1Q 26
ip address 192.168.26.1 255.255.255.0
exit
interface GigabitEthernet0/1.36
encapsulation dot1Q 36
ip address 192.168.36.1 255.255.255.0
exit
do wr

-- ROUTER DERECHO
interface GigabitEthernet0/1.46
encapsulation dot1Q 46
ip address 192.168.46.1 255.255.255.0
exit
interface GigabitEthernet0/1.56
encapsulation dot1Q 56
ip address 192.168.56.1 255.255.255.0
exit
interface GigabitEthernet0/1.66
encapsulation dot1Q 66
ip address 192.168.66.1 255.255.255.0
exit
do wr
```

### Configuración Redistribuciones

```
-- ROUTER LATERAL IZQUIERDO (OSPF)
router ospf 1
network 10.0.16.0 0.0.0.255 area 0
network 192.168.16.0 0.0.0.255 area 0
network 192.168.26.0 0.0.0.255 area 0
network 192.168.36.0 0.0.0.255 area 0
exit
do wr

-- ROUTER CENTRAL IZQUIERDO (OSPF/RIP)
interface GigabitEthernet0/0
ip address 10.0.16.2 255.255.255.0
exit

interface GigabitEthernet0/1
ip address 10.0.26.1 255.255.255.0
exit


router ospf 1
redistribute rip subnets 
network 10.0.16.0 0.0.0.255 area 0
exit

router rip
version 2
redistribute ospf 1 metric 1 
network 10.0.0.0
no auto-summary
exit
do wr

-- ROUTER CENTRAL DERECHO (RIP/EIGRP)
interface GigabitEthernet0/0
ip address 10.0.36.1 255.255.255.0
exit

interface GigabitEthernet0/1
ip address 10.0.26.2 255.255.255.0
exit


router eigrp 100
redistribute rip metric 1 0 1 1 1 
network 10.0.0.0
no auto-summary
exit

router rip
version 2
redistribute eigrp 100 metric 1 
network 10.0.0.0
no auto-summary
exit
do wr

-- ROUTER LATERAL DERECHO (EIGRP)
router eigrp 100
network 10.0.0.0
network 192.168.46.0
network 192.168.56.0
network 192.168.66.0
no auto-summary
exit
do wr
```

- Ver Protocolos

```
sh ip protocol
```

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

- Verificar port security
```
sh port-security interface 0/1
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

## Elección de Escenario con Mejor Convergencia


Se realizo un estudio para conocer cual es el mejor escenario de protocolo de spanning-tree, los resultados son los siguientes: <br>

| Escenario | Protocolo Spanning-tree | Primaria | Basicos | Diversificados |
|-----------|-------------------------|----------|---------|----------------|
|     1     | PVST (lado derecho)     |     5    |    5    |        5       |
|     2     | RPVST (lado izquierdo)  |     0    |    1    |        2       |

<br>

Segun los datos obtenidos por la tabla, se puede identificar que la mejor propuesta de protocolo de spanning-tree es el **RPVST**, debido a que su tiempo de convergencia comparado con el de PVST es bastante mas rapido.

Tomando en cuenta la eficiencia ya que el **PVST** requiere más recursos en el Swich, mientras que el **RPVST** utiliza menor cantidad de CPU.<br/>
Como conclusión el modo más rápido el el Rapid PVST ya que garantiza una red estable y sin bucles, mejorando la experiencia de los alumnos.