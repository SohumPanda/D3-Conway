{ needs square to be defined to work }
{ starts with memory adddrss, n on stack. Fills n x n array with numbers from 0 to n^2 -1 }

: linear_small_array dup square 0 do 
	i dup 3 pick swap + c! 
	loop cr ; 
	
{ will leave mem address, n on stack still } 