# LinuxEmbarque_ANOT_BEAUV
Projet 3eme année Linux Embarqué

le baud rate est à **115200**
# **1.3 Connexion au système**
Pour vous identifier :
  * login : root
  * password : aucun (vraiment rien, ne tapez que sur entrée)
    
L’image copiée précédemment n’occupe pas la totalité de la carte SD. 
Quelle est la taille occupée ? Utilisez la commande suivante :
```
df -h
```
> La taille est de : 

La carte dispose de l'adresse IP suivante :
> screen

Modification de /etc/network/interfaces de la manière suivante :
```
# interfaces(5) file used by ifup(8) and ifdown(8)
# Include files from /etc/network/interfaces.d:
source-directory /etc/network/interfaces.d
auto eth0
iface eth0 inet dhcp
allow-hotplug eth0
```
On observe bien **le ping** : 
> screen

# **1.4 Découverte de la cible**

Réalisez un programme "Hello World !"
```arm-linux-gnueabihf-gcc hello.c -o hello.o```
```**ici**```

Écrire un programme en C qui réalise un chenillard
```**ici**```







