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

module_param(param, int, 0);
MODULE_PARM_DESC(param, "Un paramètre de ce module");

static int __init le_module_init(void) {
	printk(KERN_INFO "Hello world!\n");
	printk(KERN_DEBUG "Le parametre est=%d\n", param);
	return 0;
}

static void __exit le_module_exit(void) {
	printk(KERN_ALERT "Bye bye...\n");
}

module_init(le_module_init);
module_exit(le_module_exit);
