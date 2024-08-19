##	First command used to build stored in CC variable
CC=arm-none-eabi-gcc
LN = -T stm32f401cc_linkerscript.ld -nostdlib -Wl,-Map=file.map
## To use a variable -> $(varname)
## To use dependency name inside command -> $^
## To use Target name inside command -> $@
## first rule to generate main.o
##Target##Dependency
main.o:main.c
	$(CC) -c $^ -o $@
##	$(AC) -c main.c -o main.o
	
mrcc.o:MRCC_Program.c
	$(CC) -c $^ -o $@
	
mgpio.o:MGPIO_Program.c
	$(CC) -c $^ -o $@

stm32f401_startupfile.o:stm32f401_startupfile.c
	$(CC) -c $^ -o $@
	
file.elf:
	$(CC) *.o $(LN) -o $@
	
file.hex:
	$(CC) main.c MRCC_Program.c MGPIO_Program.c -T stm32f401cc_linkerscript.ld -nostdlib -o $@

clean:
	rm -f-r *.o file.elf symboltable.txt file.map file.hex
	
symboltable.txt:
	arm-none-eabi-nm file.elf >symboltable.txt
	
all:clean main.o mrcc.o mgpio.o stm32f401_startupfile.o file.elf file.hex
	