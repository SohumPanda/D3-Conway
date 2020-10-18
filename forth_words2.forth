: square dup * ; { squares number on top of stack. If stack is 1 2 3 4 thn you type square, stack is 1 2 3 16 }

: cube dup dup * * ; { does the same as square but cubes the number instead } 

: clearstack 0 begin drop depth 0 = until ;  { 0 = until means it clears until the depth is 0 }

{ : clearstackp begin . depth 0 = until ; } { clearstack prints to the stack to the console but in reverse. So top of stack prints first } 

: pair 11 0 do 11 0 do i j * . loop CR loop ;  { adds 0x0 0x1 0x2 ...... to 0x10 1x0 1x2 .... all the way to 10x 10 to the console. If you remove the "." they will just be added to the stack }     

{ the word "wipe" clears the console but doesn't clear the memory of if you have written a word before. so you can't try and define }
{ that word again after wipe as it says the word is not unique }

: squarepair 21 4 do i . i i * CR 2 +loop ;  { creates a pair (n n^2) from 4 to 20. CR carrige return terminates a line of console output and starts new line }

{ the ." text " function lets you print the string tst to the console }
{ nice to have a cr at the beginning of the word to return to the console on a new line. Putting a cr at the end will then return te "ok" on a new line too}

: odd_even cr dup 2 mod 0= if dup ." The number " . ." is even " else dup ." The number " . ." is odd " then cr ;  { this uses IF THEN ELSE structure to check if the top of stack is odd or even.
the dup after if and else means the number is not taken off the top of the stack } 

: 5multiple cr dup 5 mod 0= if dup ." The number " . ." is a multiple of 5 " else dup ." The number " . ." isn't a multiple of 5 " then cr ; { same as odd_even but for if top is multiple of 5 }

: test_case cr       { wasn't able to put false in if top of stack isn't 2 5 or 7 } 
 case                { this is using case (of/endof) endcase structure. The indentation doesn't change anything }  
 2 of true endof
 5 of true endof
 7 of true endof 
 endcase
 cr ; 
 
: ASCII                        { cr to start on fresh line. Do i emit loops fro 0 to 127. in between you have if then to check if i is a multiple of 10 }
	cr 128 0 do i
		 10 mod 0= if cr 
			then i emit 
	loop ;

: 10number cr dup       
 case                  
 0 of ." zero " drop endof
 1 of ." one " drop endof
 2 of ." two " drop endof
 3 of ." three " drop endof
 4 of ." four " drop endof
 5 of ." five " drop endof
 6 of ." six " drop endof
 7 of ." seven " drop endof
 8 of ." eight " drop endof
 9 of ." nine " drop endof
 10 of ." ten " drop endof       { add a drop here if you want to drop the number if it is not from 0 to 10 }  
 endcase cr ; 
 


{ make small array word. A n x n matrix would have n^2 elements, so you need to square n and allocate. }
{ in console to use this word type n make_small_array. Needs the word square to be defied to work }

: make_array square dup allocate drop dup rot 0 fill ;

{ this will leave the mem address on top of the stack to use again }




{ to use this you need to have the mem address, n, number to put in array, x (row number), y (column number) }

: array_! 1- swap 1- 3 pick * + 3 pick swap + c! drop ;

{ mem, n, no to put in element, x, y ----- mem }







{ this will print the number in the matrix element located at x,y where x is row number and y is column number }
{ to use this you need to have the mem address, n, number to put in array, x (row number), y (column number) in the stack before typing array_@} 

: array_@ 1- swap 1- 2 pick * + nip over swap + c@ cr . ; 

{ should leave memory address on top of stack }









{ to use this word you neeed to define the word square }
{ this word will print the array to the console }
{ star with memory adress, n on stack. they will remin on stack after word is done } 

: show_array dup
	square 0 	
		do 
			dup i swap mod 0= if cr cr 
			
		then 
			over i + c@ 4 .R loop 
	
	cr ; 
	
	
	


{ needs square to be defined to work }
{ starts with memory adddrss, n on stack. Fills n x n array with numbers from 0 to n^2 -1 }

: linear_array dup square 0 do 
	i dup 3 pick swap + c! 
	loop cr ; 
	
{ will leave mem address, n on stack still }






