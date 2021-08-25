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
; WE WILL DISPLAY A MESSAGE ABOUT;
; STARTING THE LOADER            ;
;--------------------------------;
  mov bx, start_message          ;
  call print_message             ;
;--------------------------------;
  mov bx, start_loading_message  ;
  call print_message             ;
;--------------------------------;

jmp $

;--------------------------------;
; PRINT A LINE ON THE SCREEN     ;
;--------------------------------;
print_message:                   ;
  pusha                          ;
;--------------------------------;
; PRINTING CHARACTERS            ;
;--------------------------------;
  start_print:                   ;
;--------------------------------;
; checking whether all characters;
; are displayed on the screen    ;
;--------------------------------;
    mov al, [bx]                 ;
    cmp al, 0                    ;
    je done_programm             ;
;--------------------------------;
; PRINTING CHARACTER             ;
;--------------------------------;
    mov ah, 0x0e                 ;
    int 10h                      ;
;--------------------------------;
;  CHARACTER PRINTING CYCLE      ;
;--------------------------------;
    add bx, 1                    ;
    jmp start_print              ;
;--------------------------------;
; STOPPING PRINTING A LINE       ;
;--------------------------------;
  done_programm:                 ;
    popa                         ;
    call print_new_line          ;
    ret                          ;
;--------------------------------;
; MOVING FOR NEW LINE            ;
;--------------------------------;
print_new_line:                  ;
  pusha                          ;
;--------------------------------;
; PRINTING A LINE BREAK CHARACTER;
;--------------------------------;
  mov ah, 0x0e                   ;
  mov al, 0x0a                   ;
  int 10h                        ;
;--------------------------------;
; MOVING THE CURSOR              ;
;--------------------------------;
  mov al, 0x0d                   ;
  int 10h                        ;
;--------------------------------;
  popa                           ;
  ret                            ;
;--------------------------------;

;--------------------------------------------------------;
;                          DATA                          ;
;--------------------------------------------------------;
start_message:                                           ;
  db 'First level bootloader MW-OS starts...', 0         ;
start_loading_message:                                   ;
  db  'The OS has started loading...', 0                 ;
;--------------------------------------------------------;

;---------------------------;
; SECTOR ALIGNMENT          ;
;---------------------------;
times 510-($-$$) db 0       ;
dw 0xaa55                   ;
;---------------------------;
