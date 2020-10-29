{ case-endcase structure to take a value from 0-8 and apply life's rules to determine if a cell with that number of neighbours }
{ would be alive or dead in next generation }
{ this will take n off the stack }  

{ this word takes n ( the number of neighbours ) off the stack and will return 0,1,2 on the stack in its place } 

: conways_rules  case      { here 0 means the cell dies }		
	0 of 0 endof                    { means the cell will be alive }
	1 of 0 endof                    { 2 means the state of the cell is unchanged } 
	2 of 2 endof
	3 of 1 endof
	4 of 0 endof
	5 of 0 endof 
	6 of 0 endof
	7 of 0 endof
	8 of 0 endof
	endcase 
	cr ; 
	

{ takes number (0, or 1 representing if cell dead or alive), number of neighbours } 
{ and returns on the stack the value 0 or 1 of if the cell is dead or alive }

: apply_conway_rule cr conways_rules
	case
		0 of 0 endof
		1 of 1 endof
		2 of dup endof 
	endcase nip ; 
	
	
