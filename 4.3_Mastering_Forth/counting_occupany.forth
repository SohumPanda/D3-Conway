

create total_occupancy 36 allocate drop drop   { creates an array to store the ocupancy of each number from 0 to 8. Each occupancy number is stored }
                                            { in 4 bytes of memory }    
			  
: show_total_occupancy cr 36 0 do total_occupancy i + c@ . loop ;      { shows total_occupancy array } 

: reset_total_occupancy cr total_occupancy 36 0 fill ;                 { sets every element in total_occupancy array to 0 }
                                                                       { 




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
	
	  
	  