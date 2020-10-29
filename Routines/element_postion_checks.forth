{ Written by Sohum Panda }
{ 22/10/20 }



{ need to create a loop structure to loop over the i elements in the array. For each i th elements, print }
{ to the stack the value (1 or 0) of its neighbouring elements, count the number of 1's, and add that number to }
{ the array that stores the number of neighbours each element has } 

{ create a neighbour array and store it as a variable } 
{ z make_array drop neigbours ! } 

{ testing with a 5x5 array. Have the mem address of the array }
{ stored as a constant called 5x5 } 
{ if mem stored in a variable, will have to do variable @ } 



variable z-1
z @ 1- z-1 !



variable z(z-1)
z @ z-1 @ * z(z-1) !



variable z^2-1
z @ square 1- z^2-1 !



variable Life_Array_1
z @ make_array drop Life_Array_1 !




: toprow cr z @ 0 do i z @ /                                            { Word to loop over top row of life_array_1 and identify  }
	0= if i                                                             { the corner elements. Prints no. stored in each element  } 
			case                                                        { and if its in the top left or right corner or otherwise }
			0 of Life_Array_1 @ i + c@ . ." in top left " cr endof      { prints that it is in the top row                        }
			z-1 @ of Life_Array_1 @ i + c@ . ." in top right " cr endof 
			Life_Array_1 @ i + c@ . ." in the top row " cr
			endcase 
	    then  
	loop ; 
	




: bottomrow cr z @ square z(z-1) do i z @ /                                   { Word to loop over the botto row of life_array_1.  } 
	z-1 @ = if i                                                              { Prints no. stored in each element and if its in   }                            
			case                                                              { the bottom left or right corner or otherwise in   }
			z(z-1) @ of Life_Array_1 @ i + c@ . ." in bottom left " cr endof  { bottom row                                        }
			z^2-1 @ of Life_Array_1 @ i + c@ . ." in bottom right " cr endof 
			Life_Array_1 @ i + c@ . ." in the bottom row " cr
			endcase 
		then 	
	loop ; 
	




: middle cr z(z-1) @ z @ do i z @ mod dup                                                       { Word to loop from second to     }
	z @ <= if                                                                                   { end of penultimate row to       }
			case                                                                                { identify if an element is in    }
			0 of Life_Array_1 @ i + c@ . ." in left edge (not corners though) " cr endof        { the left or right edge or       }
			z-1 @ of Life_Array_1 @ i + c@ . ." in right edge (not corners though) " cr endof   { within the edges of             }
			Life_Array_1 @ i + c@ . ." in the middle " cr                                       { life_array_1                    }
			endcase
		then 
	loop ;
		




: element_pos_check cr toprow middle bottomrow ;     { Word to print all elements in life_array_1 and their positions             }




 

 : toprow_neighbours z @ 0 do i z @ /                { combines toprow with if then and case endcase to calculate the number of   }
	0= if i                                          { neighbours for a cell in the top row of life_array_1 and put that          }
			case                                     { number into the neighbours array                                           }
			0 of Life_Array_1 @ i 1+ + c@ 
				 Life_Array_1 @ i z @ + + c@ 
				 Life_Array_1 @ i z @ + 1+ + c@ + + 
				 neighbours @ i + c! endof           { puts in amount of neighbours for top left                                  } 
			
			z-1 @ of Life_Array_1 @ i 1- + c@
                   Life_Array_1 @ i z @ + + c@ 
				   Life_Array_1 @ i z @ + 1- + c@ + + 
		           neighbours @ i + c! endof         { puts in amount of neighbours for top right                                 } 
			
			Life_Array_1 @ i 1- + c@
            Life_Array_1 @ i 1+ + c@
		    Life_Array_1 @ i z @ + 1- + c@
		    Life_Array_1 @ i z @ + + c@ 
		    Life_Array_1 @ i z @ + 1+ + c@ + + + + 
		    neighbours @ i + c!                      { puts in amount of neighbours for all non corner elements in top row        } 
			
			endcase 
	    then  
	loop ; 





: bottomrow_neighbours z @ square z(z-1) @ do        { Does the same as toprow_neighbours but for bottom row                      }
	i z @ / z-1 @ = 
		if i                                                                                         
			case 
			z(z-1) @ of Life_Array_1 @ i 1+ + c@ 
                      Life_Array_1 @ i z @ - + c@
                      Life_Array_1 @ i z @ - 1+ + c@ + + 
			          neighbours @ i + c!  endof     { bottom left } 
			
			z^2-1 @ of Life_Array_1 @ i 1- + c@ 
                     Life_Array_1 @ i z @ - + c@
                     Life_Array_1 @ i z @ - 1- + c@ + + 
			         neighbours @ i + c! endof       { bottom right }
			
			Life_Array_1 @ i 1- + c@
            Life_Array_1 @ i 1+ + c@
			Life_Array_1 @ i z @ - 1- + c@
			Life_Array_1 @ i z @ - + c@
			Life_Array_1 @ i z @ - 1+ + c@ + + + + 
			neighbours @ i + c!                      { bottom row not corners } 
			
			endcase 
		then 	
	loop ; 





: middle_neighbours z(z-1) @ z @ do i z @ mod dup    { Does same as toprow_neighbours but for second to end of penultimate row    }                      
	z @ <= if 
			case
			0 of Life_Array_1 @ i z @ - + c@ 
		         Life_Array_1 @ i z @ - 1+ + c@
		         Life_Array_1 @ i 1+ + c@
		         Life_Array_1 @ i z @ + + c@
		         Life_Array_1 @ i z @ + 1+ + c@ + + + + 
		         neighbours @ i + c! endof           { left edge but not corners } 
			
			z-1 @ of Life_Array_1 @ i z @ - 1- + c@
			       Life_Array_1 @ i z @ - + c@
			       Life_Array_1 @ i 1- + c@
			       Life_Array_1 @ i z @ + 1- + c@
			       Life_Array_1 @ i z @ + + c@ + + + + 
			       neighbours @ i + c! endof         { right edge but not corners } 
			
			Life_Array_1 @ i z @ - 1- + c@
			Life_Array_1 @ i z @ - + c@
			Life_Array_1 @ i z @ - 1+ + c@
			Life_Array_1 @ i 1- + c@
			Life_Array_1 @ i 1+ + c@ 
			Life_Array_1 @ i z @ + 1- + c@
			Life_Array_1 @ i z @ + + c@
			Life_Array_1 @ i z @ + 1+ + c@ + + + + + + + 
			neighbours @ i + c!                      { all non edge or corner elements } 
			
			endcase
		then 
	loop ;
	
	
	
	
	
: update_neighbours                                  { updates entire neighbours array in one go with the number of alive         }
	toprow_neighbours                                { of every element in life_array_1                                           }
	bottomrow_neighbours 
	middle_neighbours ;






