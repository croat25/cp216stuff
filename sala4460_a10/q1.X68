*-----------------------------------------------------------
* Title      :a10q1
* Written by :Bruno Salapic	
* Date       :2016/mar/26
* Description:q
*-----------------------------------------------------------
    org $0
    dc.l    start
    dc.l    start
START:      org		$1000        ; first instruction of program
            jsr     clearscreen     ; clearing the screen
            jsr     enableexception     ; enable exceptions
            jsr     drawcolour          ;drawcolor
            jsr     setcoordinates      
            jsr     loop            ;loopfunction to executre main part of program
            stop 		#$2700

loop        move    #82,d0          ;draw pixel in pen color
            trap    #15      
            cmp     #640,d1         ; see if it reaches the end of the screen then new line start on left side 1 pixel under neat
            bne     nextpixel
            move    #0,d1
            addq    #1,d2
            bra     loop
nextpixel   addq.w  #1,d1       ; next pixel
            move.l  #$8FFF,d7
delay       cmp.l   #0,d7
            dbeq    d7,delay        ;delay loop week 2 stuff
            bra     loop 

clearscreen     move.w  #$ff00,d1
                move    #11,d0
                trap    #15             ;clear screen subroutine
                rts
                
enableexception move.b  #5,d1           ;enable exceptions subroutine
                move.b  #32,d0
                trap    #15
                rts
                
drawcolour      move.l    #$0033ff22,d1         ;draw color
                move.b      #80,d0
                trap    #15
                rts                    

setcoordinates move    #0,d1           
                move    #0,d2 
                rts               
* Put variables and constants here

    END    START        ; last line of source



*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
