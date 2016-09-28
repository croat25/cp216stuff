*-----------------------------------------------------------
* Program    : q3
* Written by : bruno salapic
* Date       : 2012-03-09; modified 2016-03-19
* Modified by:
* Date       :
* Description: Writes a red rectangle to the screen buffer.
*-----------------------------------------------------------
	ORG	$400
START	

*===========================================================
nextround
            clr.l   d2
            clr.l   d3
            clr.l   d4
            clr.l     d1
            lea     entry,a1                ; get entry
            jsr     p_str                   ;prt str
            jsr     readnum                 ;get num
           
            move.l  d1,-(sp)
            jsr     readnum                 ;get num store on stakc
            move.l  d1,-(sp)
            move.l  output,-(sp)
            jsr     max
            
            clr.l   d2
            clr.l   d3
            clr.l   d4
            clr.l     d1
            lea     entry,a1                ; get entry
            jsr     p_str                   ;prt str
            jsr     readnum                 ;get num
           
            move.l  d1,-(sp)
            jsr     readnum                 ;get num store on stakc
            move.l  d1,-(sp)
            move.l  output,-(sp)
            jsr     max
            
            clr.l   d2
            clr.l   d3
            clr.l   d4
            clr.l     d1
            lea     entry,a1                ; get entry
            jsr     p_str                   ;prt str
            jsr     readnum                 ;get num
           
            move.l  d1,-(sp)
            jsr     readnum                 ;get num store on stakc
            move.l  d1,-(sp)
            move.l  output,-(sp)
            jsr     max
*===========================================================
	bra     nextround
* Display the screen buffer.
            
            
	STOP	#$2700

*-----------------------------------------------------------
* Includes
	INCLUDE 'graphic_util.X68'
	INCLUDE 'buffer_util2.X68'
	include 'io_util.x68'
	
RED_RECTANGLE
	INCBIN 'red_rectangle.bin'

max            link    a6,#0
         movem.l d1-d7/a0-a2,-(sp)
            move.l  16(a6),d2
            move.l  12(a6),d1               ; stack frame
            move.l  8(a6),d3
            
            cmp.l   #0,d1
            blt     magnitude
            cmp.l   #0,d2                   ; compare to see if to negate
            blt     magnitude2
            cmp.l   #$88888888,d1
            bgt     magnitude3              
            cmp.l   #$88888888,d2
            bgt     magnitude4
            
backhere            cmp.l     d2,d1
            beq     same                    ; compare to see if equal or lower or greater
            cmp.l     d1,d2
            blt     dee1
            cmp.l     d1,d2
            bgt     dee2
            cmp.l   d2,d1
            bgt     dee3                    
            cmp.l   d2,d1
            blt     dee4
            
begin            movem.l d1-d7/a0-a2,-(sp)
            unlk    a6
            rts
            
            
            
            
magnitude   move.l  #1,d3
            bra     after                   ;set flags
magnitude2  move.l  #2,d3
            bra     after
magnitude3  cmp.l   #$88888888,d1
            blt     setflag1
backset     bra     after
magnitude4  cmp.l   #$88888888,d2           ;setflags
            blt     setflag2
backset1            bra     after
after            cmp.l   #1,d3
            beq     negate1
            cmp.l   #2,d3
            beq     negate2
            bra     backhere                ;check to see which ones to negate
negate1     move.l    #0,d3
            move    d1,d5
            clr.l     d1                    ; negate shit
            neg     d5
            move.w  d5,d1
            bra     dee1

negate2     move.l    #0,d3
            move    d2,d5
            clr.l     d2
            neg     d5
            move.w  d5,d2
            bra     dee2       
            
dee1        move.l  d1,d3
            lea     max1,a1
            jsr     p_str
            jsr     displaynum
            bra     begin
dee2        move.l    d2,d1                 ; different prints
            move.l  d2,d3
            lea     max1,a1
            jsr     p_str
            jsr     displaynum
            bra     begin
dee4        move.l  d2,d3
            lea     max1,a1
            jsr     p_str
            jsr     displaynum
            bra     begin
dee3        move.l    d1,d1
            move.l  d1,d3
            lea     max1,a1
            jsr     p_str
            jsr     displaynum
            bra     begin            
same        lea     samestr,a1
            jsr     p_str
            rts	
            
            
setflag1    move    #1,d3
            bra      backset
setflag2    move    #2,d3
            bra     backset1           
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


entry      dc.b      'enter in a two numbers to see max absolute range between 1-128: ',0
max1         dc.b    'max of the two is : ',0
samestr     dc.b    'same same but different but still same',0


output      ds.l    1
table	DS.L	1	
	DS.L	1	
	DS.L	1	
	DS.L	1	
            ds.l    1                       

	END	START






*~Font name~Courier New~
*~Font size~10~
*~Tab type~0~
*~Tab size~8~
