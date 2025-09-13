; work_with_file.asm
section .data
; Выражения, используемые для условного ассемблирования.
      CREATE             equ    1
      OVERWRITE          equ    1
      APPEND             equ    1
      O_WRITE            equ    1
      READ               equ    1
      O_READ             equ    1
      DELETE             equ    1
      
; Символические имена системных вызовов.
      NR_read            equ    0
      NR_write           equ    1
      NR_open            equ    2
      NR_close           equ    3
      NR_lseek           equ    8
      NR_create          equ    85
      NR_unlink          equ    87
      
; Флаги созданияи состояния файлов.
      O_CREAT            equ    00000100q
      O_APPEND           equ    00002000q
      
; Режимы доступа.
      O_RDONLY           equ    000000q
      O_WRONLY           equ    000001q
      O_RDWR             equ    000002q
      
; Режимы при создании файла (права доступа).
      S_IRUSR            equ    00400q                              ; Право на чтение для владельца.
      S_IWUSR            equ    00200q                              ; Право на запись для владельца.
      NL                 equ    0xa
      bufferlen          equ    64
      fileName           db     "testfile.txt",0
      FD                 dq     0                                   ; Дескриптор файла.
      
; Другие данные.
      text1              db     "1. Hello...to everyone!",NL,0
      len1               dq     $-text1-1                           ; Удаление 0.
      text2              db     "2. Here I am!",NL,0
      len2               dq     $-text2-1                           ; Удаление 0.
      text3              db     "3. Alife and kicking!",NL,0
      len3               dq     $-text3-1                           ; Удаление 0.
      text4              db     "Adios!!!",NL,0
      len4               dq     $-text4-1                           ; Удаление 0.
      
      
      error_Create       db     "error creating file",NL,0
      error_Close        db     "error closing file",NL,0
      error_Write        db     "error writing to file",NL,0
      error_Open         db     "error opening file",NL,0
      error_Append       db     "error appending to file",NL,0
      error_Delete       db     "error deleting file",NL,0
      error_Read         db     "error reading file",NL,0
      error_Print        db     "error printing string",NL,0
      error_Position     db     "error positioning in file",NL,0
      
      
      success_Create     db     "File created and opened",NL,0
      success_Close      db     "File closed",NL,NL,0
      success_Write      db     "Written to file",NL,0
      success_Open       db     "File opened for R/W",NL,0
      success_Append     db     "File opened for appending",NL,0
      success_Delete     db     "File deleted",NL,0
      success_Read       db     "Reading file",NL,0
      success_Position   db     "Positioned in file",NL,0
      
      
section .bss
      buffer             resb   bufferlen
section .text
      global main
main:
push  rbp                                            ; Пролог функции.
mov   rbp, rsp                                       ; Пролог функции. 
%IF CREATE
; СОЗДАНИЕ И ОТКРЫТИЕ ФАЙЛА, ЗАТЕМ ЗАКРЫТИЕ. ---------------------------------------
; Создание и открытие файла.
      mov    rdi, fileName                           ; 1-й аргумент системного вызова с номером 85.
      call   createFile
      mov    qword[FD], rax                          ; Сохранение дескриптора файла.
; Запись в файл #1.
      mov    rdi, qword[FD]                          ; 1-й аргумент системного вызова с номером 1.
      mov    rsi, text1                              ; 2-й аргумент системного вызова с номером 1.
      mov    rdx, qword[len1]                        ; 3-й аргумент системного вызова с номером 1.
      call   writeFile
; Закрытие файла.
      mov    rdi, qword[FD]                          ; 1-й аргумент системного вызова с номером 3.
      call   closeFile
%ENDIF
%IF OVERWRITE
; ОТКРЫТИЕ И ПЕРЕЗАПИСЬ ФАЙЛА, ЗАТЕМ ЗАКРЫТИЕ. -------------------------------------
; Открытие файла.
      mov    rdi, fileName                           ; 1-й аргумент системного вызова с номером 2.
      call   openFile
      mov    qword[FD], rax                          ; Сохранение дескриптора файла.
; Запись в файл #2 - ПЕРЕЗАПИСЬ (ЗАМЕЩЕНИЕ)!
      mov    rdi, qword[FD]                          ; 1-й аргумент системного вызова с номером 1.
      mov    rsi, text2                              ; 2-й аргумент системного вызова с номером 1.
      mov    rdx, qword[len2]                        ; 3-й аргумент системного вызова с номером 1.
      call   writeFile
; Закрытие файла.
      mov    rdi, qword[FD]                          ; 1-й аргумент системного вызова с номером 3.
      call   closeFile
%ENDIF
%IF APPEND
; ОТКРЫТИЕ И ДОБАВЛЕНИЕ В ФАЙЛ, ЗАТЕМ ЗАКРЫТИЕ. ------------------------------------
; Открытие файла для добавления в него данных.
      mov     rdi, fileName                          ; 1-й аргумент системного вызова с номером 2.
      call    appendFile     
      mov     qword[FD], rax                         ; Сохранение дескриптора файла.
; Запись в файл #3 - ДОБАВЛЕНИЕ! 
      mov    rdi, qword[FD]                          ; 1-й аргумент системного вызова с номером 1.
      mov    rsi, text3                              ; 2-й аргумент системного вызова с номером 1.
      mov    rdx, qword[len3]                        ; 3-й аргумент системного вызова с номером 1.
      call   writeFile
; Закрытие файла.
      mov    rdi, qword[FD]                          ; 1-й аргумент системного вызова с номером 3.
      call   closeFile
%ENDIF
%IF O_WRITE
; ОТКРЫТИЕ И ПЕРЕЗАПИСЬ ПО ПОЗИЦИИ СМЕЩЕНИЯ В ФАЙЛЕ, ЗАТЕМ ЗАКРЫТИЕ. ---------------
; Открытие файла для записи.
      mov    rdi, fileName                           ; 1-й аргумент системного вызова с номером 2.
      call   openFile
      mov    qword[FD], rax                          ; Сохранение дескриптора файла.
; Позиция в файле, определяемая по смещению.
      mov    rdi, qword[FD]                          ; 1-й аргумент системного вызова с номером 8.
      mov    rsi, qword[len2]                        ; 2-й аргумент системного вызова с номером 8. Смещение в заданную позицию.
      mov    rdx, 0                                  ; 3-й аргумент системного вызова с номером 8.
      call   positionFile
; Запись в файл в позицию с заданным смещением.
      mov    rdi, qword[FD]                          ; 1-й аргумент системного вызова с номером 1.
      mov    rsi, text4                              ; 2-й аргумент системного вызова с номером 1.
      mov    rdx, qword[len4]                        ; 3-й аргумент системного вызова с номером 1.
      call   writeFile
; Закрытие файла.
      mov    rdi, qword[FD]                          ; 1-й аргумент системного вызова с номером 3.
      call   closeFile
%ENDIF
%IF READ
; ОТКРЫТИЕ И ЧТЕНИЕ ИЗ ФАЙЛА, ЗАТЕМ ЗАКРЫТИЕ. --------------------------------------
; Открытие файла для чтения.   
      mov    rdi, fileName                           ; 1-й аргумент системного вызова с номером 2.
      call   openFile
      mov    qword[FD], rax                          ; Сохранение дескриптора файла.
; Чтение из файла.
      mov    rdi, qword[FD]                          ; 1-й аргумент системного вызова с номером 0.
      mov    rsi, buffer                             ; 2-й аргумент системного вызова с номером 0.
      mov    rdx, bufferlen                          ; 3-й аргумент системного вызова с номером 0. Количество считываемых символов.
      call   readFile
      mov    rdi, rax  
      call   printString
; Закрытие файла.
      mov    rdi, qword[FD]                          ; 1-й аргумент системного вызова с номером 3.
      call   closeFile
%ENDIF  
%IF O_READ
; ОТКРЫТИЕ И ЧТЕНИЕ В ПОЗИЦИИ, ЗАДАННОЙ СМЕЩЕНИЕМ В ФАЙЛЕ, ЗАТЕМ ЗАКРЫТИЕ. --------
; Открытие файла для чтения.   
      mov    rdi, fileName                           ; 1-й аргумент системного вызова с номером 2.
      call   openFile
      mov    qword[FD], rax                          ; Сохранение дескриптора файла.   
; Позиция в файле, определяемая по смещению.
      mov    rdi, qword[FD]                          ; 1-й аргумент системного вызова с номером 8.
      mov    rsi, qword[len2]                        ; 2-й аргумент системного вызова с номером 8. Смещение в заданную позицию. Пропустить первую строку.
      mov    rdx, 0                                  ; 3-й аргумент системного вызова с номером 8.
      call   positionFile  
; Чтение из файла (в заданной позиции).
      mov    rdi, qword[FD]                          ; 1-й аргумент системного вызова с номером 0.
      mov    rsi, buffer                             ; 2-й аргумент системного вызова с номером 0.
      mov    rdx, 10                                 ; 3-й аргумент системного вызова с номером 0. Количество считываемых символов.
      call   readFile
      mov    rdi, rax  
      call   printString
; Закрытие файла.
      mov    rdi, qword[FD]                          ; 1-й аргумент системного вызова с номером 3.
      call   closeFile
%ENDIF 
%IF DELETE
; УДАЛЕНИЕ ФАЙЛА. -----------------------------------------------------------------
; Удаление файла. ДЛЯ ИСПОЛЬЗОВАНИЯ УБРАТЬ СИМВОЛЫ КОММЕНТАРИЕВ В СЛЕДУЮЩИХ СТРОКАХ.
      mov    rdi, fileName
      call   deleteFile
%ENDIF
leave
ret
; ФУНКЦИИ ОБРАБОТКИ ФАЙЛА. --------------------------------------------------------
;----------------------------------------------------------------------------------
global readFile
readFile:
      mov   rax, NR_read
      syscall                                        ; rax содержит количество считываемых символов.
      cmp   rax, 0
      jl    readerror
      mov   byte[rsi+rax], 0                         ; Добавление завершающего нуля.
      mov   rax, rsi
      mov   rdi, success_Read
      push  rax                                      ; Регистр, сохраняемый вызывающей функцией.
      call  printString
      pop   rax                                      ; Регистр, сохраняемый вызывающей функцией.
      ret
readerror:
      mov   rdi, error_Read
      call  printString
      ret
;----------------------------------------------------------------------------------
global deleteFile
deleteFile:
      mov    rax, NR_unlink
      syscall
      cmp    rax, 0
      jl     deleteerror
      mov    rdi, success_Delete
      call   printString
      ret
deleteerror:
      mov    rdi, error_Delete
      call   printString
      ret
;---------------------------------------------------------------------------------- 
global appendFile
appendFile:
      mov    rax, NR_open
      mov    rsi, O_RDWR | O_APPEND
      syscall
      cmp    rax, 0
      jl     appenderror 
      mov    rdi, success_Append
      push   rax                                      ; Регистр, сохраняемый вызывающей функцией.
      call   printString
      pop    rax                                      ; Регистр, сохраняемый вызывающей функцией.
      ret
appenderror:
      mov    rdi, error_Append
      call   printString
      ret
;----------------------------------------------------------------------------------  
global openFile
openFile:
      mov    rax, NR_open
      mov    rsi, O_RDWR
      syscall
      cmp    rax, 0
      jl     openerror
      mov    rdi, success_Open
      push   rax                                      ; Регистр, сохраняемый вызывающей функцией.
      call   printString
      pop    rax                                      ; Регистр, сохраняемый вызывающей функцией.
      ret
openerror:
      mov    rdi, error_Open
      call   printString
      ret 
;----------------------------------------------------------------------------------
global writeFile
writeFile:
      mov    rax, NR_write
      syscall
      cmp    rax, 0
      jl     writeerror
      mov    rdi, success_Write
      call   printString
      ret
writeerror:
      mov    rdi, error_Write   
      call   printString
      ret 
;---------------------------------------------------------------------------------- 
global positionFile
positionFile:
      mov    rax, NR_lseek
      syscall
      cmp    rax, 0
      jl     positionerror
      mov    rdi, success_Position
      call   printString
      ret
positionerror:
      mov    rdi, error_Position
      call   printString
      ret
;----------------------------------------------------------------------------------  
global closeFile
closeFile:
      mov    rax, NR_close
      syscall
      cmp    rax, 0
      jl     closeerror
      mov    rdi, success_Close
      call   printString
      ret
closeerror:
      mov    rdi, error_Close
      call   printString
      ret
;---------------------------------------------------------------------------------- 
global createFile
createFile:
      mov    rax, NR_create                           ; Номер системного вызова 85.
      mov    rsi, S_IRUSR | S_IWUSR                   ; 2-й аргумент системного вызова с номером 85.
      syscall
      cmp    rax, 0                                   ; Дескриптор файла в регистре rax.
      jl     createerror
      mov    rdi, success_Create
      push   rax                                      ; Регистр, сохраняемый вызывающей функцией.
      call   printString
      pop    rax                                      ; Регистр, сохраняемый вызывающей функцией.
      ret
createerror:
      mov    rdi, error_Create
      call   printString
      ret
; ВЫВОД ИНФОРМАЦИИ О ФАЙЛОВЫХ ОПЕРАЦИЯХ (ОБРАТНОЙ СВЯЗИ).
;----------------------------------------------------------------------------------
global printString
printString:
; Счетчик символов.
      mov    r12, rdi
      mov    rdx, 0
strLoop:
      cmp    byte[r12], 0
      je     strDone
      inc    rdx                                      ; Длина строки в регистре rdx.
      inc    r12
      jmp    strLoop
strDone:
      cmp    rdx, 0                                   ; Строка отсутствует (длина 0).
      je     prtDone
      mov    rsi, rdi                                 ; 2-й аргумент системного вызова с номером 1.
      mov    rax, 1                                   ; Системный вызов с номером 1, 1 = запись.
      mov    rdi, 1                                   ; 1-й аргумент системного вызова с номером 1, 1 = в поток стандартного вывода stdout.
      syscall
prtDone:
      ret
                             
