{ need to create a loop structure to loop over the i elements in the array. For each i th elements, print }
{ to the stack the value (1 or 0) of its neighbouring elements, count the number of 1's, and add that number to }
{ the array that stores the number of neighbours each element has } 

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
			0 of Life_Array_1   i + c@ . ." in top left " cr endof
			n-1 of Life_Array_1   i + c@ . ." in top right " cr endof { for the topright, create a constant n-1 to store that value, in this case 4 }
			Life_Array_1   i + c@ . ." in the top row " cr
			endcase 
	    then  
	loop ; 
	
{ this little snippet succesfully checks if the element is in the top }
{ row and is top left or top right }





{ 20 is equal to n-1 n * (aka 4 times 5). Can make a new constant called n(n-1) } 
{ 24 is equal to n^2-1 (25 - 1). Can make a new constant called n^2-1 } 

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

	







