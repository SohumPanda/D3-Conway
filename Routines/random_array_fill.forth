{ Written by Sohum Panda }
{ 19/10/20 }


: random_array_fill dup square 0 do                  { needs square to be defined                                                }  
	i 9 rnd swap 3 pick swap + c! loop cr ;      { Fills z x z array with random numbers from 0 to 8                         }
                                                     { mem, z -------- mem, z                                                    }
													 
													 
													 
													 
													 
{ 20/10/20 }



  : random_array_fill_0or1 dup square 0 do           { Fills an array with random values from 0 to 1. Needs square defined       }
	i 2 rnd swap 3 pick swap + c! loop cr ;      { mem, z -------- mem, z                                                    }


