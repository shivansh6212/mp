; .MODEL SMALL
; .386
; .STACK 100H

; .DATA

; .CODE
;     MAIN PROC 
    
;     MOV AX, @DATA;
;     MOV DS, AX; 
;     ;input
;     MOV AH, 01H;
;     INT 21H 
;     ; Result is stored in AL (ASCII value)
;     MOV BH, AL;

;     MOV DL, 0AH
;     MOV AH, 06H
;     INT 21H
    
;     MOV CL, 08H;
;     LOOPTO8:
;         ;10101010
;         shl 01
;         01010100
;         cf-1
;         al 00000001
;         XOR AL, AL  ;clearing al
;         SHL BH, 01H ;taking lefttmost bit and storing in cf flag
;         RCL AL, 01H ;storing cf into al
        
;         ADD AL, 30H ;adding 30 to convert to ascii
;         MOV DL, AL  
;         MOV AH, 06H; ;printing al
;         INT 21H

;         LOOP LOOPTO8

;     MOV AH, 4CH;
;     INT 21H
;     ENDP MAIN
; END 

.MODEL SMALL
.386
.STACK 100H

.DATA

.CODE
    MAIN PROC 
        MOV AX, @DATA   ; Set up the data segment
        MOV DS, AX

        ; Input
        MOV AH, 01H      ; DOS interrupt for input
        INT 21H          ; Call DOS interrupt
        MOV BH, AL       ; Move the input to BH

        ; Print newline character
        MOV DL, 0AH
        MOV AH, 06H
        INT 21H

        MOV CL, 08H      ; Set loop counter to 8 for 8-bit output

    LOOPTO8:
        XOR AL, AL      ; Clear AL
        SHL BH, 01H     ; Shift left BH, CF gets the leftmost bit
        RCL AL, 01H     ; Rotate left through carry, storing CF in AL
        
        ADD AL, 30H     ; Convert binary to ASCII
        MOV DL, AL      ; Move ASCII value to DL
        MOV AH, 06H     ; DOS interrupt for character output
        INT 21H         ; Call DOS interrupt

        LOOP LOOPTO8    ; Repeat the loop

        ; Program termination
        MOV AH, 4CH
        INT 21H
    ENDP MAIN
END
