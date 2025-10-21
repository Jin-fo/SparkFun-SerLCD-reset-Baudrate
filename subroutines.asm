
.cseg
post_home: .db "SERLCD 20x4", 0x0D, 0x0A, "BaudRate Reset", 0x0D, 0x0A, "ESE280/381", 0x0D, 0x0A, "By:Jin Y.Chen", 0x00, 0x00


;***************************************************************************
;* 
;* "display_post_home" - show the home screen message
;*
;* Description:
;*	
;* Parameters: r19
;*
;* Returns: r19
;*
;***************************************************************************
display_post_home:
	//insert code here
	ldi ZL, LOW(post_home * 2)
	ldi ZH, HIGH(post_home * 2)

	send:
	lpm r19, Z+
	cpi r19, 0x00
	breq end 
	rcall USART_TX
	rjmp send

	end:
	ret

; ***************************************************************************
; * 
; * "USART_TX" - Data Transmitter
; *
; * Description:
; *	Transmit data to USART3
; *
; * Parameters: r16, r19    
; *
; * Returns: r19
; *
; * Notes: 
; *
; ***************************************************************************
USART_TX:
	lds r16, USART3_STATUS		; load USART3 status
	sbrs r16, 5					; skip if transmit buffer is empty
	rjmp USART_TX				; wait until buffer is empty

	sts USART3_TXDATAL, r19		; send transmit data
	ret

; ***************************************************************************
; * 
; * "USART_RX" - Data Receiver
; *
; * Description:
; *	Receive data from USART3
; *
; * Parameters: r16, r20
; *
; * Returns: r20
; *
; * Notes: 
; *
; ***************************************************************************
USART_RX:
	lds r16, USART3_RXDATAH  	; load receive status
	sbrs r16, 7              	; skip if receive complete flag is set
	rjmp USART_RX           
	lds r20, USART3_RXDATAL 	; load received data
	ret

;***************************************************************************
;* 
;* "delay_1s" - Response delay seconds
;*
;* Description:
;* Send ASCII character in r20 for USART to transmit
;* Author:
;* Version:
;* Last updated:
;* Target:
;* Number of words:
;* Number of cycles:
;* Low registers modified:
;* High registers modified:
;*
;* Parameters: r20
;*
;* Returns: 
;*
;* Notes: 
;*
;***************************************************************************
delay_1s:
	ldi r30, low(5234) ;input update delay restriction
	ldi r31, high(5234)
	outer_loop:
	ldi r29, $ff
	inner_loop:
	dec r29
	brne inner_loop
	sbiw r31:r30, 1
	brne outer_loop
	ret
