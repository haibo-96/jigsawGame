DATAS SEGMENT
    STRING   DB  10,10,10,10,10,'123',10,'5 6',10,'478',10,10,10,10,'$'  
    STRING1  DB  10,10,10,10,10,'123',10,'456',10,'78 ',10,10,10,10,'$'
    WIN1     DB  'YOU WIN!',10,'$'
    SPEACE   DB  '                  ','$'
    WHAT     DB  'WHAT!',10,'$'
    SPA      DB  'A','$'
DATAS ENDS

STACKS SEGMENT
    ;此处输入堆栈段代码
STACKS ENDS

CODES SEGMENT
    ASSUME CS:CODES,DS:DATAS,SS:STACKS,ES:DATAS
START:
    MOV  AX,DATAS
    MOV  DS,AX
    MOV  ES,AX

    
        MOV CX,9
        MOV BX,5
      INPUT:                ;输入字符串
        MOV AH,1
        INT 21H
        
        MOV AH,'z'
        CMP AH,AL
        
        JE  ZZ
        MOV DS:STRING[BX],AL
        INC BX
       
        
        LOOP INPUT
        JMP  NEXT
        
    ZZ: INC  BX
        JMP  INPUT
        
NEXT:
    LEA  DX,STRING+3
    MOV  AH,9
    INT  21H
    
AGAIN:                         ;不正确则进入循环
    LEA  SI,STRING
    LEA  DI,STRING1
    
    MOV  CX,20
    REPE CMPSB                ;判断拼图数字排列是否正确
    JE   EXIT
    
    PUSH DI
    LEA  SI,STRING
    LEA  DI,SPEACE
    MOV  CX,20
    REPNE CMPSB                  ;寻找空格的位置
    MOV  BX,SI                   ;将找到的偏移地址放在BX中
    POP  DI
    JMP  PDSR

    
PDSR:                           ;判断输入
    MOV  AH,7
    INT  21H
    CMP  AL,'w'
    JE   INPUTW
    CMP  AL,'a'
    JE   INPUTA
    CMP  AL,'s'
    JE   INPUTS
    CMP  AL,'d'
    JE   INPUTD
    JMP  PDSR
    
INPUTW:                         ;输入w
    MOV  CH,[SI+3]
    CMP  CH,10
    JE   PDSR
    MOV  DS:[SI-1],CH
    MOV  CL,' '
    MOV  DS:[SI+3],CL
    MOV  AX,3H
    INT  10H
    MOV  AH,9
    INT  21H
    JMP  AGAIN
    
INPUTA:                         ;输入A
    MOV  CH,[SI]
    CMP  CH,10
    JE   PDSR
    MOV  DS:[SI-1],CH
    MOV  CL,' '
    MOV  DS:[SI],CL
    MOV  AX,3H
    INT  10H
    MOV  AH,9
    INT  21H
    JMP  AGAIN
    
INPUTS:                         ;输入S
    MOV  CH,[SI-5]
    CMP  CH,10
    JE   PDSR
    MOV  DS:[SI-1],CH
    MOV  CL,' '
    MOV  DS:[SI-5],CL
    MOV  AX,3H
    INT  10H
    MOV  AH,9
    INT  21H
    JMP  AGAIN
    
INPUTD:                         ;输入D
    MOV  CH,[SI-2]
    CMP  CH,10
    JE   PDSR
    MOV  DS:[SI-1],CH
    MOV  CL,' '
    MOV  DS:[SI-2],CL
    MOV  AX,3H
    INT  10H
    MOV  AH,9
    INT  21H
    JMP  AGAIN

PUT:
    LEA  DX,WHAT
    MOV  AH,9
    INT  21H
    
EXIT:
    LEA  DX,WIN1
    MOV  AH,9
    INT  21H
    MOV  AH,4CH
    INT  21H
    
CODES ENDS

    END START










