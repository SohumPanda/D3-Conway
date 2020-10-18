{ this will print the number in the matrix element located at x,y where x is row number and y is column number }
{ to use this you need to have the mem address, n, number to put in array, x (row number), y (column number) in the stack before typing array_@} 

: array_@ 1- swap 1- 2 pick * + nip over swap + c@ cr . ; 

{ should leave memory address on top of stack }
