; rect.asm
section .data
section .bss
section .text
global rarea
rarea:
      section .text
      push  rbp                                ; Пролог функции.
      mov   rbp, rsp                           ; Пролог функции.
            mov    rax, rdi
            imul   rsi
      leave
      ret
global rcircum
rcircum:
      section .text
      push  rbp                                ; Пролог функции.
      mov   rbp, rsp                           ; Пролог функции.
            mov    rax, rdi
            add    rax, rsi
            imul   rax, 2
      leave
      ret       
                 
            
