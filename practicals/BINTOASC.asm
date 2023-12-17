.MODEL SMALL
.386
.STACK 100H

.DATA

.CODE
    MAIN PROC
        ; Setting the value of the DS reigster 
        MOV AX, @DATA   ; Getting the value
        MOV DS, AX      ; Setting the value of DS
        ;assuming the input is 01100001
        ;explanation
        ; actually binary me 0 aur 1 hi ha aur hme uska pta chl sakhta sirf last bit dekh kar so we too input into al store into bl ,then rotate bx by 1 towards right so that last bit of bl goes into first bit of bh and then this process goes on and we get the input in bh but in reverse order 
        ;bh - 10000110 bl-00000000 
        ;now we will read from bh by rotating through right and storing 0(taking the above example) into bl and then into al and then printing it into the console and then repeating the process for all the 8 bits
        
        MOV CX, 08H
        INPUT:
            ; To input value
            MOV AH, 01H
            INT 21H
            ; Value is in ASCII (31 for 1, 30 for 0)
            AND AL, 0FH 
            MOV BL, AL  
            PUSH CX 
            MOV CL, 01H
            ROR BX, CL 
            POP CX

            LOOP INPUT
        ; Printing newline character

        MOV DL, 0AH
        MOV AH, 06H
        INT 21H
        ; Value is in BH
        MOV BL, 00H
        MOV CL, 08H
        REVERSE:
            SHR BH, 01H;
            RCL BL, 01H
            LOOP REVERSE

        MOV AH, 02H
        MOV DL, BL
        INT 21H
        
        MOV AH, 4CH
        INT 21H
            
    MAIN ENDP
END MAIN