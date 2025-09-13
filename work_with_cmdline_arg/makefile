#makefile для work_with_cmdline_arg.asm
work_with_cmdline_arg: work_with_cmdline_arg.o
	gcc -o work_with_cmdline_arg work_with_cmdline_arg.o -no-pie
work_with_cmdline_arg.o: work_with_cmdline_arg.asm
	nasm -f elf64 -g -F dwarf work_with_cmdline_arg.asm -l work_with_cmdline_arg.lst
