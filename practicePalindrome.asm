extern printf
extern scanf

global main

section .text

main:
  ; printf("Enter a string: ");
  mov rdi, qword stringPrompt
  mov rax, 0
  call printf

  ; scanf("%s", string);
  mov rdi, qword stringFormat
  mov rsi, qword string
  call scanf

  ; printf("What is the length of the string? ");
  mov rdi, qword stringSizePrompt
  mov rax, 0
  call printf

  ; scanf("%lli", stringSize);
  mov rdi, qword stringSizeFormat
  mov rsi, qword stringSize
  mov rax, 0
  call scanf

  ; reverse the string

  ; setup rdx as half the length of the string and rcx as zero
  mov rax, [qword stringSize]
  mov rdx, 0
  mov rcx, 2
  div rcx
  mov rdx, rax
  mov rcx, 0 

  jmp nextChar


  jmp endProgram

nextChar:
  ; check if we are done 
  cmp rcx, rdx
  jge palindrome
  
    mov rax, [qword stringSize]      
    push rbx
    mov rbx, rax
    sub rbx, 1

    ; get first character and store it in rsi
    mov rax, qword string
    add rax, rcx
    mov sil, [rax]

    ; get oposite side character store it in rdi
    mov rax, qword string
    add rax, rbx
    sub rax, rcx
    mov dil, [rax]
    pop rbx

  ; compare the characters
    cmp sil, dil
    jne notPalindrome

  ; move to the next characters
  inc rcx
  jmp nextChar


palindrome:
  ; printf("The string %s is a palindrome.\n", string);
  mov rdi, qword responseTrue
  mov rsi, qword string
  call printf
  jmp endProgram

notPalindrome:
  ; printf("The string %s is not a palindrome.\n", string);
  mov rdi, qword responseFalse
  mov rsi, qword string
  call printf
  jmp endProgram

endProgram:
  ; exit
  mov rax, 0
  ret

section .data
  stringPrompt db "Enter a string: ", 0
  stringFormat db "%s", 0

  stringSizePrompt db "What is the length of the string? ", 0
  stringSizeFormat db "%lli", 0

  responseTrue db "The string %s is a palindrome.", 0ah, 0dh, 0
  responseFalse db "The string %s is not a palindrome.", 0ah, 0dh, 0

section .bss 
  string resb 50
  stringSize resq 1
