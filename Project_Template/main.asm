INCLUDE Irvine32.inc
INCLUDE macros.inc

FILESIZE = 100
FileName = 13
SolvedName = 20
BUFFER_SIZE = 99
.DATA


Unsolved  BYTE "diff_1_1.txt" , 0    ; Array to save file names
		  BYTE "diff_1_2.txt" , 0 
		  BYTE "diff_1_3.txt" , 0 
		  BYTE "diff_2_1.txt" , 0 
	   	  BYTE "diff_2_2.txt" , 0 
		  BYTE "diff_2_3.txt" , 0 
		  BYTE "diff_3_1.txt" , 0 
		  BYTE "diff_3_2.txt" , 0 
		  BYTE "diff_3_3.txt" , 0

Solved  BYTE "diff_1_1_solved.txt" , 0 
		BYTE "diff_1_2_solved.txt" , 0 
		BYTE "diff_1_3_solved.txt" , 0 
		BYTE "diff_2_1_solved.txt" , 0 
		BYTE "diff_2_2_solved.txt" , 0 
		BYTE "diff_2_3_solved.txt" , 0  
		BYTE "diff_3_1_solved.txt" , 0 
		BYTE "diff_3_2_solved.txt" , 0 
		BYTE "diff_3_3_solved.txt" , 0

savedFile BYTE "saved.txt" , 0
Address DWORD ?
SudokuGame Byte FILESIZE dup (?)
SudokuSolved Byte FILESIZE dup (?)
Difficulity Byte ?
fileHandle HANDLE ?
buffer BYTE BUFFER_SIZE DUP(?)

.CODE
main PROC
	
	mWrite"1- New Game , 2- Load Game : "
	call readInt
	cmp AL , 1
	jne Load
	mWrite "1- Easy, 2- Medium, 3- Hard : "
	call readInt
	Mov Difficulity , AL
	CALL ReadGameFile
	Load:
		Mov Difficulity , 4 ; 4th option
		Call ReadGameFile
	CALL CRLF

	mov edx,OFFSET SudokuGame ;  To display the Game Array (for debugging purposes)
	call WriteString
	call Crlf
	call Crlf
	mov edx,OFFSET SudokuSolved ; To display the Solved Array (for debugging purposes)
	call WriteString
	exit
main ENDP

 ; **********************************************************************************

ReadGameFile PROC
	
	cmp Difficulity , 1  ; Jump depending on difficulity
	jz Easy
	cmp Difficulity , 2
	jz Medium
	cmp Difficulity , 3
	jz Hard
	cmp Difficulity , 4
	jz OldGame
	Easy:
		Call randomize     ;Randomize number from 0 to 3
		mov EAX, 3
		call RandomRange
		cmp EAX , 0
		jz oneE
		cmp EAX , 1
		jz twoE
		cmp EAX , 2
		jz threeE
		oneE:										;for each block of code 		
			mov EDX , offset Unsolved				;Move Address for string carrying name to EDX (needed for OpenInputFile)
			mov address , offset SudokuGame			;Move Address of desired array to address pointer
			CALL ReadHelper							;call function
			mov EDX , offset Solved					
			mov address , offset SudokuSolved
			CALL ReadHelper
			jmp Continue
		twoE:
			mov EDX , offset Unsolved
			add EDX , FileName						;Handling indexing for array of Strings
			mov address , offset SudokuGame 
			CALL ReadHelper
			mov EDX , offset Solved
			add EDX , SolvedName
			mov address , offset SudokuSolved
			CALL ReadHelper 
			jmp Continue
		threeE:
			mov EDX , offset Unsolved
			add EDX , FileName * 2
			mov address , offset SudokuGame
			CALL ReadHelper
			mov EDX , offset Solved
			add EDX , SolvedName * 2
			mov address , offset SudokuSolved
			CALL ReadHelper
			jmp Continue
		

	Medium:
	Call randomize
		mov EAX, 3
		call RandomRange
		cmp EAX , 0
		jz oneM
		cmp EAX , 1
		jz twoM
		cmp EAX , 2
		jz threeM
		oneM:
			mov EDX , offset Unsolved
			add EDX , FileName * 3
			mov address , offset SudokuGame
			CALL ReadHelper
			mov EDX , offset Solved
			add EDX , SolvedName * 3
			mov address , offset SudokuSolved
			CALL ReadHelper
			jmp Continue
		twoM:
			mov EDX , offset Unsolved
			add EDX , FileName * 4
			mov address , offset SudokuGame 
			CALL ReadHelper
			mov EDX , offset Solved
			add EDX , SolvedName * 4
			mov address , offset SudokuSolved
			CALL ReadHelper
			jmp Continue
		threeM:
			mov EDX , offset Unsolved
			add EDX , FileName * 5
			mov address , offset SudokuGame
			CALL ReadHelper
			mov EDX , offset Solved
			add EDX , SolvedName * 5
			mov address , offset SudokuSolved
			CALL ReadHelper
			jmp Continue
	
	Hard:
		Call randomize
		mov EAX, 3
		call RandomRange
		cmp EAX , 0
		jz oneH
		cmp EAX , 1
		jz twoH
		cmp EAX , 2
		jz threeH
		oneH:
			mov EDX , offset Unsolved
			add EDX , FileName * 6
			mov address , offset SudokuGame
			CALL ReadHelper
			mov EDX , offset Solved
			add EDX , SolvedName * 6
			mov address , offset SudokuSolved
			CALL ReadHelper
			jmp Continue
		twoH:
			mov EDX , offset Unsolved
			add EDX , FileName * 7
			mov address , offset SudokuGame 
			CALL ReadHelper
			mov EDX , offset Solved
			add EDX , SolvedName * 7
			mov address , offset SudokuSolved
			CALL ReadHelper
			jmp Continue
		threeH:
			mov EDX , offset Unsolved
			add EDX , FileName * 8
			mov address , offset SudokuGame
			CALL ReadHelper
			mov EDX , offset Solved
			add EDX , SolvedName * 8
			mov address , offset SudokuSolved
			CALL ReadHelper
			jmp Continue

	OldGame:
			mov EDX , offset savedFile
			mov address , offset SudokuGame
			CALL ReadHelper
			mov EDX , offset Solved
			;add EDX , SolvedName ; Multiply by solved index aka the number in the begining of file (NOT DONE)*******
			mov address , offset SudokuSolved
			CALL ReadHelper
	Continue:


	ret

ReadGameFile ENDP

ReadHelper PROC

	call OpenInputFile
	mov fileHandle , EAX
	
	mov edx,OFFSET buffer  ;Fills buffer array from file
	mov ecx,BUFFER_SIZE    
	call ReadFromFile

	Mov ecx , 9
	Mov EDI , 0
	Mov ESI , Address
	outerLoop:

		mov edx , ecx
		mov ecx , 11
		innerLoop:
			
			Mov AL , buffer[EDI]	;if between 48 and 57 inclusive add to array (ASCii code for 0-9)
			cmp AL , 48
			JL skip
			cmp AL , 57
			JG skip
			Mov [ESI] , AL
			INC ESI

			skip:		
				INC EDI
		LOOP innerLoop
		mov ecx , edx

	LOOP outerLoop
	
	mov eax,fileHandle
	call CloseFile

	ret
ReadHelper ENDP

END main