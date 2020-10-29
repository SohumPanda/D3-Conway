# D3-Conway
Forth code to run Conway's Game of Life

Routines folder contains files that contain words together that do a different part of the calculation to create the final game of life

All_Words folder contain the forth_words_v files. These files contain all words needed to run life. After a set of words is written in a file in Routines folder,
it is copied into the newest version of forth_words so all useful words can be loaded in SwiftForth in one go.

The words in small array exercise have also been included in the forth_words files. These words were created whilst working through the ' small array exercise ' in the lab handout.

Some words were written directly into forth_words and not separately in one of the files in Routines 

From forth_words_v5 onwards I have now split the words into chunks arranged chronologically on when pieces of new code and words were created and added to the newest version of forth_words.

All words that have been written have been by me. The general structure of them has come from discussion with my lab partner. Words with my lab partner's name were done so by him (Tanjim) on his part to work on.

Forth_words_v7 has significant changes. Instead of using n to represent an n by n dimension size grid, the letter z is used as there were some issues with n not being unique. Additionally all arrays are now stored as variables not constants and z is not a variable too. All necessary words were slightly adjusted to now work for variables. In most cases all this involved was adding the '@' symbol where neccessary. 

Read the INSTRUCTIONS.TXT file for instructions on how to run life using SwiftForth
