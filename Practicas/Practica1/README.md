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

- hostname (SW<A>_G<B> - Switch/RT<A>_G<B> - Router)
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
