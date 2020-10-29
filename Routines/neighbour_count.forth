{ Written by Sohum Panda }
{ 22/10/20 } 

{ Life_Array_1 is a variable }
{ To get a value out of it, instead of doing Life_Array_1  i + c@, as case woud be for a constant }
{ you would need to do Life_Array_1  @ i + c@ } 

{ create a neighbour array and store it as a variable } 
 


{ top left }
{ for element in top left, need to count alive cell neighbours from cell to right and underneath and diagonal bottom right }

          Life_Array_1 @ i 1+ + c@ 
		  Life_Array_1 @ i n + + c@ 
		  Life_Array_1 @ i n + 1+ + c@ + + 
		  neighbours @ i + c!  



{ top right }
{ for element in top right, need to count alive cell neighbours from cell to left and underneath and diagonal bottom left }

           Life_Array_1 @ i 1- + c@
           Life_Array_1 @ i n + + c@ 
		   Life_Array_1 @ i n + 1- + c@ + + 
		   neighbours @ i + c! 




{ bottom left }
{ for element in bottom right, need to count alive cell neighbours from cell to right and above and diagonal top right }

             Life_Array_1 @ i 1+ + c@ 
             Life_Array_1 @ i n - + c@
             Life_Array_1 @ i n - 1+ + c@ + + 
			 neighbours @ i + c! 




{ bottom right }
{ for element in bottom right, need to count alive cell neighbours from cell to left and above and diagonal top left } 

              Life_Array_1 @ i 1- + c@ 
              Life_Array_1 @ i n - + c@
              Life_Array_1 @ i n - 1- + c@ + + 
			  neighbours @ i + c! 



			  
{ top edge } 
{ for i you need:  i-1,  i+1,  i+n-1,  i+n,  i+n+1 } 

          Life_Array_1 @ i 1- + c@
          Life_Array_1 @ i 1+ + c@
		  Life_Array_1 @ i n + 1- + c@
		  Life_Array_1 @ i n + + c@ 
		  Life_Array_1 @ i n + 1+ + c@ + + + + 
		  neighbours @ i + c! 
		  



{ bottom edge } 
{ for i you need:  i-1,  i+1,  i-n-1,  i-n,  i-n+1 } 

             Life_Array_1 @ i 1- + c@
             Life_Array_1 @ i 1+ + c@
			 Life_Array_1 @ i n - 1- + c@
			 Life_Array_1 @ i n - + c@
			 Life_Array_1 @ i n - 1+ + c@ + + + + 
			 neighbours @ i + c! 
			 



{ left edge } 
{ for i you need: i-n,  i-n+1,  i+1,  i+n,  i+n+1 }

           Life_Array_1 @ i n - + c@ 
		   Life_Array_1 @ i n - 1+ + c@
		   Life_Array_1 @ i 1+ + c@
		   Life_Array_1 @ i n + + c@
		   Life_Array_1 @ i n + 1+ + c@ + + + + 
		   neighbours i @ + c! 




{ right edge } 
{ for i you need: i-n-1,  i-n,  i-1,  i+n-1,  i+n }

            Life_Array_1 @ i n - 1- + c@
			Life_Array_1 @ i n - + c@
			Life_Array_1 @ i 1- + c@
			Life_Array_1 @ i n + 1- + c@
			Life_Array_1 @ i n + + c@ + + + + 
			neighbours @ i + c!  
			



{ middle }
{ for i you need all 8 surrounding elements }

             Life_Array_1 @ i n - 1- + c@
			 Life_Array_1 @ i n - + c@
			 Life_Array_1 @ i n - 1+ + c@
			 Life_Array_1 @ i 1- + c@
			 Life_Array_1 @ i 1+ + c@ 
			 Life_Array_1 @ i n + 1- + c@
			 Life_Array_1 @ i n + + c@
			 Life_Array_1 @ i n + 1+ + c@ + + + + + + + 
			 neighbours @ i + c! 
			 
			 
			 



		   
		   
		   
		   
		   
		   
		   