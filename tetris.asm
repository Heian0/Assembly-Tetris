################ CSC258H1F Winter 2024 Assembly Final Project ##################
# This file contains our implementation of Tetris.
#
# Student 1: Name, Student Number
# Student 2: Name, Student Number (if applicable)
######################## Bitmap Display Configuration ########################
# - Unit width in pixels:       41
# - Unit height in pixels:      22
# - Display width in pixels:    1
# - Display height in pixels:   1
# - Base Address for Display:   0x10008000 ($gp)
##############################################################################



########
# --Features--
# full set (X)
# gravity (X)
# color (X)
# gravity increase (X)
# pause (X)
# preview (X)
# game over screen (X)
########

    .data
##############################################################################
# Immutable Data
##############################################################################
# The address of the bitmap display. Don't forget to connect it!
ADDR_DSPL:
    .word 0x10008000
# The address of the keyboard. Don't forget to connect it!
ADDR_KBRD:
    .word 0xffff0000

#Define Tetromino shapes 
I:
    .word 0, 0, 0, 0, 0x33B5E5, 0x33B5E5, 0x33B5E5, 0x33B5E5, 0, 0, 0, 0, 0, 0, 0, 0   
    .word 0, 0, 0x33B5E5, 0, 0, 0, 0x33B5E5, 0, 0, 0, 0x33B5E5, 0, 0, 0, 0x33B5E5, 0
    .word 0, 0, 0, 0, 0, 0, 0, 0, 0x33B5E5, 0x33B5E5, 0x33B5E5, 0x33B5E5, 0, 0, 0, 0
    .word 0, 0x33B5E5, 0, 0, 0, 0x33B5E5, 0, 0, 0, 0x33B5E5, 0, 0, 0, 0x33B5E5, 0, 0  
O:
    .word 0, 0xFFFF00, 0xFFFF00, 0, 0, 0xFFFF00, 0xFFFF00, 0, 0, 0, 0, 0, 0, 0, 0, 0
    .word 0, 0xFFFF00, 0xFFFF00, 0, 0, 0xFFFF00, 0xFFFF00, 0, 0, 0, 0, 0, 0, 0, 0, 0
    .word 0, 0xFFFF00, 0xFFFF00, 0, 0, 0xFFFF00, 0xFFFF00, 0, 0, 0, 0, 0, 0, 0, 0, 0
    .word 0, 0xFFFF00, 0xFFFF00, 0, 0, 0xFFFF00, 0xFFFF00, 0, 0, 0, 0, 0, 0, 0, 0, 0
S:
    .word 0, 0xFF0000, 0xFF0000, 0, 0xFF0000, 0xFF0000, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
    .word 0, 0xFF0000, 0, 0, 0, 0xFF0000, 0xFF0000, 0, 0, 0, 0xFF0000, 0, 0, 0, 0, 0
    .word 0, 0, 0, 0, 0, 0xFF0000, 0xFF0000, 0, 0xFF0000, 0xFF0000, 0, 0, 0, 0, 0, 0
    .word 0xFF0000, 0, 0, 0, 0xFF0000, 0xFF0000, 0, 0, 0, 0xFF0000, 0, 0, 0, 0, 0, 0
Z:
    .word 0x00FF00, 0x00FF00, 0, 0, 0, 0x00FF00, 0x00FF00, 0, 0, 0, 0, 0, 0, 0, 0, 0
    .word 0, 0, 0x00FF00, 0, 0, 0x00FF00, 0x00FF00, 0, 0, 0x00FF00, 0, 0, 0, 0, 0, 0
    .word 0, 0, 0, 0, 0x00FF00, 0x00FF00, 0, 0, 0, 0x00FF00, 0x00FF00, 0, 0, 0, 0, 0
    .word 0, 0x00FF00, 0, 0, 0x00FF00, 0x00FF00, 0, 0, 0x00FF00, 0, 0, 0, 0, 0, 0, 0
L:
    .word 0, 0, 0xFFA500, 0, 0xFFA500, 0xFFA500, 0xFFA500, 0, 0, 0, 0, 0, 0, 0, 0, 0
    .word 0, 0xFFA500, 0, 0, 0, 0xFFA500, 0, 0, 0, 0xFFA500, 0xFFA500, 0, 0, 0, 0, 0
    .word 0, 0, 0, 0, 0xFFA500, 0xFFA500, 0xFFA500, 0, 0xFFA500, 0, 0, 0, 0, 0, 0, 0
    .word 0xFFA500, 0xFFA500, 0, 0, 0, 0xFFA500, 0, 0, 0, 0xFFA500, 0, 0, 0, 0, 0, 0
J:
    .word 0xFF80BF, 0, 0, 0, 0xFF80BF, 0xFF80BF, 0xFF80BF, 0, 0, 0, 0, 0, 0, 0, 0, 0
    .word 0, 0xFF80BF, 0xFF80BF, 0, 0, 0xFF80BF, 0, 0, 0, 0xFF80BF, 0, 0, 0, 0, 0, 0
    .word 0, 0, 0, 0, 0xFF80BF, 0xFF80BF, 0xFF80BF, 0, 0, 0, 0xFF80BF, 0, 0, 0, 0, 0
    .word 0, 0xFF80BF, 0, 0, 0, 0xFF80BF, 0, 0, 0xFF80BF, 0xFF80BF, 0, 0, 0, 0, 0, 0
T:
    .word 0, 0x800080, 0, 0, 0x800080, 0x800080, 0x800080, 0, 0, 0, 0, 0, 0, 0, 0, 0
    .word 0, 0x800080, 0, 0, 0, 0x800080, 0x800080, 0, 0, 0x800080, 0, 0, 0, 0, 0, 0
    .word 0, 0, 0, 0, 0x800080, 0x800080, 0x800080, 0, 0, 0x800080, 0, 0, 0, 0, 0, 0
    .word 0, 0x800080, 0, 0, 0x800080, 0x800080, 0, 0, 0, 0x800080, 0, 0, 0, 0, 0, 0
    
Pause_button:
    .byte 1, 1, 1, 1, 1, 1, 1
    .byte 1, 0, 0, 0, 0, 0, 1
    .byte 1, 0, 1, 0, 1, 0, 1
    .byte 1, 0, 1, 0, 1, 0, 1
    .byte 1, 0, 1, 0, 1, 0, 1
    .byte 1, 0, 0, 0, 0, 0, 1
    .byte 1, 1, 1, 1, 1, 1, 1, 0, 0, 0
    
game_over_screen:
    .word 0x094510,0x094510,0x094510,0,0x094510,0x094510,0,0,0,0x094510,0x094510,0x094510
    .word 0x094510,0,0,0,0,0x094510,0x094510,0,0x094510,0x094510,0,0
    .word 0x094510,0,0x094510,0x094510,0x094510,0x094510,0,0x094510,0,0x094510,0x094510,0x094510
    .word 0x094510,0,0,0x094510,0,0x094510,0,0,0,0x094510,0,0,
    .word 0,0x094510,0x094510,0,0,0x094510,0x094510,0x094510,0,0x094510,0x094510,0x094510
    .word 0x094510,0,0,0x094510,0,0x094510,0,0,0,0x094510,0,0x094510
    .word 0x094510,0,0,0x094510,0,0x094510,0x094510,0x094510,0,0x094510,0x094510,0
    .word 0x094510,0,0,0x094510,0,0x094510,0,0,0,0x094510,0,0x094510
    .word 0,0x094510,0x094510,0x000000,0x094510,0x000000,0x094510,0x094510,0x094510,0x094510,0,0x094510
    .word 0, 0x000000, 0x8fe38f, 0x0f800f, 0x0db50d, 0x609e60, 0x0db50d, 0x8fe38f, 0x0f800f, 0x0db50d, 0x000000, 0
    .word 0, 0x000000, 0x004501, 0x000001, 0x000001, 0x609e60, 0x0f800f, 0x000001, 0x000001, 0x8fe38f, 0x000000, 0
    .word 0, 0x000000, 0x609e60, 0x000001, 0x000001, 0x8fe38f, 0x0db50d, 0x000001, 0x000001, 0x004501, 0x000000, 0
    .word 0, 0x000000, 0x0f800f, 0x8fe38f, 0x609e60, 0x000001, 0x000001, 0x0db50d, 0x0f800f, 0x004501, 0x000000, 0
    .word 0, 0x000000, 0x609e60, 0x0f800f, 0x000001, 0x000001, 0x000001, 0x000001, 0x0db50d, 0x8fe38f, 0x000000, 0
    .word 0, 0x000000, 0x0f800f, 0x004501, 0x000001, 0x000001, 0x000001, 0x000001, 0x609e60, 0x0db50d, 0x000000, 0
    .word 0, 0x000000, 0x609e60, 0x004501, 0x000001, 0x0f800f, 0x8fe38f, 0x000001, 0x0db50d, 0x8fe38f, 0x000000, 0
    .word 0,0,0,0,0,0,0,0,0,0,0,0
##############################################################################
# Mutable Data
##############################################################################
scene:
    .word 0x00: 902
    
locations:
    .word 0, 0, 0, 0 

##############################################################################
# Code
##############################################################################
	.text
	.globl main

	# Run the Tetris game.

    
main:
    # Initialize the game
    li $v0, 32
	li $a0, 1
	syscall

    # $s2 for storing current tetromino
    li $s3, 400 # for gravity increase over time
    move $s1, $s3 # for gravity
    lw $s4, ADDR_DSPL
    li $s5, 0                       # for storing curr rotation
    
    li $v0, 42
    li $a0, 0
    li $a1, 7
    syscall
    la $s6, I   # $s6 for storing next tetromino location
    
    lw $s7, ADDR_DSPL               # for storing curr location of block
    addi $s7, $s7, 16
    
    
    
    initiate_border:
    li $t1, 0x17161A                # background color
    li $t2, 0xF0EAD6     # border color

    li $t3, 0
    li $t6, 0
    li $t7, 3444
    grey_loop:
        bgt $t3, 3604, side_border_loop
        li $t4, 0
        add $t4, $s4, $t3
        sw $t1, ($t4)
        addi $t3, $t3, 4
        j grey_loop

    side_border_loop:
        bgt $t6, 3444, bottom_border_loop
        li $t4, 0
        li $t5, 0
        add $t4, $s4, $t6
        add $t5, $t4, 44
        sw $t2, ($t4)
        sw $t2, ($t5)
        addi $t6, $t6, 164 
        j side_border_loop

    bottom_border_loop:
        bgt $t7, 3488, initiate_tetromino
        li $t4, 0
        add $t4, $s4, $t7
        sw $t2, ($t4)
        addi $t7, $t7, 4
        j bottom_border_loop
 
initiate_tetromino:
beqz, $a0, store_board
addi $s6, $s6, 256
addi $a0, $a0, -1
b initiate_tetromino
   
# new piece start here ------------------------------------------------
store_board_plus:
li $a2, 0
store_board:
# reset block pointer
lw $s7, ADDR_DSPL               
addi $s7, $s7, 16
li $s5, 0

    lw $t0, ADDR_DSPL
    la $t1, scene
    li $t2, 0 # index
    store_loop:
        lw $t3, 0($t0)
        sw $t3, 0($t1)
        addi $t0, $t0, 4
        addi $t1, $t1, 4
        addi $t2, $t2, 1
        ble $t2, 902, store_loop
    
# begin clear line
la $t0, scene # curr_row
addi $t0, $t0, 4
li $t8, 0x17161A # background color
li $t7, 0xF0EAD6 # border color

li $t9, 0xFFC0CB
detect_next_line:
    addi $t0, $t0, 164
    move $t1, $t0
    lw $t2, 0($t1)
    beq $t2, $t7, load_tetromino
    # check if this row is full
    detect_line_loop:
        lw $t2, 0($t1)
        #sw $t9, 0($t1)
        beq $t2, $t8, detect_next_line
        beq $t2, $t7, clear_line
        addi $t1, $t1, 4
        b detect_line_loop

clear_line:
move $t3, $t0 # $t0 is curr row
la $t5, scene # stopping point
addi $t5, $t5, 4
clear_next_line:
addi $t3, $t3, -164
move $t4, $t3
beq $t3, $t5, detect_next_line
clear_line_loop:
    lw $t2, 0($t4)
    beq $t2, $t7, clear_next_line
    sw $t2, 164($t4)
    addi $t4, $t4, 4
    b clear_line_loop
    
load_tetromino:
move $s2, $s6
la $s6, I
li $v0, 42
li $a0, 0
li $a1, 7
syscall
    goto_tetromino:
        beqz, $a0, print_scene
        addi $s6, $s6, 256
        addi $a0, $a0, -1
        b goto_tetromino   

# everything before this is for new piece ---------------------------------------

print_scene:
    la $t0, scene
    lw $t1, ADDR_DSPL
    li $t2, 0 # index
    print_loop:
        lw $t3, 0($t0)
        sw $t3, 0($t1)
        addi $t0, $t0, 4
        addi $t1, $t1, 4
        addi $t2, $t2, 1
        ble $t2, 902, print_loop     

draw_shape:
    move $t1, $s2 # this decides what tetromino is being printed
    li $t2, 0 # index
    li $t3, 0 # index for bigger loop
    lw $t5, ADDR_DSPL
    addi $t5, $t5, 380
    li $t7, 0x101010 # color for preview background
    li $t8, 0
    li $a3, 0
    
        shape_loop:
        # print curr tetromino
        lw $t4, 0($t1)
        beqz $t4, skip
            li $a0, 0x17161A # background color
            lw $a1, 0($s7)
            bne $a1, $a0, game_over  # game over
            sw $t4, 0($s7)
            addi $a3, $a3, 4
        
        skip:
        # print preview
        lw $t6, 0($s6)
        bne $t8, 12 skip1
            addi $t5, $t5, -656
        skip1:
        sw $t7, 0($t5)
        beqz $t6, skip2
            sw $t6, 0($t5)
        skip2:
        # next pixel
        addi $s7, $s7, 4
        addi $t1, $t1, 4
        addi $t5, $t5, 4
        addi $s6, $s6, 4
        # increment index
        addi $t2, $t2, 1
        addi $t3, $t3, 1
        addi $t8, $t8, 1
        
        # check if new row
        bne $t2, 4, add_row
        addi $s7, $s7, 148 # add row
        addi $t5, $t5, 148
        li $t2, 0 # reset index
        add_row:
        # check if end of blocks
        blt $t3, 16, shape_loop
        addi $s7, $s7, -656
        addi $s6, $s6, -64
    beq $a2, 1, store_board_plus
    b game_loop

key_pressed:
    lw $a0, 4($t0) # Check which key has been pressed
    beq $a0, 0x71 quit # quit if q is pressed
	
	
	# chekc if input is p
	bne $a0, 0x70, not_p
	b pause
	not_p:
	# check if input = a
	bne $a0, 0x61, not_a
	addi $t7, $s7, -4
	move $t2, $s2
	move $t5, $s5
	b validate_movement
	not_a:
	# check if input = d
	bne $a0, 0x64, not_d
	addi $t7, $s7, 4  
	move $t2, $s2
	move $t5, $s5
	b validate_movement
	not_d:
	# check if input is s
	bne $a0, 0x73, not_s
	gravity:
	li $a0, 0x73
	addi $t7, $s7, 164
	move $t2, $s2
	move $t5, $s5
	b validate_movement
	not_s:
	# check if input is w
	bne $a0, 0x77, not_w
	   move $t7, $s7
	   addi $t5, $s5, 1
	   addi $t2, $s2, 64
	   blt $t5, 4, validate_movement
	   li $t5, 0
	   addi $t2, $t2, -256
	   b validate_movement
	not_w:
	b game_loop

validate_movement:
#$t7 = position $s7
#$t2 = block $s2
#$t5 = rotation $s5
#$a0 is key pressed
print_scene1:
    la $t4, scene
    lw $t8, ADDR_DSPL
    li $t9, 0 # index
    print_loop1:
        lw $t3, 0($t4)
        sw $t3, 0($t8)
        addi $t4, $t4, 4
        addi $t8, $t8, 4
        addi $t9, $t9, 1
        ble $t9, 902, print_loop1

li $t3, 0 #index
li $t4, 0 #index
validate_loop:

    lw $t6, 0($t2)
    beqz $t6, validate_skip
        li $t8, 0x17161A # background color
        lw $t9, 0($t7)
        bne $t9, $t8, validate_fail
    validate_skip:
    # next pixel
    addi $t7, $t7, 4
    addi $t2, $t2, 4
    # increment index
    addi $t3, $t3, 1
    addi $t4, $t4, 1

    bne $t3, 4, validate_add_row
    addi $t7, $t7, 148 # add row
    li $t3, 0 # reset index
    validate_add_row:

blt $t4, 16, validate_loop
addi $t7, $t7, -656
addi $t2, $t2, -64
# validate passed move values
move $s7, $t7
move $s5, $t5
move $s2, $t2
b print_scene

validate_fail:
bne $a0, 0x73, validate_not_s
    
    ble $s3, 5, too_fast
    addi $s3, $s3, -1 # increase speed
    too_fast:
    li $a2, 1
    b print_scene
validate_not_s:
b print_scene


call_gravity:
move $s1, $s3
b gravity

pause:
lw $t0, ADDR_DSPL
li $t1, 0 # index for add row
li $t2, 0 # index
li $t3, 0xF0EAD6  # pause button color
la $t4, Pause_button
addi $t0, $t0, 668

draw_pause:

lb $t5, 0($t4)
beqz $t5, pause_skip
sw $t3, 0($t0)
pause_skip:
# index++
addi $t0, $t0, 4
addi $t4, $t4, 1
addi $t1, $t1, 1
addi $t2, $t2, 1

blt $t1, 7, pause_add_row
li $t1, 0
addi $t0, $t0, 136
pause_add_row:
blt $t2, 49, draw_pause

pause_loop:
# sleep
li 		$v0, 32
li 		$a0, 1
syscall
# Check if key has been pressed 
lw $t0, ADDR_KBRD
lw $t1 0($t0)
bne $t1, 1, pause_loop
lw $t2, 4($t0) # Check which key has been pressed
beq $t2, 0x70 print_scene # unpause if p is pressed

b pause_loop

#12 x 17
game_over:
lw $t0, ADDR_DSPL
addi $t0, $t0, 492
li $t1, 0 # index for add row
li $t2, 0 # index
la $t4, game_over_screen

draw_over:

lb $t5, 0($t4)
beqz $t5, over_skip
lw $t3, 0($t4)
sw $t3, 0($t0)
over_skip:
# index++
addi $t0, $t0, 4
addi $t4, $t4, 4
addi $t1, $t1, 1
addi $t2, $t2, 1

blt $t1, 12, over_add_row
li $t1, 0
addi $t0, $t0, 116
over_add_row:
blt $t2, 204, draw_over



game_over_loop:
# sleep
li 		$v0, 32
li 		$a0, 1
syscall
# Check if key has been pressed 
lw $t0, ADDR_KBRD
lw $t1 0($t0)
bne $t1, 1, game_over_loop
lw $t2, 4($t0) # Check which key has been pressed
beq $t2, 0x71 quit # quit if q is pressed
# chekc if input is r
bne $t2, 0x72, not_r
b main
not_r:

b game_over_loop

game_loop:
    # sleep
	li 		$v0, 32
	li 		$a0, 1
	syscall
	
	# gravity
	addi $s1, $s1, -1
	beqz, $s1 call_gravity
	
	# Check if key has been pressed 
	lw $t0, ADDR_KBRD
	lw $t8 0($t0)
	beq $t8, 1, key_pressed # If first word 1, key is pressed
	
    b game_loop 

quit:
	li $v0, 10                      # Quit gracefully
	syscall
