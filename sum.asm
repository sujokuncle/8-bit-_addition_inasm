; addition of 2 8-bit numbers
; by accepting input from the user

global _start

section .data
	;messages to display
	msg db 'Enter number1:'
	msglen equ $-msg
	
	msg1 db 'Enter number2:'
	msglen1 equ $-msg1
	
	msg2 db 'Result is:'
	msglen2 equ $-msg2
	
	new1 db ' ',10		; space + newline characters
	
section .bss
	;variable for storing inputs & reuslt
	num1	resb 2	;stores (1digit + newline)
	num2 	resb 2	;stores (1digit + newline)
	result	resb 1	;stores result
	
section .text
	%macro print 2
		mov eax,4	;sys_write
		mov ebx,1
		mov ecx,%1	;address of string
		mov edx,%2	;length of string
		int 80h
	%endmacro
	
	%macro scan 2
		mov eax,3	;sys_read
		mov ebx,0
		mov ecx,%1
		mov edx,%2
		int 80h
	%endmacro
	
_start:
	print msg,msglen	;print "Enter number1:"
	scan num1,2		;read 2bytes (digit + newline)
	
	print msg1,msglen1	;print "Enter number2:"
	scan num2,2		;read 2bytes (digit + newline)
	
	;convert ASCII to integer
	
	mov eax,[num1]
	sub eax,'0'
	mov ebx,eax
	
	mov eax,[num2]
	sub eax,'0'
	
	add eax,ebx
	
	add eax,'0'
	mov [result],eax
	
	print msg2,msglen2	;print "Result is:"
	print result,1		;print result digit
	print new1,2		;print space + newline 
	
	;exit program
	mov eax,1		;sys_exit
	mov ebx,0		;exit code 0
	int 80h
