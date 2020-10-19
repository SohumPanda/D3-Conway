: square dup * . ; { squares number on top of stack and prints it to cosole. If stack is 1 2 3 4 thn you type square, 16 printss to console and stack is 1 2 3 }

: cube dup dup * * . ; { does the same as square but cubes the number instead } 

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

: 5multiple cr dup 5 mod 0= if dup ." The number " . ." is a multiple of 5 " else dup ." The number " . ." isn't a multiple of 5 " then cr ; {same as odd_even but for if top is multiple of 5 }

: test_case cr       { wasn't able to put false in if top of stack isn't 2 5 or 7 } 
 case                { this is using case (of/endof) endcase structure. The indentation doesn't change anything  
 2 of true endof
 5 of true endof
 7 of true endof 
 endcase
 cr ; 
 
