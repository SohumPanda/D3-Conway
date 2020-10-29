{ Created by : Tanjim }
{ 27/10/2020          }
  
{ Edited by Sohum Panda     }
{ 27/10/2020                }  
  



{ Assumes arrays have dimensions z by z 								  }
  
{ Returns a True (-1) if arrays same                                           }
{ Rturns a False (0 ) if arrays are different                                  }   
  
  
: compare_arrays   												{ compares two arrays 				}
	-1															{ place a logical true on stack		}
	z @ square 0 do												{ loop from 0 to z^2				}
		2 pick i + c@ 2 pick i + c@ 						    { get the values for each array at 	}
		= not if												{ index i, then if they arent equal:}
			drop 0 												{ add a logical false				}
		then													{ else do nothing					}
	loop
	nip nip														{ remove the addresses, only True / }
	;															{ False left on stack 				}
                                                                { mem1, mem2 ------- True/False     } 

