.section .data
R_const:    .double 5.000000
r_const:    .double 3.000000
h_const:    .double 10.000000
pi_const:   .double 3.141593
three_const:.double 3.0
fmt:        .asciz "Computed Volume: %f\n"

.section .bss
    .lcomm t0,8
    .lcomm t1,8
    .lcomm t2,8
    .lcomm t3,8
    .lcomm t4,8
    .lcomm t5,8
    .lcomm t6,8
    .lcomm t7,8
    .lcomm volume,8

.intel_syntax noprefix
.global main
.section .text
main:
    push rbp
    mov rbp, rsp

    movsd xmm0, qword PTR [R_const]
    mulsd xmm0, xmm0          # t0 = R^2
    movsd qword PTR [t0], xmm0

    movsd xmm1, qword PTR [R_const]
    mulsd xmm1, qword PTR [r_const]  # t1 = R*r
    movsd qword PTR [t1], xmm1

    movsd xmm2, qword PTR [r_const]
    mulsd xmm2, xmm2          # t2 = r^2
    movsd qword PTR [t2], xmm2

    movsd xmm3, qword PTR [t0]
    addsd xmm3, qword PTR [t1]
    addsd xmm3, qword PTR [t2]  # t3 = R^2 + Rr + r^2
    movsd qword PTR [t3], xmm3

    movsd xmm4, qword PTR [t3]
    mulsd xmm4, qword PTR [h_const]  # t4 = t3 * h
    movsd qword PTR [t4], xmm4

    movsd xmm5, qword PTR [t4]
    mulsd xmm5, qword PTR [pi_const] # t5 = t4 * π
    movsd qword PTR [t5], xmm5

    movsd xmm6, qword PTR [t5]
    divsd xmm6, qword PTR [three_const] # volume = t5 / 3
    movsd qword PTR [volume], xmm6

    lea rdi, [rel fmt]
    movsd xmm0, qword PTR [volume]
    xor eax, eax
    call printf

    mov eax, 0
    pop rbp
    ret
