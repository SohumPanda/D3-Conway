{ to use this word you neeed to define the word square }
{ this word will print the array to the console }
{ star with memory adress, n on stack. they will remin on stack after word is done } 

: show_small_array dup
	square 0 	
		do 
			dup i swap mod 0= if cr cr 
			
		then 
			over i + c@ 4 .R loop 
	
	cr ; 

	