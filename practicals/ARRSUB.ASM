.MODEL SMALL
.386
.STACK 100H

.DATA
  ARR1 DB 8H, 9H, 3H, 4H, 5H
  ARR2 DB 6H, 3H, 1H, 2H, 1H
  ARR3 DB 5(?)

.CODE
  MAIN PROC 
    MOV AX, @DATA
    MOV DS, AX
    
    MOV CX, 05H
    MOV SI, OFFSET ARR1
    LEA DI, ARR2
    MOV BX, 00H
    LOOPADDD:
      MOV AX, [SI + BX]
      SUB AX, [DI + BX]
      MOV DL, AL
      ADD DL, 30H
      MOV AH, 06H
      INT 21H 
      MOV DL,20H
      MOV AH ,06H
      INT 21H
      INC BX
      
      LOOP LOOPADDD
    
    MOV AH, 4CH
    INT 21H


  ENDP MAIN
END
MAIN