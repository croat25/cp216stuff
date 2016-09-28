*-----------------------------------------------------------
* Title      :a10q2
* Written by :Bruno Salapic	
* Date       :2016/mar/26
* Description:q2
*-----------------------------------------------------------
length      equ     640 

            org     $00
            dc.l    start
            dc.l    start
            
            org     $6c
            dc.l    vertical
            
            org     $74
            dc.l    colourchange
   
START:      org		$1000        ; first instruction of program

            jsr clearscreen
            jsr enableexception             
            jsr drawcolour              main rountine
            jsr setcoordinates                          
            jsr     loop        

end    		stop 		#$2700

loop        move    #82,d0
            trap    #15
            
            cmp     #length,d1          ; compare the length if eq then new line
            beq     newline
            addq     #1,d1
            move.l  #$3fff,d7      
delay       cmp.l   #0,d7                   ;delay looop
            dbeq    d7,delay
            bra     loop     
newline         move.w    #0,d1
                addq.w    #1,d2                 
                bra     loop

vertical    move    d1,d3
            move    #0,d4
            
            jsr     settocolor          ;set colour
            
draw        move    #82,d0
            trap    #15                 draw
            cmp.l   #640,d2
                beq     end 
                cmp.l   #80,d4
                beq     verticalend 
            
             addq    #1,d2
            addq     #1,d4
            move.l  #$3fff,d7
stall       cmp.l   #0,d7
            dbeq    d7,stall
            bra     draw 
verticalend move    d1,d3               ;draw it to screen
            move    #80,d0
            move.l  #$0000ff00,d1
            trap    #15
            move    d3,d1
            rte

colourchange    move    d1,d3               
                move    #0,d4
                jsr settocolor2             ; color change
horiz2          move        #82,d0  
                trap    #15
                
                cmp #640,d1
                beq newlinesamecolour       newline same colour if the line extends past to the right and not 
                cmp #640,d2                 enough pixels have been drawn then make new line and still use the colour intended for the 
                
                beq end                 remaining pixels
                cmp #80,d4
                beq sendtorte
                addq #1,d1
                addq #1,d4
                move    #$3fff,d7
stall2                cmp #0,d7
                dbeq    d7,stall2           delay loopp
                bra horiz2
                
newlinesamecolour   move    #0,d1
                    addq #1,d2
                    bra horiz2
sendtorte       move    d1,d3
                move    #80,d0
                move.l  #$0000ff00,d1
                trap    #15
                move    d3,d1
                 rte
    
clearscreen     move.w  #$ff00,d1
                moveq    #11,d0
                trap    #15
                rts
                
enableexception move.b  #5,d1
                move.b  #32,d0
                trap    #15
                rts
                
drawcolour      move.l    #$0000ff00,d1
                move.b      #80,d0
                trap    #15
                rts                    
settocolor      move    #80,d0
                move.l  #$000000ff,d1
                trap    #15
                move    d3,d1
                rts
setcoordinates
                move    #0,d1           
                move    #0,d2 
                rts

settocolor2     move.l  #$00808080,d1
                move    #80,d0
                trap    #15
                move    d3,d1
                rts 
               END    START        ; last line of source


*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
