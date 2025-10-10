# makefile for use_cpuid.asm
use_cpuid: use_cpuid.o
	gcc -o use_cpuid use_cpuid.o -no-pie
use_cpuid.o: use_cpuid.asm
	nasm -f elf64 -g -F dwarf use_cpuid.asm -l use_cpuid.lst

