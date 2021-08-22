;
; Boot sector program.
;
BITS 16

org 7C00h

;--------------------------------;
; ENTRY POINT                    ;
;--------------------------------;
start:                           ;
  cli                            ; we forbid interrupting
;--------------------------------;
; INITIALIZING REGISTERS         ;
;--------------------------------;
  xor ax, ax                     ; xor is cheaper than mov
  mov ds, ax                     ;
  mov es, ax                     ;
  mov ss, ax                     ;
  mov sp, 07C00h                 ;
;--------------------------------;
  sti                            ; returning the ability to handle interrupts
;--------------------------------;
; CLEAR THE DISPLAY              ;
;--------------------------------;
  mov ax, 3                      ;
  int 10h                        ;
  mov ah, 2h                     ;
  mov dh, 0                      ;
  mov dl, 0                      ;
  xor bh, bh                     ;
  int 10h                        ;
;--------------------------------;
; DISABLING THE CURSOR           ;
;--------------------------------;
  mov ah, 1                      ;
  mov ch, 0x20                   ;
  int 0x10                       ;
;--------------------------------;
; we will display a message about;
; starting the loader            ;
;--------------------------------;
  mov bp, start_message          ;
  mov cx, 38                     ; number of characters per line
  call print_message             ;
;--------------------------------;
  mov bx, start_loading_message  ;
  mov cx 31                      ;
  call print_message             ;
  ;------------------------------;

jmp $

;--------------------------------;
; 
;--------------------------------;
print_message:                   ;
    mov ax, 1301h                ;
    mov bl, 02h                  ; первый 4 бита цвет фона, вторые текста
    int 10h                      ;
    ret                          ;
;--------------------------------;


start_message db 'First level bootloader MW-OS starts...', 0
start_loading_message db 13, 10 'The OS has started loading...', 0

;---------------------------;
times 510-($-$$) db 0       ;
dw 0xaa55                   ;
;---------------------------;
