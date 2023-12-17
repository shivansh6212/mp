.MODEL SMALL
.386
.STACK 100H
.DATA
   
.CODE
    MAIN PROC FAR
        MOV AX, @DATA
        MOV DS, AX 
        
        ; Inputting the first number 
        MOV CX, 0004H
        LOOP1:
            SHL EBX, 8
            MOV AH, 01H
            INT 21H 
            
            AND AL, 0FH
            SHL AL, 04H
            MOV BL, AL
            
            MOV AH, 01H
            INT 21H
            
            AND AL, 0FH
            ADD BL, AL
            
            LOOP LOOP1
        
        ; Printing newline character
        MOV DL, 0AH
        MOV AH, 06H
        INT 21H

        ; Copying the number to EDX
        MOV EDX, EBX

        ; Inputting the second number 
        MOV CX, 0004H
        LOOP2:
            SHL EBX, 8
            MOV AH, 01H
            INT 21H 
            
            AND AL, 0FH
            SHL AL, 04H
            MOV BL, AL
            
            MOV AH, 01H
            INT 21H
            
            AND AL, 0FH
            ADD BL, AL
            
            LOOP LOOP2
        
        ; One operand is in EDX, another in EBX
        ; Actual addition
        CLC 
        MOV AL, BL
        SBB AL, DL
        DAS 
        MOV CL, AL
        MOV AL, BH
        SBB AL, DH
        DAS
        MOV CH, AL
        
        JC SET_FLAG
        JMP NO_SET

        SET_FLAG:
            MOV AL, 01H
            JMP ROTATE

        NO_SET:
            MOV AL, 00H

        ROTATE:
        ROL EBX, 10H
        ROL ECX, 10H
        ROL EDX, 10H
        RCR AL, 01H

        MOV AL, BL
        SBB AL, DL
        DAS 
        MOV CL, AL
        MOV AL, BH
        SBB AL, DH
        DAS
        MOV CH, AL

        ; Printing newline character
        
        MOV DL, 0AH
        MOV AH, 06H
        INT 21H

        ROTATE2:
        
        ROL ECX, 10H
        MOV EBX, ECX
        
        PRINTING:
        MOV ECX, 0008H
        LOOP3:
            ROL EBX, 4

            MOV AL, BL
            AND AL, 0FH
            ADD AL, '0'
            MOV DL, AL
            MOV AH, 06H
            INT 21H 
            
            LOOP LOOP3

        MOV AH, 4CH
        INT 21H
    MAIN ENDP
END MAIN

