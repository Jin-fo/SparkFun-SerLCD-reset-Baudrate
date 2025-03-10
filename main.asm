;
; SparkFun-SerLCD-reset-Baudrate.asm
;
; Created: 2/20/2025 9:45:20 AM
; Author : J
;
.nolist
.include "avr128db48def.inc"
.list

;r16 temp register
;r19 transmit data

start:
	;Baudrate 9600
	ldi r16, low(1667)
	sts USART3_BAUDL, r16
	ldi r16, high(1667)
	sts USART3_BAUDH, r16

	;Normal mode, 8 data bits, 1 stop bit, no parity
	ldi r16, 0x03
	sts USART3_CTRLC, r16

	;Enable receiver and transmitter
	ldi r16, 0xC0
	sts USART3_CTRLB, r16

	;Set IO ports
	sbi VPORTB_DIR, 0		;transmit output pin PB0
	cbi VPORTB_DIR, 1		;receive input pin PB1	

main:
	;On-bootup hardware reset
	ldi r19, 0x12
	rcall USART_TX

	;manual change to default baudrate with known baudrate
	;*insert*

	;Clear screen
	ldi r19, '|'
	rcall USART_TX
	ldi r19, '-'
	rcall USART_TX

	;enable RX hardware reset
	ldi r19, '|'
	rcall USART_TX
	ldi r19, 0x1A
	rcall USART_TX
	ldi r19, '|'
	rcall USART_TX
	ldi r19, 0x1A
	rcall USART_TX

	rjmp main
	;RX indeterminate, LCD does not TX 
	;Do matching signal check of transmit and received data
	test_case:
		rcall signal_check
		;Test until pass
		rjmp test_case


.include "subroutines.asm"
