*-----------------------------------------------------------
* Program    : q2
* Written by : david brown
* Date       : 2012-03-09; modified 2016-03-19
* Modified by:  bruno salapic
* Date       :
* Description: draws
*-----------------------------------------------------------
	
redrec      incbin  'red_rectangle.bin'
	
	
START	ORG	$400

*===========================================================

            
           
            
            lea     rectangle,a1	
	move.l	#100,(a1)+		x
	move.l	#100,(a1)+		y
	move.l	#350,(a1)+		Width
	move.l	#50,(a1)		Height
	lea	sb,a1		
	move.l	#600,(a1)+              ;buffer width
	move.l	#400,(a1)+	;buffer height
	move.l	#$01,-(sp)		Fill rectangle
	move.l	#$00771177,-(sp)
	
		
	pea	rectangle	;push on stack 
	pea	sb		; push sb on stack
	jsr	fill	;go to subroutine
	adda.l	#16,sp

            lea	rectangle,a1	
	move.l	#150,(a1)+		x
	move.l	#100,(a1)+		y
	move.l	#50,(a1)+		Width
	move.l	#350,(a1)		Height
	lea	sb,a1		
	move.l	#600,(a1)+              ;buffer width
	move.l	#400,(a1)+	;buffer height
	move.l	#$00,-(sp)		empty rectangle
	move.l	#$00777711,-(sp)
	
		
	pea	rectangle	;push on stack 
	pea	sb		; push sb on stack
	jsr	fill	;go to subroutine
	adda.l	#16,sp
	
	lea	rectangle,a1	
	move.l	#350,(a1)+		x
	move.l	#100,(a1)+		y
	move.l	#350,(a1)+		Width
	move.l	#50,(a1)		Height
	lea	sb,a1		
	move.l	#600,(a1)+              ;buffer width
	move.l	#400,(a1)+	;buffer height
	move.l	#$01,-(sp)		Fill rectangle
	move.l	#$00117777,-(sp)
	
		
	pea	rectangle	;push on stack 
	pea	sb		; push sb on stack
	jsr	fill	;go to subroutine
	adda.l	#16,sp
	
	lea	rectangle,a1	
	move.l	#100,(a1)+		x
	move.l	#400,(a1)+		y
	move.l	#50,(a1)+		Width
	move.l	#350,(a1)		Height
	lea	sb,a1		
	move.l	#600,(a1)+              ;buffer width
	move.l	#400,(a1)+	;buffer height
	move.l	#$00,-(sp)		empty rectangle
	move.l	#$00117711,-(sp)
	
		
	pea	rectangle	;push on stack 
	pea	sb		; push sb on stack
	jsr	fill	;go to subroutine
	adda.l	#16,sp
            pea     sb
            jsr     sb_dsp
            adda.l  #16,sp
*===========================================================
	
* Display the screen buffer.
 
            

	STOP	#$2700

*-----------------------------------------------------------
* Includes
	INCLUDE 'graphic_util.X68'
	INCLUDE 'buffer_util2.X68'
RED_RECTANGLE
	INCBIN 'red_rectangle.bin'

	
fill        link    a6,#0
            movem.l d0-d5/a1-a4/a6,-(sp)
            
            
           
            move.l  8(a6),a2                
            move.l  12(a6),a1
           move.l  20(a6),d4
            cmp.l   #00,d4
            beq     empty                   ;check to look at flag to see if empty or fill
   
            clr     d4                      
            
           
            move.l  12(a1),d4               ;height
            move.l  8(a1),d3                ;width
            move.l  4(a1),d2                ;y
            move.l  0(a1),d1                ;x
            move.l  (a2),d6                 
            mulu    d6,d1
            sub.l   d3,d6
            lsl.l   #2,d6
            lsl.l   #2,d1                   ;lsl for longword
            lsl.l   #2,d2                   
            
            add.l   d2,d1
            sub.l   #1,d4
            add.l   #8,a2
            add.l   d1,a2                   ; offset
            
           
            
len         move.l  d3,d7
            sub.l   #1,d7
final       move.l  16(a6),(a2)+            ;load colours
            dbra    d7,final                ;decrement branch 
            adda.l  d6,a2
            dbra    d4,len                  ; dbra
            movem.l (sp)+,d0-d5/a0/a2-a4/a6
            unlk    a6
            rts


empty       clr     d4
            
            move.l  12(a1),d4               ;height
            move.l  8(a1),d3                ;width
            move.l  4(a1),d2                ;y
            move.l  0(a1),d1                ;x      
            move.l  (a2),d6
            mulu    d6,d1
            move.l  (a2),d6
            sub.l   d3,d6
            lsl.l   #2,d6                   ;lsl for longword
            lsl.l   #2,d1
            lsl.l   #2,d2
            add     d2,d1
            sub.l   #1,d3
            sub.l   #1,d4
            add.l   d1,a2
            add.l   #8,a2
            
            
           
final1      move.l  16(a6),(a2)+
            dbra    d3,final1                
            adda.l  d6,a2
final2      move.l  8(a1),d3
            move.l  16(a6),(a2)+
            
            move.l  d3,d7
            sub     #2,d7
            lsl.l   #2,d7
            add.l   d7,a2
            move.l  16(a6),(a2)+
            adda.l  d6,a2
            dbra    d4,final2
            sub     #1,d3

border      move.l  16(a6),(a2)+
            dbra    d3,border               
            movem.l (sp)+,d0-d5/a0/a2-a4/a6
            unlk    a6
            rts            
            
            
            
            
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
