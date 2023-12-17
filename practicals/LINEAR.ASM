.MODEL SMALL
.386
.STACK 100H
.DATA
  ARRAY DB 10H, 17H, 09H, 05H ,1AH
  msg db "Found at $"
  msg1 db "Not found $"
.CODE
  MAIN PROC FAR
  MOV AX,@DATA
  MOV DS,AX

  LEA BX,ARRAY
  MOV SI,0000H
  MOV CX,0005H
  SEARCH:
    MOV AL,[BX+SI]
    CMP AL,1AH
    JE RESULT
    INC SI
    LOOP SEARCH
    
    MOV DX,OFFSET msg1
    MOV AH,9h
    INT 21h

    MOV AH, 4CH
    INT 21H
  
  RESULT:
    
    MOV DX,OFFSET msg
    MOV AH,9H
    INT 21h
    MOV AL,05H
    SUB AL,CL
    AND AL, 0FH
    ADD AL, '0'
    MOV DL, AL
    MOV AH, 06H
    INT 21H 
    MOV AH, 4CH
    INT 21H
  
  MAIN ENDP
END MAIN
