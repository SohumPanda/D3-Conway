{ Written by Sohum Panda }
{ 27/10/20               }


variable measurements_file_id  { creates a variable called test_file_id to store the numerical file id value } 

: make_measurements_file                    
 s" C:\Users\sohum\Documents\Uni\Year3\Labs\D3_Conway\Measurements\measurements_file.csv" 
 r/w create-file drop measurements_file_id ! 
 ;



{ run the word make_measurements_file in the console to create measurements_file.csv at the location } 
{ Import all words into console and then import starting structure into life_array_2.                }
{ make_measurements_file                                                                             }
{ save_measurements                                                                                  }





: save_measurements                                                    { saves measurements to a csv file     }
  increment_generations                                                { run the measurement words            }
  count_alive_2 
  calculate_diff_array
  count_born count_died
  static_check 2dynamic_check 
  
    generations @ (.) measurements_file_id @ write-file drop                { add generation number               }
    s" , " measurements_file_id @ write-file drop                           { adds comma and space                }
	
   { alive_1 @ (.) measurements_file_id @ write-file drop }                 { add cells alive in prev gen         }
   { s" , " measurements_file_id @ write-file drop }                        { adds comma and space                }
    
    alive_2 @ (.) measurements_file_id @ write-file drop                    { add cells alive in current gen      }
    s" , " measurements_file_id @ write-file drop                           { adds comma and space                }
   
   no_Born @ (.) measurements_file_id @ write-file drop                     { add cells born in current gen       }
    s" , " measurements_file_id @ write-file drop                           { adds comma and space                }
    no_Died @ (.) measurements_file_id @ write-file drop                    { add cells that died since prev gen  }
    s" , " measurements_file_id @ write-file drop                           { adds comma and space                }
    
	static @ (.) measurements_file_id @ write-file drop                 { add if current gen same as prev gen }	
    s" , " measurements_file_id @ write-file drop                           { adds comma and space                }
    2dynamic @ (.) measurements_file_id @ write-line drop                   { add if current gen same as gen -2   }   
 
;



: close_measurements                                      { Close the file pointed to by the file  }
  measurements_file_id @                                  { handle.                                }
  close-file drop
; 
