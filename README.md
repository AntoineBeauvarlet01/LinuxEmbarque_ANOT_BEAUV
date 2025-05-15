# LinuxEmbarque_ANOT_BEAUV
Projet 3ème année Linux Embarqué

Le baud rate est à **115200**
# **1.3 Connexion au système**
Pour vous identifier :
  * login : root
  * password : aucun (vraiment rien, ne tapez que sur entrée)
    
L’image copiée précédemment n’occupe pas la totalité de la carte SD. 
Quelle est la taille occupée ? Utilisez la commande suivante :
```
df -h
```
> La taille est de 1.3GB.

> ![image](https://github.com/user-attachments/assets/eb16d2da-06b8-4309-a20d-f0d9bd283e2d)

Nous avons augmenté la taille du système de fichiers :
> Initialement, on avait 3 GB de disponible. Notre carte a 4 GB de mémoire, donc l'effet n'a pas été très remarquable, nous sommes passés à 3.2 GB.

> ![image](https://github.com/user-attachments/assets/c782e170-60bb-4777-8841-f2b63583a6b1)


La carte dispose de l'adresse IP suivante :
> 127.0.0.1

> ![image](https://github.com/user-attachments/assets/1fff7dbf-9396-4703-bc70-93319a9d9706)


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
```
**ici**
```

Écrire un programme en C qui réalise un chenillard
```
**ici**
```


# 2 Modules kernel (TP2)




