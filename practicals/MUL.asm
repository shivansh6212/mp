.MODEL SMALL
.386
.STACK 100H

.DATA
    multiplicand DD 12345678H  ; 32-bit multiplicand (change as needed)
    multiplier   DD 87654321H  ; 32-bit multiplier (change as needed)
    result       DD ?          ; Result placeholder

.CODE
MAIN PROC
    MOV AX, @DATA      ; Load data segment address into AX
    MOV DS, AX         ; Set DS to point to the data segment

    MOV EAX, multiplicand  ; Load multiplicand into EAX
    MOV EBX, multiplier    ; Load multiplier into EBX
    XOR EDX, EDX           ; Clear EDX (for high 32-bit of result)

    MUL EBX                ; Unsigned multiply EAX by EBX
    MOV [result], EAX      ; Store the low 32 bits of result
    MOV [result + 4], EDX  ; Store the high 32 bits of result

    ; Displaying the result (in hexadecimal)
    MOV EBX, [result + 4]  ; Move high 32 bits of result to EAX
    CALL DisplayHex32      ; Call subroutine to display high 32 bits

    MOV EBX, [result]      ; Move low 32 bits of result to EAX
    CALL DisplayHex32      ; Call subroutine to display low 32 bits

    MOV AH, 4Ch            ; DOS function to terminate the program
    INT 21h                ; Call interrupt 21h to exit

MAIN ENDP

DisplayHex32 PROC

    MOV CX, 0008H          ; Set loop counter to 8 (number of nibbles)
DisplayLoop:
    ROL EBX, 4             ; Rotate left to get next nibble
    MOV DL, BL             ; Move lower 4 bits to DL
    AND DL, 0FH            ; Mask higher bits
    CMP DL, 09H            ; Compare BL with 9
    JBE DisplayDigit       ; Jump if below or equal to 9
    ADD DL, 07H              ; Convert to ASCII (A-F)

    DisplayDigit:
        ADD DL, 30h            ; Convert to ASCII (0-9)
        MOV AH, 02h            ; DOS function to display character
        INT 21h                ; Call interrupt 21h to display character
    LOOP DisplayLoop       ; Loop until all nibbles are displayed

    RET
DisplayHex32 ENDP


END MAIN
