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

## 2.2 Compilation de module noyau sur la VM
```
sudo apt install linux-headers-amd64
sudo apt install bc
```
> Utilisation de paramètres au chargement du module

> ![image](https://github.com/user-attachments/assets/5a9d3d9f-5c9c-4c5f-bd01-fbc92315769d)

```
#include <linux/module.h>
#include <linux/kernel.h>
#include <linux/init.h>

MODULE_AUTHOR("Claire et Antoine");
MODULE_DESCRIPTION("Test module avec paramètres");
MODULE_SUPPORTED_DEVICE("Presque tous");
MODULE_LICENSE("GPL");

static int param;

module_param(param, int, 0);
MODULE_PARM_DESC(param, "Un paramètre de ce module");

static int __init le_module_init(void) {
	printk(KERN_INFO "Hello world!\n");
	printk(KERN_DEBUG "Le paramètre est=%d\n", param);
	return 0;
}

static void __exit le_module_exit(void) {
	printk(KERN_ALERT "Bye bye...\n");
}

module_init(le_module_init);
module_exit(le_module_exit);
```
> Création d’un entrée dans /proc

```
#include <linux/init.h>
#include <linux/module.h>
#include <linux/kernel.h>
#include <linux/proc_fs.h>
#include <linux/uaccess.h>

MODULE_AUTHOR("Claire");
MODULE_DESCRIPTION("Un module simple pour écrire dans le journal du noyau");
MODULE_SUPPORTED_DEVICE("Tous");
MODULE_LICENSE("GPL");

#define BUF_LEN 64

static ssize_t my_read_function(struct file *file, char *buf, size_t count, loff_t *ppos) {
    int lus = 0;

    printk(KERN_DEBUG "read: demande lecture de %d octets\n", count);
    
    /* Check for overflow */
    if (count <= BUF_LEN - (int)*ppos)
        lus = count;
    else lus = BUF_LEN - (int)*ppos;

    if(lus)
        copy_to_user(buf, (int *)buf + (int)*ppos, lus);
    
    *ppos += lus;

    printk(KERN_DEBUG "read: %d octets reellement lus\n", lus);
    printk(KERN_DEBUG "read: position=%d\n", (size_t)*ppos);

    return lus;
}

static ssize_t my_write_function(struct file *file, const char *buf, size_t count, loff_t *ppos) {
    int ecrits = 0, i = 0;

    printk(KERN_DEBUG "write: demande ecriture de %d octets\n", count);

    if (count <= BUF_LEN - (int)*ppos) /* Check for overflow */
        ecrits = count;
    else ecrits = BUF_LEN - (int)*ppos;

    if(ecrits)
        copy_from_user((int *)buf + (int)*ppos, buf, ecrits);
    *ppos += ecrits;

    printk(KERN_DEBUG "write: %d octets reellement ecrits\n", ecrits);
    printk(KERN_DEBUG "write: position=%d\n", (int)*ppos);
    printk(KERN_DEBUG "write: contenu du buffer\n");

    for(i=0;i<BUF_LEN;i++)
        printk(KERN_DEBUG " %d", buf[i]);

    printk(KERN_DEBUG "\n");
    return ecrits;
}

static int my_open_function(struct inode *inode, struct file *file) {
    printk(KERN_DEBUG "open()\n");
    return 0;
}

static int my_release_function(struct inode *inode, struct file *file) {
    printk(KERN_DEBUG "close()\n");
    return 0;
}

struct file_operations fops = {
    .owner = THIS_MODULE,
    .read = my_read_function,
    .write = my_write_function,
    .open = my_open_function,
    .release = my_release_function /* correspond a close */
};

static int __init simple_module_init(void) {
    if (proc_create("test_proc", 0666, NULL, &fops) >= 0)
    {
        printk(KERN_INFO, "Fichier créé\n");
    }
    else
    {
        printk(KERN_INFO, "Echec création fichier\n");
        return -1;
    }
    return 0;
}

static void __exit simple_module_exit(void) {
    remove_proc_entry("test_proc", NULL);
    printk(KERN_INFO, "Fichier supprimé\n");
    printk(KERN_INFO, "Module déchargé\n");
}

module_init(simple_module_init);
module_exit(simple_module_exit);
```
> Utilisation d’un timer

```
#include <linux/module.h>
#include <linux/kernel.h>
#include <linux/init.h>
#include <linux/timer.h>

MODULE_AUTHOR("Claire et Antoine");
MODULE_DESCRIPTION("Test module avec paramètres");
MODULE_SUPPORTED_DEVICE("Presque tous");
MODULE_LICENSE("GPL");

#define INTERVALLE 100

static int param;
static struct timer_list timer;

module_param(param, int, 0);
MODULE_PARM_DESC(param, "Un paramètre de ce module");

static void montimer(struct timer_list *t) {
    /* Il faut réarmer le timer si l'on veut un appel périodique */
    mod_timer(&timer, jiffies + INTERVALLE);
}

static int __init le_module_init(void) {
	timer_setup(&timer, montimer, 0);
    mod_timer(&timer, jiffies + INTERVALLE);

	printk(KERN_INFO "Hello world!\n");
	printk(KERN_DEBUG "Le paramètre est=%d\n", param);
	return 0;
}

static void __exit le_module_exit(void) {
	printk(KERN_ALERT "Bye bye...\n");
}

module_init(le_module_init);
module_exit(le_module_exit);

```

## 2.3 CrossCompilation de modules noyau
### 2.3.2 Récupéreation de la configuration actuelle du noyau
* Quel est le rôle des lignes commençant par export ?
>Les commandes export configurent l'environnement pour que le processus de construction (make) sache qu'il doit effectuer une compilation croisée.

* Pourquoi le chemin fini par un tiret "-" ?
> Le tiret à la fin du préfixe indique à make (et aux Makefiles configurés pour la compilation croisée) que ce préfixe doit être utilisé avant le nom des outils de la chaîne de compilation

### 2.3.3 Hello World
# ON EST ICI
Le Makefle a été modifié et le make fonctionne, je pense qu'il faudra refaire la copie en dehors de /src la prochaine fois pcq ce n'est pas un répertoire partagé.

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
