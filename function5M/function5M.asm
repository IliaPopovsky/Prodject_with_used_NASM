; function5.asm
extern printf
section .data
      first      db    "A",0
      second     db    "B",0
      third      db    "C",0
      fourth     db    "D",0
      fifth      db    "E",0
      sixth      db    "F",0
      seventh    db    "G",0
      eighth     db    "H",0
      ninth      db    "I",0
      tenth      db    "J",0
      fmt1       db    "The string is: %s%s%s%s%s%s%s%s%s%s",10,0
      fmt2       db    "PI = %.3f %d %.3f %.3f %d %d %.3f %d %.3f %.3f %.3f %d %.3f",10,0
      pi         dq    3.14
      pi1        dq    95.7
      pi2        dq    13.25
      pi3        dq    21.21
      pi4        dq    25.45
      pi5        dq    100.121
      pi6        dq    33.33
      pi7        dq    43.34
section .bss
section .text
      global main
main:
    mov rbp, rsp; for correct debugging
push  rbp                                                ; Пролог функции.
mov   rbp, rsp                                           ; Пролог функции.
      mov    rdi, fmt1                                   ; 1-й аргумент функции printf. Сначала используются регистры. 
      mov    rsi, first                                  ; 2-й аргумент функции printf.
      mov    rdx, second                                 ; 3-й аргумент функции printf.
      mov    rcx, third                                  ; 4-й аргумент функции printf.
      mov    r8,  fourth                                 ; 5-й аргумент функции printf.
      mov    r9,  fifth                                  ; 6-й аргумент функции printf.
      push   0
      push   tenth                                       ; 11-й аргумент функции printf. Теперь начинается запись в стек в обратном порядке.
      push   ninth                                       ; 10-й аргумент функции printf.
      push   eighth                                      ; 9-й аргумент функции printf.
      push   seventh                                     ; 8-й аргумент функции printf.
      push   sixth                                       ; 7-й аргумент функции printf.
      mov    rax, 0                                      ; Регистр xmm не используется. Без использования чисел с плавающей точкой.
     
      ;and    rsp, 0xfffffffffffffff0                     ; Выравнивание стека по 16-байтовой границе (по адресу кратному 16).
      call   printf
      and    rsp, 0xfffffffffffffff0                     ; Выравнивание стека по 16-байтовой границе (по адресу кратному 16).
      movsd  xmm0, [pi]                                  ; 2-й аргумент функции printf. 1-й аргумент с плавающей точкой. Вывод числа с плавающей точкой. 
      mov    rax, 8                                      ; Выводится 8 чисел с плавающей точкой.
      mov    rdi, fmt2                                   ; 1-й аргумент функции printf. 1-й целочисленный аргумент. 
      mov    rsi, 17                                     ; 3-й аргумент функции printf. 2-й целочисленный аргумент. 
      movsd  xmm1, [pi1]                                 ; 4-й аргумент функции printf. 2-й аргумент с плавающей точкой.
      movsd  xmm2, [pi2]                                 ; 5-й аргумент функции printf. 3-й аргумент с плавающей точкой. 
      mov    rdx, 18                                     ; 6-й аргумент функции printf. 3-й целочисленный аргумент. 
      mov    rcx, 19                                     ; 7-й аргумент функции printf. 4-й целочисленный аргумент.
      movsd  xmm3, [pi3]                                 ; 8-й аргумент функции printf. 4-й аргумент с плавающей точкой.
      mov    r8, 20                                      ; 9-й аргумент функции printf. 5-й целочисленный аргумент.
      movsd  xmm4, [pi4]                                 ; 10-й аргумент функции printf. 5-й аргумент с плавающей точкой.
      movsd  xmm5, [pi5]                                 ; 11-й аргумент функции printf. 6-й аргумент с плавающей точкой.
      movsd  xmm6, [pi6]                                 ; 12-й аргумент функции printf. 7-й аргумент с плавающей точкой.
      mov    r9, 21                                      ; 13-й аргумент функции printf. 6-й целочисленный аргумент.
      movsd  xmm7, [pi7]                                 ; 14-й аргумент функции printf. 8-й аргумент с плавающей точкой.
      call   printf
leave
ret
