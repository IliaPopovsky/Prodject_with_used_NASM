; use_cpuid.asm
extern printf
section .data
        fmt_no_sse           db        "This cpu does not support SSE",10,0
        fmt_sse42            db        "This cpu supports SSE 4.2",10,0
        fmt_sse41            db        "This cpu supports SSE 4.1",10,0
        fmt_ssse3            db        "This cpu supports SSSE 3",10,0
        fmt_sse3             db        "This cpu supports SSE 3",10,0
        fmt_sse2             db        "This cpu supports SSE 2",10,0
        fmt_sse              db        "This cpu supports SSE",10,0
section .bss
section .text
      global main
main:
    mov rbp, rsp; for correct debugging
push  rbp                                     ; Пролог функции.
mov   rbp, rsp                                ; Пролог функции.
      call    cpu_sse                         ; Возвращает 1 в rax, если поддерживается sse, иначе 0.
leave
ret

cpu_sse:
        push  rbp                             ; Пролог функции.
        mov   rbp, rsp                        ; Пролог функции.
        xor   r12, r12                        ; Флаг SSE доступен.
        mov   eax, 1                          ; Запрос флагов характеристик ЦПУ.
        cpuid
; Проверка поддержки SSE.
        test  edx, 2000000h                   ; Проверка бита 25 (SSE).
        jz    sse2                            ; SSE-инструкции доступны.
        mov   r12, 1
        xor   rax, rax
        mov   rdi, fmt_sse
        push  rcx                             ; Изменяется функцией printf.
        push  rdx                             ; Сохранение результата cpuid.
        call  printf
        pop   rdx
        pop   rcx
   sse2:
        test  edx, 4000000h                   ; Проверка бита 26 (SSE 2).
        jz    sse3                            ; Версия SSE 2 доступна.
        mov   r12, 1
        xor   rax, rax
        mov   rdi, fmt_sse2
        push  rcx                             ; Изменяется функцией printf.
        push  rdx                             ; Сохранение результата cpuid.
        call  printf
        pop   rdx
        pop   rcx
   sse3: 
        test  ecx, 1                          ; Проверка бита 0 (SSE 3).
        jz    ssse3                           ; Версия SSE 3 доступна.
        mov   r12, 1
        xor   rax, rax
        mov   rdi, fmt_sse3
        push  rcx                             ; Изменяется функцией printf.
        push  rbp
        call  printf  
        pop   rbp     
        pop   rcx
   ssse3:
        test  ecx, 9h                         ; Проверка битов 0 и 3 (SSSE 3).
        jz    sse41                           ; Версия SSSE 3 доступна.
        mov   r12, 1
        xor   rax, rax
        mov   rdi, fmt_ssse3
        push  rcx                             ; Изменяется функцией printf.
        push  rbp
        call  printf 
        pop   rbp      
        pop   rcx
  sse41:
        test  ecx, 80000h                     ; Проверка бита 0 (SSE 4.1).
        jz    sse42                           ; Версия SSE 4.1 доступна.
        mov   r12, 1
        xor   rax, rax
        mov   rdi, fmt_sse41
        push  rcx                             ; Изменяется функцией printf.
        push  rbp
        call  printf
        push  rbp
        pop   rcx
        
  sse42:
        test  ecx, 100000h                    ; Проверка бита 20 (SSE 4.2).
        jz    wrapup                          ; Версия SSE 4.2 доступна.
        mov   r12, 1
        xor   rax, rax
        mov   rdi, fmt_sse42
        push  rcx                             ; Изменяется функцией printf.
        push  rbp
        call  printf
        push  rbp
        pop   rcx 
 wrapup:
        cmp   r12, 1
        je    sse_ok
        mov   rdi, fmt_no_sse
        xor   rax, rax
        call  printf                          ; Вывод сообщения, если SSE-инструкции недоступны.
        jmp   the_exit                        
 sse_ok:
        mov   rax, r12                        ; Возвращает 1, SSE-инструкции поддерживаются.
the_exit:
leave
ret
        
