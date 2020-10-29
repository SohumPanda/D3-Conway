{Written by Sohum Panda }
{ 19/10/20 }



create neighbour_occupancy_array 36 allocate drop drop    { creates an array to store the ocupancy of each number from 0 to 8. Each occupancy number is stored }
                                            { in 4 bytes of memory }    
			  
: show_neighbour_occupancy_array cr 36 0 do neighbour_occupancy_array i + c@ . loop ;      { shows neighbour_occupancy_array } 

: reset_neighbour_occupancy_array cr neighbour_occupancy_array 36 0 fill ;                 { sets every element in neighbour_occupancy_array to 0 }

reset_neighbour_occupancy_array    




{ Must use reset_neighbour_occupancy_array word to set all elements in neighbour_occupancy_array to 0 } ]
{ to use this word must have the array ' neighbours ' created before }



: count_neigbour_array_occupancy n square 0 do neighbours i + c@
	case 
	 0 of neighbour_occupancy_array 0 + @ 1+ neighbour_occupancy_array 0 + !  endof
	 1 of neighbour_occupancy_array 4 + @ 1+ neighbour_occupancy_array 4 + !  endof
	 2 of neighbour_occupancy_array 8 + @ 1+ neighbour_occupancy_array 8 + ! endof
	 3 of neighbour_occupancy_array 12 + @ 1+ neighbour_occupancy_array 12 + !  endof
	 4 of neighbour_occupancy_array 16 + @ 1+ neighbour_occupancy_array 16 + !  endof
	 5 of neighbour_occupancy_array 20 + @ 1+ neighbour_occupancy_array 20 + !  endof
	 6 of neighbour_occupancy_array 24 + @ 1+ neighbour_occupancy_array 24 + !  endof
	 7 of neighbour_occupancy_array 28 + @ 1+ neighbour_occupancy_array 28 + !  endof
	 8 of neighbour_occupancy_array 32 + @ 1+ neighbour_occupancy_array 32 + ! endof
	 endcase
	 loop 
	 cr ; 
	 

{ must run count_neigbour_array_occupancy before this and any of the print occupancies } 
{ prints number of "" is "" in a nice readable format to see how many of each value is in the array } 

: occupancy_of_neighbours cr                                  
	." Number of 0's is " count_neigbour_array_occupancy 0 + @ . cr
	." Number of 1's is " count_neigbour_array_occupancy 4 + @ . cr 
	." Number of 2's is " count_neigbour_array_occupancy 8 + @ . cr
	." Number of 3's is " count_neigbour_array_occupancy 12 + @ . cr  
	." Number of 4's is " count_neigbour_array_occupancy 16 + @ . cr  
	." Number of 5's is " count_neigbour_array_occupancy 20 + @ . cr  
	." Number of 6's is " count_neigbour_array_occupancy 24 + @ . cr  
	." Number of 7's is " count_neigbour_array_occupancy 28 + @ . cr  
	." Number of 8's is " count_neigbour_array_occupancy 32 + @ . cr ;  
	
	

{ this word just prints the actual amount of a the number there is from 0 to 8 to the console } 

: print_neighbour_occupancies cr 33 0 do neighbour_occupancy_array i + @ . cr 4 +loop ;




{ will divide the number by total number of matrix elements and multiply by 100 go give the quotient of thee division as the percentage }

: percentage_occupancy cr n
	dup square neighbour_occupancy_array 0 + @ 100 * swap / ." The percent of 0's is " . ." % " cr 
	dup square neighbour_occupancy_array 4 + @ 100 * swap / ." The percent of 1's is " . ." % " cr
	dup square neighbour_occupancy_array 8 + @ 100 * swap / ." The percent of 2's is " . ." % " cr
	dup square neighbour_occupancy_array 12 + @ 100 * swap / ." The percent of 3's is " . ." % " cr  
	dup square neighbour_occupancy_array 16 + @ 100 * swap / ." The percent of 4's is " . ." % " cr  
	dup square neighbour_occupancy_array 20 + @ 100 * swap / ." The percent of 5's is " . ." % " cr  
	dup square neighbour_occupancy_array 24 + @ 100 * swap / ." The percent of 6's is " . ." % " cr  
	dup square neighbour_occupancy_array 28 + @ 100 * swap / ." The percent of 7's is " . ." % " cr  
	dup square neighbour_occupancy_array 32 + @ 100 * swap / ." The percent of 8's is " . ." % " cr ; 
	
	


{ this word just prints the actual percentage of a the number there is from 0 to 8 to the console }

: print_percentage_occupancies cr n
	dup square neighbour_occupancy_array 0 + @ 100 * swap / . cr 
	dup square neighbour_occupancy_array 4 + @ 100 * swap / . cr
	dup square neighbour_occupancy_array 8 + @ 100 * swap / . cr
	dup square neighbour_occupancy_array 12 + @ 100 * swap / . cr  
	dup square neighbour_occupancy_array 16 + @ 100 * swap / . cr  
	dup square neighbour_occupancy_array 20 + @ 100 * swap / . cr  
	dup square neighbour_occupancy_array 24 + @ 100 * swap / . cr  
	dup square neighbour_occupancy_array 28 + @ 100 * swap / . cr  
	dup square neighbour_occupancy_array 32 + @ 100 * swap / . cr ;  
	  
	  