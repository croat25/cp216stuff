*-----------------------------------------------------------
* Program    : q1
* Written by : David Brown, Nora Znotinas
* Date       : 2012-03-09; modified 2016-03-19
* Modified by:bruno salapic
* Date       :
* Description: Writes a red rectangle to the screen buffer.
*-----------------------------------------------------------
	
	
	
START	ORG	$400

*===========================================================

            move.l  #50,rectangle           ; move x
            move.l  #160,rectangle+4        ;move y 
            move.l  #100,rectangle+8        ; move width
            move.l  #300,rectangle+12       ; move height
            pea     rectangle
            move.l  #600,sb                 ;
            move.l  #400,sb+4               ;screen buffer size

*===========================================================
	
* Display the screen buffer.
            PEA     SB
            JSR     RED_RECTANGLE
            ADDA.L  #8,SP
            
            move.l  #250,rectangle          ; move x
            move.l  #300,rectangle+4        ;move y 
            move.l  #350,rectangle+8        ; move width
            move.l  #20,rectangle+12        ; move height
            
            pea     rectangle
            
            move.l  #600,sb
            move.l  #400,sb+4
            pea     sb
            jsr     RED_RECTANGLE
            jsr     sb_dsp
            adda.l  #8,sp
            

	STOP	#$2700

*-----------------------------------------------------------
* Includes
	INCLUDE 'graphic_util.X68'
	INCLUDE 'buffer_util2.X68'
RED_RECTANGLE
	INCBIN 'red_rectangle.bin'

	
*-----------------------------------------------------------
* DATA AREA
*
* Rectangle structure definition.
*
* Equivalent C Definition: 
* typedef struct rectangleType {
*    int32 x;
*    int32 y;
*    int32 width;
*    int32 height;
* } rectangleType;

RECTANGLE	DS.L	1	* x
	DS.L	1	* y
	DS.L	1	* width
	DS.L	1	* height


	END	START







*~Font name~Courier New~
*~Font size~10~
*~Tab type~0~
*~Tab size~8~
