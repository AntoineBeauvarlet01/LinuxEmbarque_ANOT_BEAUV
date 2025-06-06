obj-m:=chenillard.o

CFLAGS_MODULE=-fno-pic

all:
	make -C /home/ensea/linux-socfpga M=$(PWD) modules
clean:
	make -C /home/ensea/linux-socfpga M=$(PWD) clean
install:
	make -C /home/ensea/linux-socfpga M=$(PWD) install
