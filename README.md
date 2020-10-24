# D3-Conway
Forth code to run Conway's Game of Life

As of right now you can see the code working.
Open swiftforth
drag and drop in forth_words_v7 console.
Type in 

1 1 import_glider 

into the console and hit enter.
Drag and drop in 
Life_Display_Squares_Sohum_v1 into the console.
Type in 

go 

into the console and hit enter.
You should see a purple glider form in the top of a 20 x 20 life grid and move



In folder 4.3_Mastering_Forth are some words created whilst working through exercise 4.3 of the lab handout. I haven't found a way to change the folder name in the github repository so it will stay named as it is. Each time I create a new word or new words which relate to a separate 'part' of creating the game of life it will be uploaded into that folder.

The words in these individual .forth files will then be copied into the latest version of forth_words_v.forth to allow me to drag and drop a file with all my forth words into Swift Forth in one go. 

The words in small array exercise have also been included in the forth_words files. These words were created whilst working through the ' small array exercise ' in the lab handout.

From forth_words_v5 onwards I have now split the words into chunks arranged chronologically on when pieces of new code and words were created and added to the newest version of forth_words.

All words that have been written have been by me. The general structure of them has come from discussion with my lab partner. Words with my lab partner's name were done so by him (Tanjim) on his part to work on.

Forth_words_v7 has significant changes. Instead of using n to represent an n by n dimension size grid, the letter z is used as there were some issues with n not being unique. Additionally all arrays are now stored as variables not constants and z is not a variable too. All necessary words were slightly adjusted to now work for variables. In most cases all this involved was adding the '@' symbol where neccessary. 
