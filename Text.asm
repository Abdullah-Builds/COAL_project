Include Irvine32.inc
.data
Xmsg byte "Score of X : ",0
Omsg byte "Sccore of O : ",0
project_makers1 byte "****      Abdul Ahad 23k-0590",0
project_makers2 byte "****      Rayyan Ur Rehman 23k-0634",0
project_makers3 byte "****      Muhammad Abdullah khan 23k-0607",0
Rule byte "Dont Press 0(zero) the game ends : ",0
grp byte "------ Project Members --------",0
message byte " LOADING... ", 0
space byte " ", 0
currentPlayer  byte 'X'
choice         dword ?
winner         dword 0
sIntro         byte "Welcome to Tic-Tac-Toe !",0
sEnd           byte "Thanks for Playing The Game!",0
sTurn          byte "'s turn. Choose a place: ",0
sInvalidChoice byte "Invalid choice. Choose a Valid place: ",0
sDraw          byte "Draw!",0
sWins          byte " Wins!",0
quit           byte "To Quit the Game Press 0",0
leaving        byte "Quiting Game :/",0
Xwins  dword 0
Owins dword  0
count dword  0
prompt byte "Enter How Many Times You Want To Play : ",0
board byte "7       |8      |9      ",10,13,
           "        |       |       ",10,13,
           "        |       |       ",10,13,
           " -------+-------+-------",10,13, 
           "4       |5      |6      ",10,13,
           "        |       |       ",10,13,
           "        |       |       ",10,13,
           " -------+-------+-------",10,13,
           "1       |2      |3      ",10,13, 
           "        |       |       ",10,13,
           "        |       |       ",10,13,0

.code
main PROC

    mov eax, 0Fh         ;bright white
    call SetTextColor
    mov edx, offset prompt
    call writestring
    call readint
    mov count, eax

    call crlf
    mov eax, 0Fh         ;bright white
    call SetTextColor

    mov edx, offset grp
    call writestring
    call crlf
    call crlf

    mov edx, offset project_makers1
    call writestring
    call crlf

    mov edx, offset project_makers2
    call writestring
    call crlf

    mov edx, offset project_makers3
    call writestring
    call crlf
    call crlf

    mov eax, 04h        ; Red color 
    call SetTextColor
    mov edx, offset Rule
    call writestring
    call crlf

    call loadingbar
    call crlf
    call crlf

Num_Times:

    cmp count, 0
    je ExitProgram

    mov eax, 0Ah
    call SetTextColor

    mov edx, OFFSET sIntro
    call WriteString
    call crlf
    call crlf

    mov eax, 04h
    call SetTextColor
    mov edx, OFFSET board
    call WriteString

L1:
    mov al, currentPlayer
    push eax
    push OFFSET board
    call place

    mov edx, OFFSET board
    call WriteString

    push OFFSET winner
    mov al, currentPlayer
    push eax
    push OFFSET board
    call checkWinDraw

    mov eax, winner
    cmp eax, 1
    je Win
    cmp eax, 2
    je Draw

    push OFFSET currentPlayer
    call switch
    jmp L1

Win:
    mov al, currentPlayer
    cmp byte PTR al,'X'
    jne skip1
    inc Xwins
    skip1:
    cmp byte PTR al,'O'
    jne skip2
    inc Owins
    skip2:
    call WriteChar
    mov edx, OFFSET sWins
    call WriteString
    call crlf
    jmp GameEnd

Draw:
    mov edx, OFFSET sDraw
    call WriteString
    call crlf
    jmp GameEnd

GameEnd:
    mov eax, 02h        ; Green color 
    call SetTextColor
    mov edx, offset Xmsg
    call writestring
    mov eax, Xwins
    call writeint
    call crlf
    mov edx, offset Omsg
    call writestring
    mov eax, Owins
    call writeint
    call crlf
    call refreshBoard
    dec count
    jmp Num_Times

ExitProgram:
    mov edx, OFFSET sEnd
    call WriteString
    call crlf
    exit

main ENDP
refreshBoard PROC
    mov edi, OFFSET board     

    mov byte ptr [edi + 30], ' '  
    mov byte ptr [edi + 38], ' '   
    mov byte ptr [edi + 48], ' '   
    mov byte ptr [edi + 134], ' '  
    mov byte ptr [edi + 142], ' '  
    mov byte ptr [edi + 150], ' ' 
    mov byte ptr [edi + 238], ' '  
    mov byte ptr [edi + 246], ' '  
    mov byte ptr [edi + 254], ' '  

    ret
refreshBoard ENDP

;*****************************************************************************************************************************************************

; Range  is 1 to 9.
;              [ebp +  8] = address of board
;              [ebp + 12] = currentPlayer

; User Input to place at are as follows index :1 = 238, 2 = 246, 3 = 254, 4 = 134, 5 = 142, 6 = 150, 7 = 30, 8 = 38, 9 = 48

;*****************************************************************************************************************************************************
;****************************************************** LOADING BAR ***********************************************************************
loadingbar PROC
    mov eax, 0Bh          ; Bright cyan
    call SetTextColor
    mov edx, OFFSET message
    call WriteString

    mov eax, 0Bh          ; Bright cyan
    call SetTextColor
    mov edx, OFFSET space
    call WriteString

    mov edx, OFFSET space
    call WriteString
    mov ecx, 25
loader:
    mov al, '*'  
    mov ah, 0     
    mov dl, al  
    call writechar
    mov eax, 150         ;the speed of loader depends on it
    call Delay
    loop loader
ret
loadingbar ENDP
;*****************************************************************************************************************************************************
;********************************************************  THE MAIN LOGIC ***************************************************************************
place PROC
     push ebp
     mov  ebp,esp
     pushad

     mov eax, 03h         ;dark cyan color
     call SetTextColor 
     mov edx,OFFSET quit
     call WriteString
     call crlf
     mov  eax,[ebp + 12]
     call WriteChar
     mov edx,OFFSET sTurn
     call WriteString
     mov eax, 0Fh         ;dark red color
     call SetTextColor 

;********************************************************IT CHECKS WHETHER INPUT IS VALID OR NOT******************************************************************************
Validate:
     call ReadDec
     mov  choice,eax
     cmp  choice,0
     je   exitgame
     cmp  choice,9
     ja   Invalid             
     cmp  choice,1
     jb   Invalid
     mov esi,[ebp + 8]        
     cmp choice,7                         
     je P1                
     cmp choice,8                         
     je P2                
     cmp choice,9                         
     je P3                
     cmp choice,4                         
     je P4                
     cmp choice,5                         
     je P5 
     cmp choice,6                         
     je P6                
     cmp choice,1                       
     je P7                
     cmp choice,2                         
     je P8                
     cmp choice,3                         
     je P9
exitgame:
    mov edx,OFFSET leaving
    call WriteString
    invoke ExitProcess, 0

P1:
     add esi,30               ; increment esi for equivalent cell
     jmp confirm
P2:    
     add esi,38               
     jmp confirm
P3:    
     add esi,46               
     jmp confirm
P4:       
     add esi,134              
     jmp confirm
P5:      
     add esi,142              
     jmp confirm
P6:      
     add esi,150              
     jmp confirm
P7:      
     add esi,238              
     jmp confirm
P8:     
     add esi,246              
     jmp confirm
P9:    
     add esi,254              
     jmp confirm
Confirm:
     mov bl,' '
     cmp [esi],bl             ; if cell is already full, it jumps to inavlid
     jne Invalid              
     mov bl,[ebp + 12]        ; move currentPlayer into bl
     mov [esi],bl             ; move bl into address pointed to by esi
     jmp Finish
Invalid:
     mov  edx,OFFSET sInvalidChoice
     call WriteString
     jmp  Validate
Finish:
     popad
     pop  ebp
     ret 8
place ENDP

; ebp +8 is address of board, ebp+12 is currentPlayer, ebp+16 is winner
; 0 is no one has won yet, 1 if winner found, 2 if draw 

checkWinDraw PROC
     push ebp
     mov  ebp,esp
     pushad
     mov bl,[ebp + 12]        ; currentPlayer into bl
     mov edi,[ebp + 16]       ; address of winner moved in edi

CheckRow1:
     mov esi,[ebp + 8]
     add esi,30               ; increment esi for same  cell
     cmp [esi],bl             
     jne CheckRow2            ; if Not equal, it jumps To Check other Rows
     add esi,8                ; increment esi for next cell
     cmp [esi],bl             
     jne CheckRow2            
     add esi,8                ; increment esi for next cell
     cmp [esi],bl           
     jne CheckRow2            
     jmp WinnerFound          ; all cells are same, so winner is found

                              ; all other checks work the same way

CheckRow2:
     mov esi,[ebp + 8]        
     add esi,134              
     cmp [esi],bl             
     jne CheckRow3            
     add esi,8                
     cmp [esi],bl             
     jne CheckRow3            
     add esi,8                
     cmp [esi],bl             
     jne CheckRow3            
     jmp WinnerFound          

CheckRow3:
     mov esi,[ebp + 8]        
     add esi,238              
     cmp [esi],bl             
     jne CheckColumn1         
     add esi,8                
     cmp [esi],bl             
     jne CheckColumn1         
     add esi,8                
     cmp [esi],bl             
     jne CheckColumn1         
     jmp WinnerFound          

CheckColumn1:
     mov esi,[ebp + 8]       
     add esi,30              
     cmp [esi],bl            
     jne CheckColumn2        
     add esi,104             
     cmp [esi],bl            
     jne CheckColumn2        
     add esi,104              
     cmp [esi],bl             
     jne CheckColumn2         
     jmp WinnerFound          

CheckColumn2:
     mov esi,[ebp + 8]        
     add esi,38               
     cmp [esi],bl             
     jne CheckColumn3         
     add esi,104              
     cmp [esi],bl             
     jne CheckColumn3         
     add esi,104              
     cmp [esi],bl             
     jne CheckColumn3         
     jmp WinnerFound          

CheckColumn3:
     mov esi,[ebp + 8]
     add esi,46
     cmp [esi],bl
     jne CheckDiagonal1
     add esi,104
     cmp [esi],bl
     jne CheckDiagonal1
     add esi,104
     cmp [esi],bl
     jne CheckDiagonal1
     jmp WinnerFound

CheckDiagonal1:
     mov esi,[ebp + 8]
     add esi,30
     cmp [esi],bl
     jne CheckDiagonal2
     add esi,112
     cmp [esi],bl
     jne CheckDiagonal2
     add esi,112
     cmp [esi],bl
     jne CheckDiagonal2
     jmp WinnerFound

CheckDiagonal2:
     mov esi,[ebp + 8]
     add esi,46
     cmp [esi],bl
     jne CheckDraw
     add esi,96
     cmp [esi],bl
     jne CheckDraw
     add esi,96
     cmp [esi],bl
     jne CheckDraw
     jmp WinnerFound

CheckDraw:
     mov esi,[ebp + 8]
     mov bl,' '
     cmp [esi + 30],bl
     je NoWinnerFound
     cmp [esi + 38],bl
     je NoWinnerFound
     cmp [esi + 46],bl
     je NoWinnerFound
     cmp [esi + 134],bl
     je NoWinnerFound
     cmp [esi + 142],bl
     je NoWinnerFound
     cmp [esi + 150],bl
     je NoWinnerFound
     cmp [esi + 238],bl
     je NoWinnerFound
     cmp [esi + 246],bl
     je NoWinnerFound
     cmp [esi + 254],bl
     je NoWinnerFound
     jmp DrawFound
NoWinnerFound:
     mov edx,0
     mov [edi],edx
     jmp Finish
WinnerFound:
     mov edx,1
     mov [edi],edx
     jmp Finish
DrawFound:
     mov edx,2
     mov [edi],edx
Finish:
     popad
     mov esp,ebp
     pop  ebp
     ret 
checkWinDraw ENDP

;    switches players 
;    [ebp + 8] is showing the  address of currentPlayer

switch PROC
     push ebp
     mov  ebp,esp
     pushad
     mov esi,[ebp + 8]
     mov ebx,[esi]
     mov ecx,'X'
     mov edx,'O'
     cmp bl,cl
     je XtoO
     cmp bl,dl
     je OtoX
XtoO:
     mov bl,dl
     jmp Finish
OtoX:
     mov bl,cl
     jmp Finish
Finish:
     mov [esi],bl
     popad
     pop  ebp
     ret 4
switch ENDP
END main