.MODEL SMALL
.386
.STACK 100H

.DATA
  divisor DD 4H  ;
  dividend DD 87654321H ;
  result DD ?           ;placeholder for result

.CODE
MAIN PROC
  MOV AX,@DATA
  MOV DS,AX

  MOV EAX,dividend ;loading dividend into eax
  MOV EBX,divisor ;loading divisor into ebx
  XOR EDX,EDX ;clearing edx

  DIV EBX ;actual div
  MOV EBX,EAX       ;storing eax in result
  CALL DisplayHex32      ; Call subroutine to display quoitent
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
    ADD DL, 07H             ; Convert to ASCII (A-F)

    DisplayDigit:
        ADD DL, 30h            ; Convert to ASCII (0-9)
        MOV AH, 02h            ; DOS function to display character
        INT 21h                ; Call interrupt 21h to display character
    LOOP DisplayLoop       ; Loop until all nibbles are displayed

    RET
DisplayHex32 ENDP

END MAIN                   ; In summary, the program performs a 32-bit unsigned division of the value 87654321H by 4H and then displays the hexadecimal representation of the quotient using a subroutine called DisplayHex32