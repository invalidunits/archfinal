extern printf
extern scanf

global main

section .text

main:

  ; printf("Enter a number: ");
  mov rdi, qword toFindPrompt
  mov rax, 0
  call printf

  ; scanf("%lli", &toFind);
  mov rdi, qword toFindFormat
  mov rsi, qword toFind
  mov rax, 0
  call scanf


  ; search the list
  mov rcx, 0
  jmp nextNumber
  


nextNumber:
  ; get the next array element
  mov rax, rcx
  mov rdx, 0

  push rbx
  mov rbx, 8
  mul rbx 
  pop rbx

  mov rdx, qword list
  add rax, rdx

  mov rax, [rax] ; rax = *rax
  mov rdx, rax

; go to the next array element
  mov rax, [qword toFind]

  

  ; compare this array element to our number
  cmp rax, rdx
  je numberFound

  ; increment index
  inc rcx

  ; break if we finished the list
  mov rax, [qword listSize]
  cmp rcx, rax
  jge numberNotFound

  ; otherwise repeat loop
  jmp nextNumber

numberNotFound:
  ; printf("The number %lli was not found in the list.\n", toFind);
  mov rdi, qword NotFoundPrompt
  mov rax, [qword toFind]
  mov rsi, rax
  mov rax, 0
  call printf

  jmp endProgram

numberFound:
  ; printf("The number %lli was found in the list.\n", toFind);
  mov rdi, qword FoundPrompt
  mov rax, [qword toFind]
  mov rsi, rax
  mov rax, 0
  call printf

  jmp endProgram

endProgram:
  ; exit
  mov rax, 0
  ret

section .data
  toFindPrompt db "Enter a number: ", 0
  toFindFormat db "%lli", 0
  toFind dq 0

  list dq -4, 7, 6, 11, -1, 0, 3, 9, 16, -3
  listSize dq 10

  ; more variables to be added as needed go here
  FoundPrompt db "The number %lli was found in the list.", 10, 0
  NotFoundPrompt db "The number %lli was not found in the list.", 10, 0
