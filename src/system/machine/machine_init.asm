BITS 16

;------------------------------------------------------;
initializing_computer_type:                            ;
    pusha                                              ;
    mov ah, [FFFFh:FFFEh]                              ;

    cmp ah, IBM_PC_CONFIG                              ;
        je IBM_PC_HANDLER                              ;

    cmp ah, IBM_PC_XT_OR_PORTABLE_PC_CONFIG            ;
        je IBM_PC_XT_OR_PORTABLE_PC_HANDLER            ;

    cmp ah, PCJR_CONFIG                                ;
        je PCJR_HANDLER                                ;

    cmp ah, IBM_PC_AT_CONFIG                           ;
        je IBM_PC_AT_HANDLER                           ;

    cmp ah, CONVERTIBLE_PC_CONFIG                      ;
        je ah, CONVERTIBLE_PC_HANDLER                  ;
        
    jmp NOT_DEFINED_HANDLER                            ;
;------------------------------------------------------;

;------------------------------------------------------;
IBM_PC_HANDLER:
    popa

IBM_PC_XT_OR_PORTABLE_PC_HANDLER:
    popa

PCJR_HANDLER:
    popa

IBM_PC_AT_HANDLER:
    popa

CONVERTIBLE_PC_HANDLER:
    popa

NOT_DEFINED_HANDLER:
    popa
;------------------------------------------------------;

;------------------------------------------------------;
;                        DATA                          ;
;------------------------------------------------------;
IBM_PC_MESSAGE:                                        ;
    db 'IBM PC not supported', 0                       ;
IBM_PC_XT_OR_PORTABLE_PC_MESSAGE:                      ;
    db 'IBM PC/XT, Portable PC not supported', 0       ;
PCJR_MESSAGE:                                          ;
    db 'PCjr not supported', 0                         ;
IBM_PC_AT_MESSAGE:                                     ;
    db 'IBM PC/AT not supported', 0                    ;
CONVERTIBLE_PC_MESSAGE:                                ;
    db 'Convertible PC not supported', 0               ;
NOT_DEFINED_MESSAGE                                    ;
    db 'The car is not defined', 0                     ;
;------------------------------------------------------;
IBM_PC_CONFIG db FFh                                   ;
IBM_PC_XT_OR_PORTABLE_PC_CONFIG db FEh                 ;
PCJR_CONFIG db FDh                                     ;
IBM_PC_AT_CONFIG db FCh                                ;
CONVERTIBLE_PC_CONFIG db F9h                           ;
;------------------------------------------------------;

