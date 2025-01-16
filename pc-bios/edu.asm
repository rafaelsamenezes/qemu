section .text
    global _start

_start:
    ; Initialize COM1 serial port (0x3F8 is the base address for COM1)
    mov dx, 0x03F8         ; COM1 base port address
    mov al, 0x80           ; Enable DLAB (Divisor Latch Access Bit)
    out dx, al             ; Send to COM1 port

    ; Set baud rate to 9600 (divisor = 3 for 9600 baud)
    mov dx, 0x03F8         ; COM1 base port address
    mov al, 0x03           ; Set lower byte of divisor (3 -> baud rate 9600)
    out dx, al             ; Send lower byte of divisor

    inc dx                 ; Move to the next byte (upper byte of divisor)
    mov al, 0x00           ; Set upper byte of divisor to 0
    out dx, al             ; Send upper byte of divisor

    ; Disable DLAB (Divisor Latch Access Bit)
    dec dx
    mov al, 0x03           ; Set line control register (8 data bits, 1 stop bit)
    out dx, al             ; Send to COM1 port to disable DLAB

    ; Send 'h' to COM1
    mov dx, 0x03F8         ; COM1 base port address
    mov al, 'h'            ; Character to send ('h')
    out dx, al             ; Write to COM1 port

    ; Hang the execution (infinite loop)
hang:
    jmp hang
