{  Import Glider word Made by: Tanjim Chowdhury }
{  23/10/2020                } 
  
{  Edited by Sohum Panda 23/10/2020 }
  
{ Puts a glider into the life_array_1 with x (row number) , y (column number) at top-left corner }
{ requires constants n and life_array_1 and the word array_!            }

variable glider_x
variable glider_y  



{ eg 1 1 import_glider inserts a glider starting at 1,1 }

: import_glider
  glider_y !
  glider_x !														    { saves x,y into the variables  }
  life_array_2 n 1 glider_x @ glider_y @ 2 + array_! drop drop			{ changes values in life_array_1}
  life_array_2 n 1 glider_x @ 1 + glider_y @ array_! drop drop			{ so a glider appears in the top}
  life_array_2 n 1 glider_x @ 1 + glider_y @ 2 + array_! drop drop 		{ left corner                   }
  life_array_2 n 1 glider_x @ 2 + glider_y @ 1 + array_! drop drop 
  life_array_2 n 1 glider_x @ 2 + glider_y @ 2 + array_! drop drop 	
;








{ Words for importing Methuselah Structures }
{ Written by Sohum Panda }
{ 27/10/20               } 











: import_line                                                        { adds a horizontal line at x,y        }
    rot 0                                                            { a is the length of the line          }
      do                                                             { loop from 0 to a                     }
        life_array_2 @ z @ 1 4 pick 4 pick i +                       { writes the 1 into array              }   
        array_! drop drop                                                      
    loop drop drop                                                   { a, x, y ------ }    
;



{ In order of the Methusela seeds givn in the lab script, these are the words to import them into life in the orientations }
{ shown in the lab script, page 5                                                                                          }



: Rpent_grandparent                                                  { imports an r pentomino grandparent    }
 3 2 pick 2 pick 1+ import_line                                      { methusela seed with the top left of   }
 1 2 pick 1+ 2 pick import_line                                      { the pattern at x,y                    }
 1 2 pick 2 + 2 pick import_line drop drop ;                         { x, y -------                          } 
 
 
 
 
 
: pi_heptomino                                                       { imports a pi heptomino with top left  } 
3 2 pick 2 pick import_line                                          { at x,y                                }
1 2 pick 1+ 2 pick import_line                                       { x,y ---------                         }
1 2 pick 1+ 2 pick 2 + import_line 
1 2 pick 2 + 2 pick import_line
1 2 pick 2 + 2 pick 2 + import_line drop drop ; 
 
 
 
 
: methusela_3                                                        { imports the third methusela seed from } 
1 2 pick 2 pick 2 + import_line                                      { the lab script, with top left of      }
1 2 pick 2 pick 4 + import_line                                      { pattern starting at x,y               }
2 2 pick 1+ 2 pick import_line                                       { x,y ---------                         }
1 2 pick 1+ 2 pick 4 + import_line
1 2 pick 2 + 2 pick 2 + import_line
1 2 pick 2 + 2 pick 4 + import_line drop drop ;





: thunderbird                                                        { imports a thunderbird with top left   }
1 2 pick 2 pick 4 + import_line                                      { of pattern starting at x,y            }
3 2 pick 1+ 2 pick import_line                                       { x,y ----------                        }
1 2 pick 1+ 2 pick 4 + import_line
1 2 pick 2 + 2 pick 4 + import_line drop drop ; 




 
: e_heptomino                                                        { imports an e heptomino with the top   }
3 2 pick 2 pick 1+ import_line                                       { left of the pattern starting at x,y   }  
2 2 pick 1+ 2 pick import_line                                       { x,y ---------                         }
2 2 pick 2 + 2 pick 1+ import_line drop drop ; 



