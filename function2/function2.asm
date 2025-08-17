; function2.asm
extern printf
section .data
      radius      dq     10.0
section .bss
section .text
;------------------------------------------
area: 
section .data
      .pi      dq     3.141592654            ; Локальная переменная в функции area.
section .text
push   rbp                                   ; Пролог функции.
mov    rbp, rsp                              ; Пролог функции. 
       movsd  xmm0, [radius]                 ; Запись числа с плавающей точкой в регистр xmm0.
       mulsd  xmm0, [radius]                 ; Умножение xmm0 на число с плавающей точкой.
       mulsd  xmm0, [.pi]                    ; Умножение xmm0 на (другое) число с плавающей точкой.
leave
ret
;------------------------------------------
circum: 
section .data
      .pi      dq     3.14                   ; Локальная переменная в функции circum.
section .text
push   rbp                                   ; Пролог функции.
mov    rbp, rsp                              ; Пролог функции. 
       movsd  xmm0, [radius]                 ; Запись числа с плавающей точкой в регистр xmm0.
       addsd  xmm0, [radius]                 ; Сложение xmm0 с числом с плавающей точкой.
       mulsd  xmm0, [.pi]                    ; Умножение xmm0 на (другое) число с плавающей точкой.
leave
ret
;------------------------------------------
circle:
section .data
      .fmt_area      db    "The area is %f",10,0                 ; Локальная переменная в функции circle.
      .fmt_circum    db    "The circumference is %f",10,0        ; Локальная переменная в функции circle.
section .text
push   rbp                                   ; Пролог функции.
mov    rbp, rsp                              ; Пролог функции.
       call  area
       mov   rdi, .fmt_area                  ; 1-й аргумент функции printf.
       mov   rax, 1                          ; 2-й аргумент функции printf, регистр xmm0. Значение площади в регистре xmm0.
       call  printf
       call  circum
       mov   rdi, .fmt_circum                ; 1-й аргумент функции printf.
       mov   rax, 1                          ; 2-й аргумент функции printf, регистр xmm0. Значение длины окружности в регистре xmm0.
       call  printf
leave
ret 
;------------------------------------------   
       global main
main:
push   rbp                                   ; Пролог функции.
mov    rbp, rsp                              ; Пролог функции.
       call  circle
leave
ret              
          
