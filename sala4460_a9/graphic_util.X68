*-----------------------------------------------------------
* Program    : graphic_util
* Written by : David Brown
* Date       : 2015-03-02
* Description: Graphics Utilities
*
* D0 contains the task code telling the simulator the type
*	of I/O to perform
*-----------------------------------------------------------
* Set graphics color.
* Parameters:
*   D1.L: Pen color as $00GGBBRR.
* Variables:
*   D0: I/O task number.
G_COLOR	MOVEM.L D0,-(SP)

	MOVEQ.L	#80,D0
	TRAP	#15

	MOVEM.L (SP)+,D0
	RTS

*-----------------------------------------------------------
* Display the pixel at X,Y in current color.
* Parameters:
*   D1.W: Pixel X position.
*   D2.W: Pixel Y position.
* Variables:
*   D0.L: I/O task number.
G_PIXEL	MOVEM.L D0,-(SP)

	MOVEQ.L	#82,D0
	TRAP	#15

	MOVEM.L (SP)+,D0
	RTS

*-----------------------------------------------------------
* Set the graphic screen size.
* Parameters:
*   D1.L: High 16 bits = Set width in pixels, minimum = 640
*   D1.L: Low 16 bits  = Set height in pixels, minimum = 480
* Variables:
*   D0.L: I/O task number.
G_SIZE	MOVEM.L D0,-(SP)

	MOVEQ.L	#33,D0
	TRAP	#15

	MOVEM.L (SP)+,D0
	RTS

*-----------------------------------------------------------

*~Font name~Courier New~
*~Font size~10~
*~Tab type~0~
*~Tab size~8~
