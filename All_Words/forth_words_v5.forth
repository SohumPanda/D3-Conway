

                                      { -------- 12/10/20 -------- }
									  
									  

REQUIRES RND   { when you add this file, requires rnd will import the rnd package so you don't have to manually do it } 

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
 
 
 
                                      { -------- 15/10/20 -------- }
 
 
 
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
{ in console to use this word type n make_array. Needs the word square to be defied to work }

: make_array dup square dup allocate drop dup rot 0 fill swap ;

{ this will leave the mem address, n on top of the stack to use again }




                                      { -------- 18/10/20 -------- }



{ to use this you need to have the mem address, n, number to put in array, x (row number), y (column number) }

: array_! 1- swap 1- 3 pick * + 3 pick swap + c! ;

{ mem, n, no to put in element, x, y ----- mem, n }



{ this will print the number in the matrix element to the stack located at x,y where x is row number and y is column number }
{ to use this you need to have the mem address, n, x (row number), y (column number) in the stack before typing array_@} 

: array_@ 1- swap 1- 2 pick * + 2 pick swap + c@ cr ; 

{ should leave memory address on top of stack }



{ to use this word you neeed to define the word square }
{ this word will print the array to the console }
{ start with memory adress, n on stack. they will remin on stack after word is done } 

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




                                      { -------- 19/10/20 -------- }



{ needs quare to be defined }
{ starts with memory adddrss, n on stack. Fills n x n array with random number from 0 to 8 from 0 to n^2 -1 }

: random_array_fill dup square 0 do i 9 rnd swap 3 pick swap + c! loop cr ;

{ will leave mem address, n on stack still }



create total_occupancy 36 allocate drop drop    { creates an array to store the ocupancy of each number from 0 to 8. Each occupancy number is stored }
                                            { in 4 bytes of memory }    
			  
: show_total_occupancy cr 36 0 do total_occupancy i + c@ . loop ;      { shows total_occupancy array } 

: reset_total_occupancy cr total_occupancy 36 0 fill ;                 { sets every element in total_occupancy array to 0 }

reset_total_occupancy    




{ memory adress, n needed before this word. Must use reset_total_occupancy word to set all elements in total_occupancy to 0 } 

: count_array_occupancy dup square 0 do over i + c@
	case 
	 0 of total_occupancy 0 + @ 1+ total_occupancy 0 + !  endof
	 1 of total_occupancy 4 + @ 1+ total_occupancy 4 + !  endof
	 2 of total_occupancy 8 + @ 1+ total_occupancy 8 + ! endof
	 3 of total_occupancy 12 + @ 1+ total_occupancy 12 + !  endof
	 4 of total_occupancy 16 + @ 1+ total_occupancy 16 + !  endof
	 5 of total_occupancy 20 + @ 1+ total_occupancy 20 + !  endof
	 6 of total_occupancy 24 + @ 1+ total_occupancy 24 + !  endof
	 7 of total_occupancy 28 + @ 1+ total_occupancy 28 + !  endof
	 8 of total_occupancy 32 + @ 1+ total_occupancy 32 + ! endof
	 endcase
	 loop 
	 cr ; 
	 

{ must run count_array_occupancy before this and any of the print occupancies } 
{ prints number of "" is "" in a nice readable format to see how many of each value is in the array } 

: occupancy_of_numbers cr                                  
	." Number of 0's is " total_occupancy 0 + @ . cr
	." Number of 1's is " total_occupancy 4 + @ . cr 
	." Number of 2's is " total_occupancy 8 + @ . cr
	." Number of 3's is " total_occupancy 12 + @ . cr  
	." Number of 4's is " total_occupancy 16 + @ . cr  
	." Number of 5's is " total_occupancy 20 + @ . cr  
	." Number of 6's is " total_occupancy 24 + @ . cr  
	." Number of 7's is " total_occupancy 28 + @ . cr  
	." Number of 8's is " total_occupancy 32 + @ . cr ;  
	
	

{ this word just prints the actual amount of a the number there is from 0 to 8 to the console } 

: print_occupancies cr 33 0 do total_occupancy i + @ . cr 4 +loop ;



{ needs n before the word to run }
{ will divide the number by total number of matrix elements and multiply by 100 go give the quotient of thee division as the percentage }

: percentage_occupancy cr 
	dup square total_occupancy 0 + @ 100 * swap / ." The percent of 0's is " . ." % " cr 
	dup square total_occupancy 4 + @ 100 * swap / ." The percent of 1's is " . ." % " cr
	dup square total_occupancy 8 + @ 100 * swap / ." The percent of 2's is " . ." % " cr
	dup square total_occupancy 12 + @ 100 * swap / ." The percent of 3's is " . ." % " cr  
	dup square total_occupancy 16 + @ 100 * swap / ." The percent of 4's is " . ." % " cr  
	dup square total_occupancy 20 + @ 100 * swap / ." The percent of 5's is " . ." % " cr  
	dup square total_occupancy 24 + @ 100 * swap / ." The percent of 6's is " . ." % " cr  
	dup square total_occupancy 28 + @ 100 * swap / ." The percent of 7's is " . ." % " cr  
	dup square total_occupancy 32 + @ 100 * swap / ." The percent of 8's is " . ." % " cr ; 
	
	

{ needs n before the word } 
{ this word just prints the actual percentage of a the number there is from 0 to 8 to the console }

: print_percentage_occupancies cr 
	dup square total_occupancy 0 + @ 100 * swap / . cr 
	dup square total_occupancy 4 + @ 100 * swap / . cr
	dup square total_occupancy 8 + @ 100 * swap / . cr
	dup square total_occupancy 12 + @ 100 * swap / . cr  
	dup square total_occupancy 16 + @ 100 * swap / . cr  
	dup square total_occupancy 20 + @ 100 * swap / . cr  
	dup square total_occupancy 24 + @ 100 * swap / . cr  
	dup square total_occupancy 28 + @ 100 * swap / . cr  
	dup square total_occupancy 32 + @ 100 * swap / . cr ;  
	


                                      { -------- 20/10/20 -------- }



{ fills the matrix with random values from 0 to 1 } 

: random_array_fill_0or1 dup square 0 do i 2 rnd swap 3 pick swap + c! loop cr ;





{ case-endcase structure to take a value from 0-8 and apply life's rules to determine if a cell with that number of neighbours }
{ would be alive or dead in next generation }
{ this will take n off the stack }  

{ this word takes n ( the number of neighbours ) off the stack and will return 0,1,2 on the stack in its place } 

: conways_rules  case      { here 0 means the cell dies }		
	0 of 0 endof                    { means the cell will be alive }
	1 of 0 endof                    { 2 means the state of the cell is unchanged } 
	2 of 2 endof
	3 of 1 endof
	4 of 0 endof
	5 of 0 endof 
	6 of 0 endof
	7 of 0 endof
	8 of 0 endof
	endcase ; 
	

{ takes number (0, or 1 representing if cell dead or alive), number of neighbours } 
{ and returns on the stack the value 0 or 1 of if the cell is dead or alive }

: apply_conway_rule conways_rules
	case
		0 of 0 endof
		1 of 1 endof
		2 of dup endof 
	endcase nip ; 
	

 
                                      { -------- 22/10/20 -------- }
													   
													   
													   
{ Life_Array_1  for now is a constant }
{ If we make it a variable, to get a calue out of it, instead of doing Life_Array_1  i + c@ }
{ you would need to do Life_Array_1  @ i + c@ } 

20 constant n 
n 1- constant n-1
n n-1 * constant n(n-1)
n square 1- constant n^2-1 

n make_array drop constant Life_Array_1 
n make_array drop constant neighbours

{ need to have n as a constant } 
{ create a neighbour array and store it as a constant } 
{ n make_array drop constant neighbours } 


{ top left }
{ for element in top left, need to count alive cell neighbours from cell to right and underneath and diagonal bottom right }

         
	    { Life_Array_1  i 1+ + c@ 
		  Life_Array_1  i n + + c@ 
		  Life_Array_1  i n + 1+ + c@ + + 
		  neighbours i + c! }




{ top right }
{ for element in top right, need to count alive cell neighbours from cell to left and underneath and diagonal bottom left }

        { Life_Array_1  i 1- + c@
          Life_Array_1  i n + + c@ 
   	      Life_Array_1  i n + 1- + c@ + + 
	      neighbours i + c! }




{ bottom left }
{ for element in bottom right, need to count alive cell neighbours from cell to right and above and diagonal top right }

        { Life_Array_1  i 1+ + c@ 
          Life_Array_1  i n - + c@
          Life_Array_1  i n - 1+ + c@ + + 
		  neighbours i + c! }




{ bottom right }
{ for element in bottom right, need to count alive cell neighbours from cell to left and above and diagonal top left } 

        { Life_Array_1  i 1- + c@ 
          Life_Array_1  i n - + c@
          Life_Array_1  i n - 1- + c@ + + 
	      neighbours i + c! } 



			  
{ top edge } 
{ for i you need:  i-1,  i+1,  i+n-1,  i+n,  i+n+1 } 

        { Life_Array_1  i 1- + c@
          Life_Array_1  i 1+ + c@
		  Life_Array_1  i n + 1- + c@
		  Life_Array_1  i n + + c@ 
		  Life_Array_1  i n + 1+ + c@ + + + + 
		  neighbours i + c! }
		  



{ bottom edge } 
{ for i you need:  i-1,  i+1,  i-n-1,  i-n,  i-n+1 } 

        { Life_Array_1  i 1- + c@
          Life_Array_1  i 1+ + c@
	      Life_Array_1  i n - 1- + c@
		  Life_Array_1  i n - + c@
		  Life_Array_1  i n - 1+ + c@ + + + + 
		  neighbours i + c! }
			 



{ left edge } 
{ for i you need: i-n,  i-n+1,  i+1,  i+n,  i+n+1 }

        { Life_Array_1  i n - + c@ 
	      Life_Array_1  i n - 1+ + c@
	      Life_Array_1  i 1+ + c@
		  Life_Array_1  i n + + c@
		  Life_Array_1  i n + 1+ + c@ + + + + 
		  neighbours i + c! }




{ right edge } 
{ for i you need: i-n-1,  i-n,  i-1,  i+n-1,  i+n }

        { Life_Array_1  i n - 1- + c@
		  Life_Array_1  i n - + c@
		  Life_Array_1  i 1- + c@
		  Life_Array_1  i n + 1- + c@
		  Life_Array_1  i n + + c@ + + + + 
		  neighbours i + c! } 
			



{ middle }
{ for i you need all 8 surrounding elements }

        { Life_Array_1  i n - 1- + c@
		  Life_Array_1  i n - + c@
		  Life_Array_1  i n - 1+ + c@
		  Life_Array_1  i 1- + c@
		  Life_Array_1  i 1+ + c@ 
		  Life_Array_1  i n + 1- + c@
		  Life_Array_1  i n + + c@
		  Life_Array_1  i n + 1+ + c@ + + + + + + + 
		  neighbours i + c! }
			 













{ create a neighbour array and store it as a constant } 
{ n make_array drop constant neighbours } 

{ testing with a 5x5 array. Have the mem address of the array }
{ stored as a constant called 5x5 } 
{ if mem stored in a variable, will have to do variable @ } 



{ 5 constant n }
{ n 1- constant n-1 } { this will store the value 4 as constant called n-1 }  
{ then can generalise to n square instead of 25 }
{ do i n instead of do i 5 }
{ and to n-1 of instead of 4 of } 

: toprow cr n 0 do i n /    { if making three seperate funtions this only needs to do loop 5 0, not 25 0 }
	0= if i
			case 
			0 of Life_Array_1  i + c@ . ." in top left " cr endof
			n-1 of Life_Array_1  i + c@ . ." in top right " cr endof { for the topright, create a constant n-1 to store that value, in this case 4 }
			Life_Array_1  i + c@ . ." in the top row " cr
			endcase 
	    then  
	loop ; 
	
{ this little snippet succesfully checks if the element is in the top }
{ row and is top left or top right }





{ 20 is equal to n-1 n * (aka 4 times 5). }                { Can make a new constant called n(n-1) } 
{ 24 is equal to n^2-1 (25 - 1). }                         { Can make a new constant called n^2-1 } 

: bottomrow cr n square n(n-1) do i n /   { this only needs to do loop over last row, therefore n^2 n(n-1) do } 
	n-1 = if i                                                               { which would be 25 20 do }                            
			case 
			n(n-1) of Life_Array_1   i + c@ . ." in bottom left " cr endof
			n^2-1 of Life_Array_1   i + c@ . ." in bottom right " cr endof 
			Life_Array_1   i + c@ . ." in the bottom row " cr
			endcase 
		then 	
	loop ; 
	
{ this succesfully checks if an element is in the bottom corners or bottom row }


: middle cr n(n-1) n do i n mod dup
	n <= if 
			case
			0 of Life_Array_1   i + c@ . ." in left edge (not corners though) " cr endof
			n-1 of Life_Array_1   i + c@ . ." in right edge (not corners though) " cr endof
			Life_Array_1   i + c@ . ." in the middle " cr
			endcase
		then 
	loop ;
		
{ this loop succesfully checks if the numbers in the array that arent in the top or bottom row, }
{ are in the left edge, right edge or middle } 




: element_pos_check cr toprow middle bottomrow ;

{ this combines the previous three words and prints the elements and their positions to the console } 




{ Need to pre load in the word defined in neighbour_count.forth ( the ones which count the number of live neighbours and stores it in the }
{ the neighbours array) . Combine those words with toprow, bottomrow and middle to correctly read the number of live neighbours of each element
in the Life_Array_1  grid } 

 : toprow_neighbours cr n 0 do i n /    
	0= if i
			case 
			0 of Life_Array_1  i 1+ + c@ 
				 Life_Array_1  i n + + c@ 
				 Life_Array_1  i n + 1+ + c@ + + 
				 neighbours i + c! endof { top left } 
			
			n-1 of Life_Array_1  i 1- + c@
                   Life_Array_1  i n + + c@ 
				   Life_Array_1  i n + 1- + c@ + + 
		           neighbours i + c! endof { top right } 
			
			Life_Array_1  i 1- + c@
            Life_Array_1  i 1+ + c@
		    Life_Array_1  i n + 1- + c@
		    Life_Array_1  i n + + c@ 
		    Life_Array_1  i n + 1+ + c@ + + + + 
		    neighbours i + c! { top row } 
			
			endcase 
	    then  
	loop ; 

: bottomrow_neighbours cr n square n(n-1) do i n /   
	n-1 = if i                                                                                         
			case 
			n(n-1) of Life_Array_1  i 1+ + c@ 
                      Life_Array_1  i n - + c@
                      Life_Array_1  i n - 1+ + c@ + + 
			          neighbours i + c!  endof { bottom left } 
			
			n^2-1 of Life_Array_1  i 1- + c@ 
                     Life_Array_1  i n - + c@
                     Life_Array_1  i n - 1- + c@ + + 
			         neighbours i + c! endof { bottom right }
			
			Life_Array_1  i 1- + c@
            Life_Array_1  i 1+ + c@
			Life_Array_1  i n - 1- + c@
			Life_Array_1  i n - + c@
			Life_Array_1  i n - 1+ + c@ + + + + 
			neighbours i + c! { bottom row } 
			
			endcase 
		then 	
	loop ; 

: middle_neighbours cr n(n-1) n do i n mod dup
	n <= if 
			case
			0 of Life_Array_1  i n - + c@ 
		         Life_Array_1  i n - 1+ + c@
		         Life_Array_1  i 1+ + c@
		         Life_Array_1  i n + + c@
		         Life_Array_1  i n + 1+ + c@ + + + + 
		         neighbours i + c! endof { left edge } 
			
			n-1 of Life_Array_1  i n - 1- + c@
			       Life_Array_1  i n - + c@
			       Life_Array_1  i 1- + c@
			       Life_Array_1  i n + 1- + c@
			       Life_Array_1  i n + + c@ + + + + 
			       neighbours i + c! endof { right edge } 
			
			Life_Array_1  i n - 1- + c@
			Life_Array_1  i n - + c@
			Life_Array_1  i n - 1+ + c@
			Life_Array_1  i 1- + c@
			Life_Array_1  i 1+ + c@ 
			Life_Array_1  i n + 1- + c@
			Life_Array_1  i n + + c@
			Life_Array_1  i n + 1+ + c@ + + + + + + + 
			neighbours i + c! { middlecell } 
			
			endcase
		then 
	loop ;
	
: update_neighbours toprow_neighbours bottomrow_neighbours middle_neighbours ;



n make_array drop constant Life_Array_2



{ combining our neighbours array with life array 1 and conways rule to find out the state of net generation }
{ to use this we need to define an array called Life_Array_2 }   


: next_gen n square 0 do 
	Life_Array_1 i + c@ neighbours i + c@ apply_conway_rule Life_Array_2 i + c! loop ;



 
 
 

                                  







