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