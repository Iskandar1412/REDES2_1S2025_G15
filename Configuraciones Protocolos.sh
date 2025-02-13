
#PARA SWITCH CAPA 3
ena 
conf t 
ip routing
interface fa0/3
no switchport
ip address 192.168.10.1 255.255.255.0
no shutdown 
exit
do Write 


#RIP
route rip 
version 2
do show ip route #AGREGA TODAS LAS IP QUE APARECEN
network 10.0.10.0
do write 


#OSPF
router ospf 2
do show ip route
ip add
network 10.0.10.0 0.0.0.3 area 5
netwok 192.168.10.0 00.0.255 area 5
do write
exit

#EIGRP
ena 
conf t 
router eigrp 1 
do show ip route 
network 10.0.10.0 0.0.0.3
network 192.168.10.0 0.0.0.255
no auto-summary
do write




