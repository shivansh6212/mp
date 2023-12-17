.MODEL SMALL
.386
.STACK 100H
.DATA

.CODE
    MAIN PROC FAR
        MOV AX, @DATA
        MOV DS, AX 
        
        ; Inputting the first number we will take input of 8 numbers but will make loop run 4 times 12345678
        MOV CX, 0004H
        LOOP1:
            SHL EBX, 8  ;making space for next 8bits
            MOV AH, 01H ;taking input from keyboard
            INT 21H     ;input will be stored in AL
            
            AND AL, 0FH ;now taking only last four bits as 1 number in bcd is of 4 bits
            SHL AL, 04H ;now shifting last four bits to first four bits
            MOV BL, AL  ;now moving al to bl
            
            MOV AH, 01H ;again taking input of 2nd number
            INT 21H     ; input in al

            AND AL, 0FH ;now al last four digit contains 2nd number and Bl first digit was conatinig first number
            ADD BL, AL  ;now adding both al ,bl to get first 8bits of bcd number
            
            LOOP LOOP1  ;again start looping until cx becomes zero
        
        ; Printing newline character
        
        MOV DL, 0AH
        MOV AH, 06H
        INT 21H
        ; Copying the number to EDX
        MOV EDX, EBX

        ; Inputting the second number Same as first 
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
        ; Actual addition we will do addition of 8 bit first then next 8 bit
        CLC         ;clear carry flag
        MOV AL, BL  ;storing bl in al
        ADC AL, DL  ; al = al+dl  means adding actually bl+dl
        DAA 
        MOV CL, AL  ;storing reslut of 8 bit in cl
        MOV AL, BH  ;storing next 8bit in al
        ADC AL, DH  ; adding bh + dh
        DAA 
        MOV CH, AL  ; storing next 8bit of result in ch
                    ;now cx has result of 16bit 
        JC SET_FLAG ; if carry then jump to setflag
        JMP NO_SET  ;if no carry then jump to noset

        SET_FLAG:
            MOV AL, 01H  ;
            JMP ROTATE

        NO_SET:
            MOV AL, 00H
        ;rotating ebx,ecx,edx by 16 bits so that we can perform next 16 bit calculations
        ROTATE:
        ROL EBX, 10H
        ROL ECX, 10H
        ROL EDX, 10H
        RCR AL, 01H  ;rotating al also by 1 so that cf is set 
        ;same as above for next 16 bit

        MOV AL, BL
        ADC AL, DL
        DAA 
        MOV CL, AL
        MOV AL, BH
        ADC AL, DH
        DAA 
        MOV CH, AL
        ; Printing newline character
        
        MOV DL, 0AH
        MOV AH, 06H
        INT 21H

        JC SET_ONE ;jump if carry flag is set
        JMP SET_ZERO
        SET_ONE:
            MOV DL, '1' ;printing 1 ahead of answer as cf was set
            MOV AH, 06H
            INT 21H 
            JMP ROTATE2
        SET_ZERO:
            MOV AL, 00H

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
END 

