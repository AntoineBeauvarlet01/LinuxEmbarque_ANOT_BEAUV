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
