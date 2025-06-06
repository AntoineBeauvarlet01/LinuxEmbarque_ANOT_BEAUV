#include <linux/init.h>
#include <linux/module.h>
#include <linux/kernel.h>
#include <linux/fs.h>

MODULE_AUTHOR("Claire");
MODULE_DESCRIPTION("Un module simple pour écrire dans le journal du noyau");

static int __init simple_module_init(void) {
    if (register_chrdev(230, "le_driver", NULL) >= 0)
    {
        printk(KERN_INFO, "Claire : driver chargé\n");
        if (unregister_chrdev(230, "le_driver") >= 0)
            printk(KERN_INFO, "Claire : driver déchargé\n");
    }
    else
    {
        printk(KERN_INFO, "Claire : échec chargement driver\n");
    }
    printk(KERN_INFO "Claire : module chargé\n");
    return 0;
}

static void __exit simple_module_exit(void) {
    printk(KERN_INFO "Claire : module déchargé\n");
}

module_init(simple_module_init);
module_exit(simple_module_exit);
