; circle.asm
section .data
      pi        dq     3.141592654
section .bss
section .text
global carea
carea:
      section .text
      push  rbp                                ; Пролог функции.
      mov   rbp, rsp                           ; Пролог функции.
            movsd  xmm1, qword[pi]
            mulsd  xmm0, xmm0                  ; Радиус в регистре xmm0.
            mulsd  xmm0, xmm1
leave
ret  
global ccircum
ccircum:
      section .text
      push  rbp                                ; Пролог функции.
      mov   rbp, rsp                           ; Пролог функции.
            movsd  xmm1, qword[pi]
            addsd  xmm0, xmm0                  ; Радиус в регистре xmm0.
            mulsd  xmm0, xmm1
leave
ret             
              
