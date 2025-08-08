; Assembly Language
; Target: addition of 2 8bit numbers
; by accepting inputs from user

global _start	

section .data
	;Messages to display to the user
	msg db 'Enter number1:'
	msglen equ $-msg
	
	msg1 db 'Enter number2:'
	msglen1 equ $-msg1
	
	msg2 db 'Result is:'
	msglen2 equ $-msg2
	
	new1 db ' ',10		; sapce + newline characters
	
section .bss
	;variables for storing user inputs and outputs
	num1	resb 2		;Stores first number(1digit + newline(enter))
	num2	resb 2		;Stores second number(1digit + newline(enter))
	result	resb 1		;Stores final result
	
section .text
	;Macro: print<address>,<length>	
	;This method will print a string
	%macro print 2
		mov eax,4	;sys_write
		mov ebx,1	
		mov ecx,%1	;address of string
		mov edx,%2	;length of string
		int 80h
	%endmacro
	
	;Macro: scan<address>,<length>
	;This method will read inputs from stdin
	%macro scan 2
		mov eax,3	;sys_read
		mov ebx,0
		mov ecx,%1	;buffer to store input
		mov edx,%2	;number of bytes to read
		int 80h
	%endmacro
	
_start:

		print msg,msglen	;print "Enter number1:"
		scan num1,2		;Read 2bytes (digit + newline)
		
		print msg1,msglen1	;print "Enter number2:"
		scan num2,2		;Read 2bytes (digit + newline)
		
		;converting numbers from ASCII to integer
		mov eax, [num1]
		sub eax,'0'		
		mov ebx,eax		;store first number in ebx
		
		mov eax, [num2]
		sub eax,'0'
		
		;performing addition
		
		add eax,ebx
		
		;convert result back to ASCII
		add eax,'0'
		mov [result],eax	;store ASCII value in 'result'
		
		;Display the result
		print msg2,msglen2	;print "Result is:"
		print result,1		;print result digit
		print new1,2		;print space + newline
		
		mov eax,1		;sys_exit
		mov ebx,0		;exit code 0
		int 80h
