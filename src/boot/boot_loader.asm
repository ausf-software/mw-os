;
; A simple boot sector program.
;
bits 16

org 7C00h

message db 'First level bootloader MW-OS starts...',0

;---------------------------;
start:                      ;
    call init_loader        ;
    call fill_display       ;
    call print_greetings    ;
    fill_area               ;
    jmp $                   ;
;---------------------------;

;---------------------------;
init_loader:                ;
    cli                     ;
    xor ax, ax              ;
    mov ds, ax              ;
    mov es, ax              ;
    mov ss, ax              ;
    mov sp, 07C00h          ;
    sti                     ;
    ret                     ;
;---------------------------;

;---------------------------;
fill_display:               ;
    mov ax, 3               ;
    int 10h                 ;
    mov ah, 2h              ;
    mov dh, 0               ;
    mov dl, 0               ;
    xor bh, bh              ;
    int 10h                 ;
    ret                     ;
;---------------------------;

;---------------------------;
print_greetings:            ;
    mov ax, 1301h           ;
    mov bp, message         ;
    mov cx, 12              ;
    mov bl, 02h             ;
    int 10h                 ;
    ret                     ;
;---------------------------;

;---------------------------;
times 510-($-$$) db 0       ;
dw 0xaa55                   ;
;---------------------------;