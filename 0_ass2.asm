include 'emu8086.inc'


getc macro p1
mov ah, 01h
int 21h
mov [p1], al
endm

org 100h ; use number key only (0-9)! numberpad or other inputs would break the program

; start:
; printn '[1] old user' ; login
; printn '[2] new user' ; register

; mov cx, 01h
; lea di, input
; rpt1: ; get character from user
; getc di ; 31h ascii input for 1 on keyboard , store user input into di
; cmp [di], 31h
; je login
; ; mov ah, 2h
; ; int 21h
; ; inc di
; printn ' '

; ; ; print input on screen
; ; mov ah, 0eh
; ; int 10h
; ; printn ' '

; loop rpt1
; ; putc 0ah
; ; putc 0dh

; jmp start

login:
call CLEAR_SCREEN
; printn 'Shoppe'
;printn '============='
printn '[1] pharmacy'
; printn '[2] Rice shop'
printn '[3] check out'
lea di, input
getc di
cmp [di], 31h
je pharmacy
cmp [di], 33h
je checkout

checkout:


pharmacy:
call CLEAR_SCREEN
printn '[1]'
printn '[2]'
printn '[3]'
printn '[4]'
printn '[0] back'
lea di, input
getc di
cmp [di], 31h
je sanitizer
cmp [di], 32h
je mask
cmp [di], 33h
je spray
cmp [di], 34h
je tkit
cmp [di], 30h
je login

sanitizer:
printn ' -q?'
lea di, input
getc di
mov cx, [di]
sub cx, 30h
mov [di], dx
lea di, psanitizer
mov dx, [di]
mov ax, dx
mul cx
push ax
lea di, quantity
mov dx, [di]
rpt2:
inc dx
loop rpt2
mov [di], dx
jmp pharmacy

mask:
printn ' -q?'
lea di, input
getc di
mov cx, [di]
sub cx, 30h
mov [di], dx
lea di, pmask
mov dx, [di]
mov ax, dx
mul cx
push ax
lea di, quantity
mov dx, [di]
rpt3:
inc dx
loop rpt3
mov [di], dx
jmp pharmacy

spray:
printn ' -q?'
lea di, input
getc di
mov cx, [di]
sub cx, 30h
mov [di], dx
lea di, pspray
mov dx, [di]
mov ax, dx
mul cx
push ax
lea di, quantity
mov dx, [di]
rpt4:
inc dx
loop rpt4
mov [di], dx
jmp pharmacy

tkit:
printn ' -q?'
lea di, input
getc di
mov cx, [di]
sub cx, 30h
mov [di], dx
lea di, ptkit
mov dx, [di]
mov ax, dx
mul cx
push ax
lea di, quantity
mov dx, [di]
rpt5:
inc dx
loop rpt5
mov [di], dx
jmp pharmacy


DEFINE_CLEAR_SCREEN
ret

input       db 2 dup (0)
quantity    db 2 dup (0) ; q:255
psanitizer  dw 1 dup (19h) ;rm25 q:255
pmask       dw 1 dup (0Ah) ;rm10 q:255
pspray      dw 1 dup (0Dh) ;rm13 q:255
ptkit       dw 1 dup (28h) ;rm40 q:255


end