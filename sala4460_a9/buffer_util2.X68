*-----------------------------------------------------------
* Program    : screen
* Written by : David Brown, Nora Znotinas
* Date       : 2016-03-11
* Description: Screen Buffer Simulation Utilities
*-----------------------------------------------------------
* Screen buffer definition.
*	
* Constants: maximum size of screen buffer in pixels.
* Because we do not know how large a screen buffer we need ahead of time,
* define the largest possible screen buffer we might need.
SB_W_MAX	EQU	1920	* Maximum width of the screen buffer.
SB_H_MAX	EQU	1200	* Maximum height of the screen buffer.
SB_S_MAX	EQU	SB_W_MAX*SB_H_MAX	* Maximum screen buffer size in pixels. 

* Screen buffer is 1 long word per pixel.
* Each long word stores the pixel color in $00BBGGRR format.
* Beginning address of buffer is pixel at 0,0 (upper left corner).
* Pixels are stored in row major order: X is incremented within Y.
* i.e. 0,0 * 1,0 * 2,0 * 3,0 * etc.

* Equivalent C Definition of the screen buffer structure: 
* typedef struct bufferType {
*    int32 width;
*    int32 height;
*    void *buffer;
* } bufferType;

SB	DS.L	1	* Screen Width in pixels.
	DS.L	1	* Screen Height in pixels.
	DS.L	SB_S_MAX	* Screen buffer declared at maximum size.
SB_E	EQU	*	* Screen buffer end address.
	

*-----------------------------------------------------------
* Clear the screen buffer. Set every pixel to an arbitrary colour.
* Parameters:
*   Screen buffer structure (address).
*   Screen buffer colour (long word).
* Variables:
*   A0.L: address of screen buffer data.
*   A1.L: address of buffer structure.
*   D1.L: screen buffer colour.
*   D2.L: screen buffer size in pixels.
*   D3.L: screen buffer height in pixels.

* C equivalent:
* void sb_clr( bufferType *buffer_structure, int32 colour );
SB_CLR	LINK	A6,#0
	MOVEM.L	D1-D3/A0-A1,-(SP)

	MOVE.L	8(A6),A1	* Set the screen buffer structure address.
	MOVE.L	12(A6),D1	* Set the colour value.
	MOVE.L	(A1),D2	* Set the screen buffer width.
	MOVE.L	4(A1),D3	* Set the screen buffer height.
	MULU	D3,D2	* Calculate size of actual screen buffer.
	LEA	8(A1),A0	* Set the address for the screen buffer image data.

P_LOOP	MOVE.L	D1,(A0)+	* Set the pixel colour.
	SUBQ.L	#1,D2	* Decrement the pixel count.
	BGT	P_LOOP	* Pixels left?
	
	MOVEM.L	(SP)+,D1-D3/A0-A1
	UNLK	A6
	RTS


*------------------------------------------------------------
* Display the contents of the screen buffer.
* Draws screen contents from top left across and down to bottom right.
* Parameters:
*   Screen buffer structure (address).
* Variables:
*   A0.L: address of screen buffer (image) data.
*   A1.L: address of buffer structure.
*   D1.L: pixel color.
*   D1.W: X position.
*   D2.W: Y position.
*   D3.L: holds X position.

* C equivalent:
* void sb_dsp( bufferType *buffer_structure );
SB_DSP	LINK	A6,#0
	MOVEM.L	D0-D3/A0-A1,-(SP)

	MOVE.L	8(A6),A1	* Set the screen buffer structure address.
	MOVE.L	(A1),D1	* Set buffer width in low word of D1.
	SWAP	D1	* Move buffer height to high word of D1.
	ADD.L	4(A1),D1	* Set buffer height in low word of D1.
	JSR	G_SIZE	* Set size of screen to match buffer size. (graphic_util.X68)

	LEA	8(A1),A0	* Set the screen buffer data address.

	CLR.L	D2	* Initialize Y position.

Y_LOOP	CLR.L	D1	* Initialize X position.

X_LOOP	EXG	D1,D3	* Preserve X position.

	* Set the output color - color stored in long word of screen buffer
	* in $00BBGGRR format. (Defined by EASy68K Simulator graphics tasks.)
	MOVEQ.L	#80,D0	* Set color task number.
	MOVE.L	(A0)+,D1	* Copy pixel color value to D1.
	TRAP	#15	* Set the pen color.
	EXG	D1,D3	* Return X position.

	MOVEQ.L	#82,D0	* Set draw pixel task number.	
	TRAP	#15	* Draw the pixel at X,Y.
	
	ADDQ.L	#1,D1	* Increment X.
	CMP.L	(A1),D1	* End of row?
	BLT	X_LOOP	*   No - move to next column.

	ADDQ.L	#1,D2	* Increment Y.
	CMP.L	4(A1),D2	* End of image?
	BLT	Y_LOOP	*   No - move to next row.
		
	MOVEM.L	(SP)+,D0-D3/A0-A1
	UNLK	A6
	RTS

*------------------------------------------------------------





*~Font name~Courier New~
*~Font size~10~
*~Tab type~0~
*~Tab size~8~
