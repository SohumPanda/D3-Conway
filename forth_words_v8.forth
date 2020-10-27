




                                      { -------- 12/10/20 -------- }
									  
									  



REQUIRES RND                                         { imports rnd package automatically                                         } 

: square dup * ;                                     { squares number on top of stack. If stack is 1 2 3 4 then you type square  }
                                                     { stack is 1 2 3 16 }

: cube dup dup * * ;                                 { does the same as square but cubes the number instead                      } 

: clearstack 0 begin drop depth 0 = until ;          { 0 = until means it clears until the depth is 0                            }

: pair 11 0 do 11 0 do i j * . loop CR loop ;        { adds 0x0 0x1 0x2 ...... to 0x10 1x0 1x2 .... all the way to 10x 10 to the }
                                                     { console. If you remove the "." they will just be added to the stack }     

                                                     { the word "wipe" clears the console but doesn't clear the memory of if you }
                                                     { have written a word before                                                }

: squarepair 21 4 do i . i i * CR 2 +loop ;          { creates a pair (n n^2) from 4 to 20. CR carrige return terminates a line  } 
                                                     { of console output and starts new line                                     }



: odd_even cr dup 2 mod 0= if                            { this uses IF THEN ELSE structure to check if the top of stack is odd or   } 
	dup ." The number " . ." is even "               { even. The dup after if and else means the number is not taken off the top }
	else                                             { of the stack                                                              }
	dup ." The number " . ." is odd " 
	then cr ;                                    


: 5multiple cr dup 5 mod 0= if                       { checks if top number of stack is a multiple of 5                          }
	dup ." The number " . ." is a multiple of 5 " 
	else 
	dup ." The number " . ." isn't a multiple of 5 " 
	then cr ;                                         

: test_case cr                                       { Prints true if top of stack is 2 5 or 7                                   } 
 case                                                  
 2 of true endof
 5 of true endof
 7 of true endof 
 endcase
 cr ; 
 
 
 
 
 
                                      { -------- 15/10/20 -------- }
 
 
 
 
 
: ASCII                                                      {  Print the ASCII characters in blocks of 10.                              }
	cr 128 0 do i                                        { 128 0 do i emit loops from 0 to 127. in between you have if then to check } 
		 10 mod 0= if cr                             { if i is a multiple of 10                                                  }
			then i emit 
	loop ;

: 10number cr dup                                    { CASE ENDCASE structure. Checks if top of stack is a number from 0-10 and  } 
 case                                                { will print its spelling to the stack                                      }
 0 of ." zero " endof                                { n ------- n                                                               }
 1 of ." one " endof
 2 of ." two " endof
 3 of ." three " endof
 4 of ." four " endof
 5 of ." five " endof
 6 of ." six " endof
 7 of ." seven " endof
 8 of ." eight " endof
 9 of ." nine " endof
 10 of ." ten " endof                                { add a drop here if you want to drop the number if it is not from 0 to 10  }  
 endcase cr ; 
 

variable z                                           { creates a variable z                                                      }
10 z !                                               { stores dimension of array in variable z. when we say z from now, we mean  }
                                                     { the number stored at variable z                                           }


: make_array dup square dup                              { In console to use this word type z @ make_array ( where z is a number for } 
	allocate drop dup rot 0 fill swap ;              { a z x z array. Needs the word square to be defined to work.               }
                                                         { Will leave the mem address, z on top of the stack to use again.           }
						         { z --------- mem, z                                                        }



                                      { -------- 18/10/20 -------- }



: array_! 1- swap 1- 3 pick * + 3 pick swap + c! ;   { mem address, z, number to put in array, x (row number), y (column number) }
                                                     { need yo be on stack to use. This word puts a number in element [x,y] of   }
                                                     { an array at the mem address.                                              }
						     { mem, z, no. to put in element, x, y ----- mem, z                          }
                                                  



: array_@ 1- swap 1- 2 pick * + 2 pick swap + c@ ;   { this will print the number in the matrix element [x,y] to the stack       } 
                                                     { mem address, z, x, y --------- mem, z, no. at [x,y]                       } 



: show_array dup                                     { Word to print array to console. Needs square defined.                     }
    square 0 	                                     { mem, z -------- mem, z                                                    } 
		do 
			dup i swap mod 0= if cr cr 
			
		then 
			over i + c@ 4 .R loop 
	
	cr ; 
	
	
	

: linear_array dup square 0 do                           { Needs square to be defined to work.                                       }
	i dup 3 pick swap + c!                           { Fills z x z array with numbers from 0 to n^2 -1 from top left to bottom   }
	loop cr ;                                        { right.                                                                    }
	                                                 { mem, z -------- mem, z                                                    }





                                      { -------- 19/10/20 -------- }





variable neighbours
z @ make_array drop neighbours !



 
: random_array_fill dup square 0 do                      { needs square to be defined                                                }  
	i 9 rnd swap 3 pick swap + c! loop cr ;          { Fills z x z array with random numbers from 0 to 8                         }
                                                         { mem, z -------- mem, z                                                    }




create neighbour_occupancy_array 36 allocate         { creates an 32 bit array to store the ocupancy of each number from 0 to 8  }
drop drop                                            { each occupancy of a number is stored in 4 bytes of memory                 }
                     
                                                             
			  
: show_neighbour_occupancy_array cr 36 0             { shows each byte of neighbour_occupancy_array in the console               }
do neighbour_occupancy_array i + c@ . loop ;       

: reset_neighbour_occupancy_array cr
	neighbour_occupancy_array 36 0 fill ;            { sets every byte in neighbour_occupancy_array to 0                         }



reset_neighbour_occupancy_array                      { Must use reset_neighbour_occupancy_array word to set all elements in      } 
                                                     { neighbour_occupancy_array to 0 . To use this word must have the array     }
						     { ' neighbours ' created before                                             }






: count_neighbour_array_occupancy z @ square 0 do                                                { counts number of cells with 0,1,2 - 8 }
	neighbours @ i + c@                                                                      { neighbours, from out the neighours    }
		case                                                                             { array and stores the amount in the    }    
	 0 of neighbour_occupancy_array 0 + @ 1+ neighbour_occupancy_array 0 + ! endof           { neighbour_occupancy_array array       }
	 1 of neighbour_occupancy_array 4 + @ 1+ neighbour_occupancy_array 4 + ! endof
	 2 of neighbour_occupancy_array 8 + @ 1+ neighbour_occupancy_array 8 + ! endof
	 3 of neighbour_occupancy_array 12 + @ 1+ neighbour_occupancy_array 12 + ! endof
	 4 of neighbour_occupancy_array 16 + @ 1+ neighbour_occupancy_array 16 + ! endof
	 5 of neighbour_occupancy_array 20 + @ 1+ neighbour_occupancy_array 20 + ! endof
	 6 of neighbour_occupancy_array 24 + @ 1+ neighbour_occupancy_array 24 + ! endof
	 7 of neighbour_occupancy_array 28 + @ 1+ neighbour_occupancy_array 28 + ! endof
	 8 of neighbour_occupancy_array 32 + @ 1+ neighbour_occupancy_array 32 + ! endof
	 endcase
	 loop 
	 cr ; 
	 


: occupancy_of_neighbours cr                                                 { must run count_neigbour_array_occupancy before this   } 
	." Number of 0's is " neighbour_occupancy_array 0 + @ . cr           { and any of the print occupancies. This word prints    }  
	." Number of 1's is " neighbour_occupancy_array 4 + @ . cr           { number of "" is "" in a nice readable format          }
	." Number of 2's is " neighbour_occupancy_array 8 + @ . cr           { eg in a 10 x 10 array there may be 15 cells with 0    }
	." Number of 3's is " neighbour_occupancy_array 12 + @ . cr          { neighbours. Would print number of "0's" is "11"       }
	." Number of 4's is " neighbour_occupancy_array 16 + @ . cr  
	." Number of 5's is " neighbour_occupancy_array 20 + @ . cr  
	." Number of 6's is " neighbour_occupancy_array 24 + @ . cr  
	." Number of 7's is " neighbour_occupancy_array 28 + @ . cr  
	." Number of 8's is " neighbour_occupancy_array 32 + @ . cr ;  
	
	



: print_neighbour_occupancies cr 33 0 do                 { This word just prints the actual amount of a number there is from 0 to 8  } 
	neighbour_occupancy_array i + @ . cr 4 +loop ;   { to the console, without the string                                        }




: percentage_occupancy cr z @ 
	dup square neighbour_occupancy_array 0 + @ 100 * swap / ." The percent of 0's is " . ." % " cr  { gives occupancies of       }
	dup square neighbour_occupancy_array 4 + @ 100 * swap / ." The percent of 1's is " . ." % " cr  { elements in neighbours     }
	dup square neighbour_occupancy_array 8 + @ 100 * swap / ." The percent of 2's is " . ." % " cr  { array as percentages       }
	dup square neighbour_occupancy_array 12 + @ 100 * swap / ." The percent of 3's is " . ." % " cr  
	dup square neighbour_occupancy_array 16 + @ 100 * swap / ." The percent of 4's is " . ." % " cr  
	dup square neighbour_occupancy_array 20 + @ 100 * swap / ." The percent of 5's is " . ." % " cr  
	dup square neighbour_occupancy_array 24 + @ 100 * swap / ." The percent of 6's is " . ." % " cr  
	dup square neighbour_occupancy_array 28 + @ 100 * swap / ." The percent of 7's is " . ." % " cr  
	dup square neighbour_occupancy_array 32 + @ 100 * swap / ." The percent of 8's is " . ." % " cr ; 
	
	




: print_percentage_occupancies cr z @ 
	dup square neighbour_occupancy_array 0 + @ 100 * swap / . cr         { This word just prints the actual percentage of the    } 
	dup square neighbour_occupancy_array 4 + @ 100 * swap / . cr         { numbers from 0 to 8 in the neighbours array to the    }
	dup square neighbour_occupancy_array 8 + @ 100 * swap / . cr         { console, without the string                           }
	dup square neighbour_occupancy_array 12 + @ 100 * swap / . cr  
	dup square neighbour_occupancy_array 16 + @ 100 * swap / . cr  
	dup square neighbour_occupancy_array 20 + @ 100 * swap / . cr  
	dup square neighbour_occupancy_array 24 + @ 100 * swap / . cr  
	dup square neighbour_occupancy_array 28 + @ 100 * swap / . cr  
	dup square neighbour_occupancy_array 32 + @ 100 * swap / . cr ;  
	




                                      { -------- 20/10/20 -------- }





  : random_array_fill_0or1 dup square 0 do               { Fills an array with random values from 0 to 1. Needs square defined       }
	i 2 rnd swap 3 pick swap + c! loop cr ;          { mem, z -------- mem, z                                                    }





 

: conways_rules  case                                    { this word takes the number of neighbours off the stack and will return     }       
	0 of 0 endof                                     { 0,1,2 on the stack in its place. 3 neighbours means the cell will be alive }
	1 of 0 endof                                     { always. 2 neighbours means the state of the cell is unchanged  always      } 
	2 of 2 endof                                     { any other val of neighbours means cell will die                            }
	3 of 1 endof                                       
	4 of 0 endof
	5 of 0 endof 
	6 of 0 endof
	7 of 0 endof
	8 of 0 endof
	endcase ; 
	



: apply_conway_rule conways_rules                        { takes 0, or 1 ( representing if cell dead or alive), number of neighbours  } 
	case                                             { and returns on the stack the value 0 or 1 of if the cell is dead or alive  }
		0 of 0 endof                             { in the next generation. Needs the word conways_rules defined               }
		1 of 1 endof                             { state of cell (0 or 1), neighbours --- state of cell in next gen (0 or 1 ) }
		2 of dup endof 
	endcase nip ; 
	

 
                                      { -------- 22/10/20 -------- }
													   
													   
													   


variable z-1
z @ 1- z-1 !



variable z(z-1)
z @ z-1 @ * z(z-1) !



variable z^2-1
z @ square 1- z^2-1 !



variable Life_Array_1
z @ make_array drop Life_Array_1 !




: toprow cr z @ 0 do i z @ /                                                         { Word to loop over top row of life_array_1 and identify  }
	0= if i                                                                      { the corner elements. Prints no. stored in each element  } 
			case                                                         { and if its in the top left or right corner or otherwise }
			0 of Life_Array_1 @ i + c@ . ." in top left " cr endof       { prints that it is in the top row                        }
			z-1 @ of Life_Array_1 @ i + c@ . ." in top right " cr endof 
			Life_Array_1 @ i + c@ . ." in the top row " cr
			endcase 
	    then  
	loop ; 
	




: bottomrow cr z @ square z(z-1) do i z @ /                                               { Word to loop over the botto row of life_array_1.  } 
	z-1 @ = if i                                                                      { Prints no. stored in each element and if its in   }                            
			case                                                              { the bottom left or right corner or otherwise in   }
			z(z-1) @ of Life_Array_1 @ i + c@ . ." in bottom left " cr endof  { bottom row                                        }
			z^2-1 @ of Life_Array_1 @ i + c@ . ." in bottom right " cr endof 
			Life_Array_1 @ i + c@ . ." in the bottom row " cr
			endcase 
		then 	
	loop ; 
	




: middle cr z(z-1) @ z @ do i z @ mod dup                                                                   { Word to loop from second to     }
	z @ <= if                                                                                           { end of penultimate row to       }
			case                                                                                { identify if an element is in    }
			0 of Life_Array_1 @ i + c@ . ." in left edge (not corners though) " cr endof        { the left or right edge or       }
			z-1 @ of Life_Array_1 @ i + c@ . ." in right edge (not corners though) " cr endof   { within the edges of             }
			Life_Array_1 @ i + c@ . ." in the middle " cr                                       { life_array_1                    }
			endcase
		then 
	loop ;
		




: element_pos_check cr toprow middle bottomrow ;     { Word to print all elements in life_array_1 and their positions             }




 

 : toprow_neighbours z @ 0 do i z @ /                             { combines toprow with if then and case endcase to calculate the number of   }
	0= if i                                                   { neighbours for a cell in the top row of life_array_1 and put that          }
			case                                      { number into the neighbours array                                           }
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
	
	
	
	
	 
: update_neighbours                                      { updates entire neighbours array in one go with the number of alive         }
	toprow_neighbours                                { of every element in life_array_1                                           }
	bottomrow_neighbours 
	middle_neighbours ;





variable Life_Array_2                                { combining our neighbours array with life array 1 and apply_conway_rule we  }
                                                     { can find out the state of each element in the next generation and store    }
z @ make_array drop Life_Array_2 !                   { the state of the entire next generation in an array called life_array_2    }



 

: next_gen z @ square 0 do                               { Word to apply conways rules to life_array_1 and puts the next generation   }
	Life_Array_1 @ i + c@                            { into life_array_2                                                          }
	neighbours @ i + c@ 
	apply_conway_rule 
	Life_Array_2 @ i + c! 
	loop ;





{ These next functions were written on 26/10/20 }
{ lines 483-521 } 
{ These 3 words reset the edges of life_array_2 to be all 0 in an attempt to try and get the glider and other structures }
{ to vanish, however these did not work }



: top_life2_0 z @ 0 do 
		0 life_array_2 @ i + c!
		loop ; 




		
: bottom_life2_0 z @ square z(z-1) @ do
		0 life_array_2 @ i + c!
		loop ;
		




: leftright_edge_life2_0 z(z-1) @ z @ do i z @ mod dup                         
	z @ <= if 
			case
			0 of 0 life_array_2 @ i + c!
			endof
			
			z-1 @ of 0 life_array_2 @ i + c!
			endof 
			
			endcase
		then
		
	loop ; 	




		
: edges_life2_0 top_life2_0 leftright_edge_life2_0 bottom_life2_0 ; 





                                      { -------- 23/10/20 -------- }





{ edited words for counting the number of cells with 0 to 8 neighbours in it from out of the neighbour array. Lines 147 to 284.   } 
{ They now use neighbours and z directly and don't need anything on thee stack                                                    } 


variable alive_1                                     { variable to store no alive cells in Life_Array_1 } 

variable alive_2                                     { variable to store no alive cells in Life_Array_1 }







: count_alive_1 0 z @ square 0 do                    { Word to count no alive cells in Life_Array_1 and store that number in      } 
	Life_Array_1 @ i + c@                            { alive_1                                                                    }
		case 
		1 of 1+  endof
		endcase
	loop alive_1 ! ;
	 
	 
	 
	 
	 
: count_alive_2 0 z @ square 0 do                    { Word to count no alive cells in Life_Array_1 and store that number in      }
	Life_Array_2 @ i + c@                            { alive_2                                                                    }
		case 
		1 of 1+  endof
		endcase
	loop  alive_2 ! ;

                                                     { to print the number of alive cells in the Life_Array_1 or Life_Array_2     }
                                                     { first run :count_alive_1 or 2 and then                                     }
                                                     { alive_1 or 2 0 + @ } { ----------- will print no alive cells to stack      } 
					       	     { We can use this to check the if the number of alive cells changes from one }
                                                     { gen to another s a form of checking if steady state is reached. To do this }
				      		     { alive_1 and alive_2 mmust be reset back to zero after each loop            } 





variable Life_Array32                                { make life_array32 a variable. This is the 32 bit version of life_array_1   } 
                                                     { This is because the squares display routine takes a 32bit array not 8 bit  } 
z @ 2 * make_array drop Life_Array32 !


 

: 8to32 z @ square 0 do                                  { Word to convert life_array_1 into a 32 bit array from an 8 bit array       }                     
	life_array_1 @ i + c@                            { which is then stored at the variable life_array32                          }
	Life_Array32 @ i cells + ! 
	loop ; 
	
	
	
	
 	
: show_array32 dup                                           { Word to show a 32 bit array in the console                                 }
	square 0 	                                     { mem, z ------- mem, z                                                      }
		do 
			dup i swap mod 0= if cr cr 
			
		then 
			over i cells + @ 4 .R loop 
	
	cr ; 





{ This code was written 26/10/20 }
{ lines 611-651 }  



variable diff_array                              { Creates a variable to store the difference array                           }                  

z @ make_array drop diff_array !                 { Makes the difference array, initialises it with all 0's                    }





: calculate_diff_array z @ square 0 do           { This word calculates the difference array. Life_Array_2 - Life_Array_1     }
   life_array_2 @ i + c@                         { If the state of the cell is unchanged it will be 0. If a cell is born      }
   life_array_1 @ i + c@ -                       { 1 - 0 = 1 . If cell dies 0 - 1 = 255                                       }
   diff_array @ i + c!                           { store these values 0,1,255 in the difference array                         }     
   loop ; 




variable no_Born                                  { Creates a variable to store the number of cells born                      }
variable no_Died                                  { Creates a variable to store the number of cells to die                    }





: count_born 0 z @ square 0 do                    { Word to count no cells born                                                } 
	diff_array @ i + c@                            
		case 
		1 of 1+  endof
		endcase
	loop no_Born ! ;
	 
	 
	 
	 
	 
: count_died 0 z @ square 0 do                    { Word to count no cells that died                                           }
	diff_array @ i + c@                                                                                            
		case 
		255 of 1+  endof
		endcase
	loop  no_Died ! ;






: update_life                                                { Word to put everything togethere and update life from one gen to next      }
	8to32                                                { Firstly initialise life_array_1 with some pattern, random or specific      }
	update_neighbours                                    { life_array_2, neighbours and life_array32 arrays will need to already made }
	next_gen 	                                     { These 3 arrays are initialised with all 0's anyways to begin with          }
    { edges_life2_0 }
	life_array_2 @ life_array_1 @ z @ square move        { Then convert life_array_1 to 32 bit using 8to32 and store in life_array32  }
;                                                            { Then use update_neighbours to update neighbour array                       }
                                                             { Then use next gen to create the next generation in life_array_2            }
                                                             { Use move to move net gen into life_array_1, ready to be acted on again     }
                                                             { to continuously loop and keep updating each generation of life             }
							     { Can add other things in this word such as checks and outputting data etc   }





: reset_life_array_1 cr                              { Word to reset life_array_1 to all 0's                                      }
  life_array_1 @ z @ square 0 fill ;





: reset_life_array_2 cr                              { Word to reset life_array_1 to all 0's                                      }
  life_array_2 @ z @ square 0 fill ;


 


: reset_life_array32 cr                              { Word to reset life_array32 to all 0's                                      }
 life_array32 @ z @ square cells 0 fill ;





{ -----------------------Made by Tanjim, adapted by me------------------------ }

{ Made by: Tanjim Chowdhury
  23/10/2020               } 
  
{ Adapted to my Words } { Sohum Panda 23/10/2020 }
  
{ Puts a glider into the life_array_1 starting at co-ordinate [x,y] where x is row number and y is column number }
{ requires variable z and life_array_1 and the word array_! }

variable glider_x
variable glider_y  



{ eg 1 1 import_glider inserts a glider starting at 1,1 }

: import_glider
  glider_y !
  glider_x !									        { saves x,y into the variables   }
  life_array_1 @ z @ 1 glider_x @ glider_y @ 2 + array_! drop drop			{ changes values in life_array_1 }
  life_array_1 @ z @ 1 glider_x @ 1 + glider_y @ array_! drop drop			{ so a glider appears at [x,y]   }
  life_array_1 @ z @ 1 glider_x @ 1 + glider_y @ 2 + array_! drop drop 		
  life_array_1 @ z @ 1 glider_x @ 2 + glider_y @ 1 + array_! drop drop 
  life_array_1 @ z @ 1 glider_x @ 2 + glider_y @ 2 + array_! drop drop 	     
;


{ -----------------------End of by Tanjim, adapted by me------------------------ }



                                      { -------- 23/10/20 -------- }
									  
									  
{ life wasn't working using display squares files given. Changed all words to use arrays stored in variables rather than constants. }
{ Additionally n kept not being unique and not properly updating when dragging in my forth_words files after changing n each time. }
{ As a result replaced n with the letter z and madde all values related to z stored as variables instead of constants now. } 


{ 5 5 import_glider }





                                      { -------- 26/10/20 -------- } 





{ To make absorbing edges a way to do this is to just set the edges to always = 0 } 
{ keep everything the same, calculate the net gen of life }
{ then, before moving life_array_2 into life_array_1, set all edges of grid in life_array_2 = 0 } 
{ Tested this for glider but it doesn't disappear, only forms box in one from the edge rather than at the edge } 
{ however this is also what happpens on third party simulations with finite grid sizes } 















