{ to use this you need to have the mem address, n, number to put in array, x (row number), y (column number) }

: array_! 1- swap 1- 3 pick * + 3 pick swap + c! drop ;

{ mem, n, no to put in element, x, y ----- mem }