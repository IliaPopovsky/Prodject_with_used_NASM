#makefile для function5M.asm
function5M: function5M.o
	gcc -o function5M function5M.o -no-pie
function5M.o: function5M.asm
	nasm -f elf64 -g -F dwarf function5M.asm -l function5M.lst
