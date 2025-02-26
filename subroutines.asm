
;.cseg
;post_home: .db "SERLCD 20x4", 0x0D, 0x0A, "Baud-Rate Reset", 0x0D, 0x0A, "ESE280/381", 0x0D, 0x0A, "Author: Jin Y.C.", 0x00

;===============================================================================
;  ___      _                 _   _             
; / __|_  _| |__ _ _ ___ _  _| |_(_)_ _  ___ ___
; \__ \ || | '_ \ '_/ _ \ || |  _| | ' \/ -_|_-<
; |___/\_,_|_.__/_| \___/\_,_|\__|_|_||_\___/__/
;===============================================================================


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

; ***************************************************************************
; * 
; * "Signal_check" - Matching Signal Check
; *
; * Description:
; *	Check for matching transmit and receive data, must transmit 
; *	't' and receive 't'.
; *
; * Parameters: r19, r20
; *
; * Returns: Null
; *
; ***************************************************************************
signal_check:
	ldi r19, 't'				; signal test case
	rcall USART_TX

	rcall USART_RX
	cp r19, r20
	breq pass
	ret

; ***************************************************************************
; * 
; * "Operational_pass" - LCD is operational
; *
; * Description:
; *	Send signal 'p' to indicate test passed, LCD is operational 
; * at normal baud rate(9600). The test should terminate.  
; * 
; * Parameters: r16
; *
; * Returns: 
; *
; ***************************************************************************
pass:
	ldi r16, 'p'				; signal test passed
	rcall USART_TX
	ret