{ need to define the words square and cube before doing this } 
{ overall this creates a file called test_file_Ex23.txt at the location specified with pairs of square and cube numbers from 20^3 20^3 to 40^2 40^3 }

variable test_file_id  { creates a variable called test_file_id to store the numerical file id value } 

: make_test_file s" C:\Users\sohum\Documents\Uni\Year3\Labs\D3_Conway\test_file_Ex23.txt" r/w create-file drop test_file_id ! ;

: write_square_cube                                 { define the word to square and cube the numbers } 
  41 20 do
 
  i square (.) test_file_id @ write-file drop       { file must be open to write the vals to it } 
  s"  "     test_file_id @ write-file drop
  i cube (.) test_file_id @ write-line drop
  loop
;

: close-test-file test_file_id @ close-file drop ;

: file_test                                         
  make_test_file
  write_square_cube
  close-test-file ;
  
  
  { i (.)     test_file_id @ write-file drop
  s"  "     test_file_id @ write-file drop }