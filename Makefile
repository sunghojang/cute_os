# .c.o:
# 	arm-none-eabi-gcc $< -c

# .S.o:
# 	arm-none-eabi-gcc $< -c	


#BOOTLOADER

OBJ = start.o cuteOS.bin.o


cute-boot:$(OBJ)
	arm-none-eabi-ld $(OBJ) -o cute-boot -N -T cute-boot.lds
	arm-none-eabi-objcopy cute-boot cute-boot.bin -O binary
	arm-none-eabi-nm cute-boot | grep -v '\(compiled\)\|\(\.o$$\)\|\( [aUw] \)\|\(\.\.ng$$\)\|\(LASH[RL]DI\)' | sort > CuteBoot.map
	arm-none-eabi-objdump -D -a -f -p -s -h cute-boot > cute-boot.das

#-Ttext 0x00000000
	
start.o: start.S
	arm-none-eabi-gcc -march=armv7-a -mcpu=cortex-a9 -I./include  -c -v -DOS_RAM_BASE=0x40100000 start.S

#KERNEL

cuteOS.bin.o : cuteOS
	arm-none-eabi-ld -b binary cuteOS.bin -r -o cuteOS.bin.o

cuteOS : head.o main.o
	arm-none-eabi-ld head.o main.o -o cuteOS -Ttext 0x40100000 -N	
	arm-none-eabi-objcopy cuteOS cuteOS.bin -O binary
	arm-none-eabi-nm cuteOS | grep -v '\(compiled\)\|\(\.o$$\)\|\( [aUw] \)\|\(\.\.ng$$\)\|\(LASH[RL]DI\)' | sort > OsCute.map
	arm-none-eabi-objdump -D -a -f -p -s -h cuteOS > cuteOS.das

head.o:head.S
	arm-none-eabi-gcc -I./include -march=armv7-a -mcpu=cortex-a9 -c -DSTACK_ADDR_BASE=0x40200000 head.S  
	#arm-none-eabi-gcc head.S -c

main.o : main.c
	arm-none-eabi-gcc -I./include -march=armv7-a -mcpu=cortex-a9 -c main.c
	#arm-none-eabi-gcc main.c -c

run: 
	#gnome-terminal --hide-menubar -e "qemu-system-arm -M smdkc210 -display none -serial stdio -kernel $(TARGET)" &
	gnome-terminal --hide-menubar -e "qemu-system-arm -M smdkc210 -display none -serial stdio -kernel cute-boot.bin" &

clean:
	rm -f *.o
	rm -f cute-boot
	rm -f cute-boot.bin
	rm -f cuteOS
	rm -f cuteOS.bin
	rm -f *.das
	rm -f *.map