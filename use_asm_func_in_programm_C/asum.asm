; asum.asm
section .data
section .bss
section .text
global asum
asum:
     section .text
; Вычисление суммы.
           mov     rcx, rsi                   ; Длина массива.
           mov     rbx, rdi                   ; Адрес массива.
           mov     r12, 0
           movsd   xmm0, qword[rbx+r12*8]
           dec     rcx                        ; На один проход в цикле меньше, так как первый элемент уже в регистре xmm0.
     sloop:
           inc     r12
           addsd   xmm0, qword[rbx+r12*8]
           loop    sloop
     ret                                      ; Сумма возвращается в регистре xmm0.  
