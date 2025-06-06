#include <linux/module.h>
#include <linux/kernel.h>
#include <linux/proc_fs.h>
#include <linux/uaccess.h>
#include <linux/string.h>
#include <linux/ctype.h>
#include <linux/delay.h>

#define PROC_NAME "ensea/chenille"
#define NUM_LEDS 8 // Nombre de LED

static char chenille_pattern[10] = "11111111"; // Pattern par défaut
static char chenille_pattern_off[10] = "00000000"; // Pattern par défaut
static int speed = 100; // Vitesse par défaut en ms
module_param(speed, int, 0);

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


// Fonction pour afficher l'état des LEDs
static void display_led_status(void)
{
    struct file *f;
    mm_segment_t old_fs;
    loff_t pos = 0;

    int i;
    for (i = 0; i < NUM_LEDS; i++) {
        if (chenille_pattern[i] == '1') {
            printk(KERN_INFO "La LED %d est allumee\r\n", i+1);
        } else if (chenille_pattern[i] == '0') {
            printk(KERN_INFO "La LED %d est eteinte\r\n", i+1);
        }
    }

    old_fs = get_fs();
    set_fs(KERNEL_DS);

    for (i = 0; i < NUM_LEDS; i++)
    {
        f = filp_open(led_paths[i], O_WRONLY, 0);
        if (IS_ERR(f)) {
            printk(KERN_ALERT "Failed to open %s\n", led_paths[i]);
            continue;
        }
    
        vfs_write(f, &chenille_pattern[i], 1, &pos);
        filp_close(f, NULL);

        msleep(speed);
    }
    
    set_fs(old_fs);
}

static ssize_t my_read_function(struct file *file, char __user *usr_buf, size_t count, loff_t *pos)
{
    if (*pos > 0)
        return 0;

    if (copy_to_user(usr_buf, chenille_pattern, strlen(chenille_pattern)))
        return -EFAULT;

    *pos = strlen(chenille_pattern);
    return strlen(chenille_pattern);
}

static ssize_t my_write_function(struct file *file, const char __user *usr_buf, size_t count, loff_t *pos)
{
    if (count > sizeof(chenille_pattern) - 1)
        return -EINVAL;

    if (copy_from_user(chenille_pattern, usr_buf, count))
        return -EFAULT;

    chenille_pattern[count] = '\0';
    printk(KERN_INFO "New pattern: %s\r\n", chenille_pattern);

    // Afficher l'état des LEDs après avoir mis à jour le pattern
    display_led_status();

    return count;
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

static int __init chenillard_init(void)
{
    if (proc_create(PROC_NAME, 0666, NULL, &fops) < 0) {
        printk(KERN_ALERT "Error: Could not initialize /proc/%s\r\n", PROC_NAME);
        return -ENOMEM;
    }

    printk(KERN_INFO "/proc/%s created\r\n", PROC_NAME);
    printk(KERN_INFO "Chenillard module loaded with speed: %d ms\r\n", speed);

    // Afficher l'état des LEDs après avoir mis à jour le pattern
    display_led_status();

    return 0;
}

static void __exit chenillard_exit(void)
{
    struct file *f;
    mm_segment_t old_fs;
    loff_t pos = 0;

    int i;

    old_fs = get_fs();
    set_fs(KERNEL_DS);

    for (i = 0; i < NUM_LEDS; i++)
    {
        f = filp_open(led_paths[i], O_WRONLY, 0);
        if (IS_ERR(f)) {
            printk(KERN_ALERT "Failed to open %s\n", led_paths[i]);
            continue;
        }
    
        vfs_write(f, &chenille_pattern_off[i], 1, &pos);
        filp_close(f, NULL);
    }
    set_fs(old_fs);

    remove_proc_entry(PROC_NAME, NULL);
    printk(KERN_INFO "Chenillard module unloaded\r\n");
}

module_init(chenillard_init);
module_exit(chenillard_exit);

MODULE_LICENSE("GPL");
MODULE_AUTHOR("Claire et Antoine");
MODULE_SUPPORTED_DEVICE("Tous");
MODULE_DESCRIPTION("2.3.4 Chenillard");