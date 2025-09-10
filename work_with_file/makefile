#makefile для file.asm
work_with_file: work_with_file.o
	gcc -o work_with_file work_with_file.o -no-pie
work_with_file.o: work_with_file.asm
	nasm -f elf64 -g -F dwarf work_with_file.asm -l work_with_file.lst
