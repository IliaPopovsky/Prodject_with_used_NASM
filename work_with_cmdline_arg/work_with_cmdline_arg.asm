; work_with_cmdline_arg.asm
extern printf
section .data
      msg      db     "The command and arguments: ",10,0
      fmt      db     "%s",10,0
section .bss
section .text
      global main
main:
push  rbp                                ; Пролог функции.
mov   rbp, rsp                           ; Пролог функции.  
      mov    r12, rdi                    ; Количество аргументов. rdi - это 1-й аргумент функции main.
      mov    r13, rsi                    ; Адрес массива аргументов. rsi - это 2-й аргумент функции main.
; Вывод заголовка.
      mov    rdi, msg                    ; rdi - это 1-й аргумент функции printf.
      call   printf
      mov    r14, 0
; Вывод имени команды и аргументов.
.ploop:                                  ; Цикл прохода по массиву аргументов и их вывода.
      mov    rdi, fmt                    ; rdi - это 1-й аргумент функции printf.
      mov    rsi, qword[r13+r14*8]       ; rsi - это 2-й аргумент функции printf.
      call   printf
      inc    r14
      cmp    r14, r12                    ; Достигнуто максимальное количество аргументов?
      jl     .ploop
leave
ret
      
