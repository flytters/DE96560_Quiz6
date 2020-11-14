				#include<p18F4550.inc>

LOOP_CNT		SET	0x00
LOOP_CNT1		SET	0x01

				org	0x00
				goto start
				org	0x08
				retfie
				org	0x18
				retfie
			
dup_nop			macro hh
				variable	i
i	=	0
				while	i	<	hh
				nop
i	+=	1
				endw
				endm

;###################################################
;MAIN PROGRAM
;###################################################

start			CLRF	TRISD,A

loop			CALL	perform6
				CALL	DELAY60ms

				CALL	perform5
				CALL	DELAY60ms

				CALL	perform0
				CALL	DELAY60ms

				BRA	loop



;######################################################33
;SUBROUTINE FOR DISPLAY NUMBER
;######################################################


perform6		SETF	PORTD,A
				BCF	PORTD,1,A
				RETURN


perform5		SETF	PORTD,A
				BCF	PORTD,1,A
				BCF	PORTD,4,A
				RETURN

perform0		SETF	PORTD,A
				BCF	PORTD,6,A
				RETURN



;####################################################
;SUBROUTINES TO CREATE 60ms DELAY WITH 20MHZ CRYSTAL
;####################################################


DELAY60ms		MOVLW	D'250'
				MOVWF	LOOP_CNT1,A
AGAIN			MOVLW	D'30'
				MOVWF	LOOP_CNT,A
AGAIN1			dup_nop	D'37'
				DECFSZ	LOOP_CNT,F,A
				BRA	AGAIN1
				DECFSZ	LOOP_CNT1,F,A
				BRA AGAIN
				RETURN

				END