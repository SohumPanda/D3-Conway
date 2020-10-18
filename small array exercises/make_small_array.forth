{ make small array word. A n x n matrix would have n^2 elements, so you need to square n and allocate. }
{ in console to use this word type n make_small_array. Needs the word square to be defied to work }

: make_small_array square dup allocate drop dup rot 0 fill ;

{ this will leave the mem address on top of the stack to use again }


