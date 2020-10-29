{ needs quare to be defined }
{ starts with memory adddrss, n on stack. Fills n x n array with random number from 0 to 8 from 0 to n^2 -1 }

: random_array_fill dup square 0 do i 9 rnd swap 3 pick swap + c! loop cr ;

{ will leave mem address, n on stack still }
