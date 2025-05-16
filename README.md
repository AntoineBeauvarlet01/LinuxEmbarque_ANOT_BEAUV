# LinuxEmbarque_ANOT_BEAUV
Projet 3DN - Linux embarqué

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
La taille est de 1.3GB.

> ![image](https://github.com/user-attachments/assets/eb16d2da-06b8-4309-a20d-f0d9bd283e2d)

Nous avons augmenté la taille du système de fichiers. Initialement, on avait 3 GB de disponible. Notre carte a 4 GB de mémoire, donc l'effet n'a pas été très remarquable, nous sommes passés à 3.2 GB.

> ![image](https://github.com/user-attachments/assets/c782e170-60bb-4777-8841-f2b63583a6b1)


La carte dispose de l'adresse IP 127.0.0.1.

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
Après la modification, notre adresse IP est 192.168.0.221.

> ![image](https://github.com/user-attachments/assets/f7f5e4dd-8efd-4623-a649-e4771ec72d2e)

On observe bien **le ping** depuis la carte : 

> ![image](https://github.com/user-attachments/assets/ca4338f8-653a-4fe9-9f8d-2e0e6db43488)

Et le ping depuis mon ordinateur :

> ![image](https://github.com/user-attachments/assets/572bc063-2abd-4962-a25d-d84345994814)


# **1.4 Découverte de la cible**

Réalisez un programme "Hello World !".

```
#include <stdio.h>

int main() {
    printf("Hello world !\r\n");
    return 0;
}
```


> ![image](https://github.com/user-attachments/assets/d8a232d4-4bec-4603-8067-39b1af85cdfe)



Écrire un programme en C qui réalise un chenillard
```
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <fcntl.h>
#include <signal.h>
#include <string.h>

#define NUM_LEDS 9 // Nombre de LED
#define DELAY_MS 200 // Délai en ms entre chaque allumage de LED

const char *led_paths[NUM_LEDS] = {
    "/sys/class/leds/fpga_led1/brightness",
    "/sys/class/leds/fpga_led2/brightness",
    "/sys/class/leds/fpga_led3/brightness",
    "/sys/class/leds/fpga_led4/brightness",
    "/sys/class/leds/fpga_led5/brightness",
    "/sys/class/leds/fpga_led6/brightness",
    "/sys/class/leds/fpga_led7/brightness",
    "/sys/class/leds/fpga_led8/brightness",
    "/sys/class/leds/fpga_led9/brightness"
};

static int fds[NUM_LEDS];

int main() {
    while(1)
    {
       	for (int i = 0; i < NUM_LEDS; i++)
       	{
       		fds[i] = open(led_paths[i], O_WRONLY);
       
       		write(fds[i], "1", 1);
       		usleep(DELAY_MS * 1000); // Conversion ms en µs
       		write(fds[i], "0", 1);
       		usleep(DELAY_MS * 1000); // Conversion ms en µs
       
       		close(fds[i]);
       	}
    }

    return 0;
}
```


# 2 Modules kernel (TP2)

## 2.1 Accès aux registres

programme qui accède directement aux registres depuis l’espace utilisateur :
```
ivi
```
## 2.2 Compilation de module noyau sur la VM
```
sudo apt install linux-headers-amd64
sudo apt install bc
```
> utilisation de paramètres au chargement du module
```
ici
```
> création d’un entrée dans /proc
```
ici
```
> utilisation d’un timer
```
ici
```

## 2.3 CrossCompilation de modules noyau

```
git clone https://github.com/terasic/linux-socfpga/
```
```
git checkout 6b20a2929d54
```
```
git config core.abbrev 7
```
**Préparation de la compilation**
```
sudo apt install bc
sudo apt install crossbuild-essential-armhf
sudo apt install binutils-multiarch
```
Path :
```
whereis arm-linux-gnueabihf-gcc
```
**Récupéreation de la configuration actuelle du noyau**
```
gunzip config.gz
mv config .config
```
# attention 
**se mettre dans le dossier : ```~/linux-socfpga/```**
#
```
export CROSS_COMPILE=<chemin_arm-linux-gnueabihf->
export ARCH=arm
make prepare
make scripts
```

* Quel est le rôle des lignes commençant par export ?
>Les commandes export configurent l'environnement pour que le processus de construction (make) sache qu'il doit effectuer une compilation croisée.

* Pourquoi le chemin fini par un tiret "-" ?
>Le tiret à la fin du préfixe indique à make (et aux Makefiles configurés pour la compilation croisée) que ce préfixe doit être utilisé avant le nom des outils de la chaîne de compilation

**Hello World**

Ajouter :
```
CFLAGS_MODULE=-fno-pic
```
Si changement de terminal : 
```
export CROSS_COMPILE=<chemin_arm-linux-gnueabihf->
export ARCH=arm
```
# attention 
**si "opération non permise" :**
```
cp -r ~/src/TP2 ~/
```
#
**commande dmesg et autres modules:**
screen

## 2.3.4 Chenillard (Yes !)
On veut créer un chenillard dont on peut modifier :
* Le pattern depuis le fichier :
```
/proc/ensea/chenille
```
* La vitesse au moment du chargement du module.

# attention 
**Ne cherchez pas pour cette séance à piloter les LED**
#
module respectant les conditions demandées :
```
ici le code biche
```



# 3 Device tree (TP3)
