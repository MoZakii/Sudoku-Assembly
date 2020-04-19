INCLUDE Irvine32.inc
INCLUDE macros.inc

FILESIZE = 100
FileName = 13
SolvedName = 20
BUFFER_SIZE = 99
.DATA


Unsolved  BYTE "diff_1_1.txt" , 0 
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

Address DWORD ?
SudokuGame Byte FILESIZE dup (?)
SudokuSolved Byte FILESIZE dup (?)
Difficulity Byte ?
fileHandle HANDLE ?
buffer BYTE BUFFER_SIZE DUP(?)

.CODE
main PROC
	
	mWrite "1- Easy, 2- Medium, 3- Hard : "
	call readInt
	Mov Difficulity , AL
	CALL ReadGameFile
	CALL CRLF
	
	exit
main ENDP

 ; **********************************************************************************

ReadGameFile PROC
	
	cmp Difficulity , 1
	jz Easy
	cmp Difficulity , 2
	jz Medium
	cmp Difficulity , 3
	jz Hard
	
	Easy:
		Call randomize
		mov EAX, 3
		call RandomRange
		cmp EAX , 0
		jz oneE
		cmp EAX , 1
		jz twoE
		cmp EAX , 2
		jz threeE
		oneE:
			mov EDX , offset Unsolved
			mov address , offset SudokuGame
			CALL ReadHelper
			mov EDX , offset Solved
			mov address , offset SudokuSolved
			CALL ReadHelper
			jmp Continue
		twoE:
			mov EDX , offset Unsolved
			add EDX , FileName
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
		jmp Continue
	
	Continue:


	ret

ReadGameFile ENDP

ReadHelper PROC

	call OpenInputFile
	mov fileHandle , EAX
	
	mov edx,OFFSET buffer  
	mov ecx,BUFFER_SIZE    
	call ReadFromFile
	
	mov edx,OFFSET buffer
	call WriteString
	call Crlf
	call CRLF
	
	mov eax,fileHandle
	call CloseFile

	ret
ReadHelper ENDP

END main