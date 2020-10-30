{ THIS IS THE VERSION I AM EDITING                                        }
{ ----------------------------------------------------------------------- }   
{                                                                         }
{              Test routine to write a Life array to the screen as        }
{              a series or rectangles.   The routine calls a number       }
{              of Windows functions for displaying graphics.  You dont    }
{              need to worry about the details of this, simply call the   }
{              display routine as required.   The routine works by        }
{              looking through a 2D array searching for live cells.  On   }
{              finding a cell it calculates the 4 coordinates required    }
{              to define a square (of variable size) at the cell          }
{              position.  sets of 4 corner co-ordinates are stored in a   }
{              separate array and written to the screen using a windows   }
{              graphics routine all in one go.                            }
{                                                                         }
{                                                                         }
{              Scroll down to the line -- Life Stuff Goes Here --         }
{              to see how to call the routine.                            }
{                                                                         }
{              You need to replace the word : Life ; with your own        }
{              version to make use of the program.                        }                           
{                                                                         }
{              Expects a world configured as follows :-                   }
{                                                                         }
{              X-Size = world_x_size                                      }
{              y-size = world_y_size                                      }
{              Life stored in an array called Life_Array                  }
{


{ --------------------------- The base class ---------------------------- }
{                                                                         }
{        Windows code, dont mess with anything apart from the line        }
{        WS_OVERLAPPEDWINDOW 40 40 415 435 which sets the (x , y) upper   }
{        corner of the display window and the (x' , y') initial size      }
{                                                                         }            
  
0 VALUE hApp

DEFER ClassName  :NONAME   Z" SwiftApp" ;   IS ClassName
DEFER AppTitle   :NONAME   Z" SwiftApp" ;   IS AppTitle

: ENDAPP ( -- res )
   'MAIN @ [ HERE CODE> ] LITERAL < IF ( not an application yet)
      0 TO hApp
   ELSE ( is an application)
      0 PostQuitMessage DROP
   THEN 0 ;

[SWITCH AppMessages DEFWINPROC ( msg -- res )
   WM_DESTROY RUNS ENDAPP
SWITCH]

:NONAME ( -- res )
   MSG LOWORD AppMessages ; 4 CB: APP-WNDPROC

: /APP-CLASS ( -- )
      0  CS_OWNDC   OR
         CS_HREDRAW OR
         CS_VREDRAW OR                  \ class style
      APP-WNDPROC                       \ wndproc
      0 0 HINST                         \ class extra, window extra, hinstance
      HINST 101 LoadIcon
      NULL IDC_ARROW LoadCursor         \
      WHITE_BRUSH GetStockObject        \
      0 ClassName                       \ no menu, class name
   DefineClass DROP ;

: /APP-WINDOW ( -- hwnd )
   0 TO hApp
      0                                 \ extended style
      ClassName                         \ window class name
      AppTitle                          \ window caption
      WS_OVERLAPPEDWINDOW 40 40 415 435 \ position and size
      0 0 HINST                         \ program instance handle
      0                                 \ creation parameter
   CreateWindowEx DUP -EXIT
   DUP TO hApp
   DUP SW_SHOW ShowWindow DROP
   DUP UpdateWindow DROP ;

:PRUNE   ?PRUNE -EXIT
   hApp IF hApp WM_CLOSE 0 0 SendMessage DROP THEN
   ClassName HINST UnregisterClass DROP ;

: AppStart ( -- hwnd )
   hApp ?EXIT /APP-CLASS /APP-WINDOW ;


{ ---------- Define a menu with the button classes, exit, & about --------- }

100 ENUM M_EXIT
    ENUM M_ABOUT
VALUE M_USED

MENU APP-MENU

   POPUP "&File"
      M_EXIT   MENUITEM "E&xit"
   END-POPUP

   POPUP "&Help"
      M_ABOUT  MENUITEM "&About"
   END-POPUP

END-MENU


{ ------------------------------------ ABOUT box --------------------------- }


: APP-ABOUT ( -- )
   HWND Z" SwiftForth Application Template"  Z" Life Test" MB_OK MessageBox DROP ;

: MAKE-MENU ( -- )
   HWND APP-MENU LoadMenuIndirect SetMenu DROP ;


{ ---------------------------------- DEFERS -------------------------------- }

DEFER MakeStatus   ' NOOP      IS MakeStatus
DEFER SizeStatus   ' NOOP      IS SizeStatus
DEFER MakeToolbar  ' NOOP      IS MakeToolbar
DEFER SizeToolbar  ' NOOP      IS SizeToolbar
DEFER MakeMenu     ' MAKE-MENU IS MakeMenu
DEFER CreateMore   ' NOOP      IS CreateMore
DEFER AboutApp     ' APP-ABOUT IS AboutApp


{ -------------------------------------------------------------------------- }


: APP-EXIT ( -- )
   HWND WM_CLOSE 0 0 PostMessage DROP ;

[SWITCH AppCommands DROP ( cmd -- )
   M_EXIT   RUNS APP-EXIT
   M_ABOUT  RUNS AboutApp
SWITCH]

[+SWITCH AppMessages ( -- res )
   WM_SIZE    RUN: SizeStatus SizeToolbar 0 ;
   WM_COMMAND RUN: WPARAM LOWORD AppCommands 0 ;
   WM_CREATE  RUN: MakeMenu MakeStatus MakeToolbar CreateMore 0 ;
   WM_CLOSE   RUN: HWND GetMenu DestroyMenu DROP
                   HWND DestroyWindow DROP 0 ;
SWITCH]


{ --------------------------- Import Windows Functions -------------------- }

REQUIRES RND

1 IMPORT: DrawMenuBar        
1 IMPORT: IsWindow
4 IMPORT: DefMDIChildProc
5 IMPORT: DefFrameProc
3 IMPORT: CreatePen
5 IMPORT: Rectangle           


{ -------------------------- Create Pens and Brushes ------------------------}
{                                                                            }
{         By default paints live cells in green and dead cells in black.     }
{         Play with RGB values 0-255 to change default colors                }                                             


: BLACK-PEN     ( -- hpen )   { Create a colored pen style, thickness, RGB Color }
   PS_SOLID 1                 { Style and Thickness                              }
   000 16 LSHIFT
   000  8 LSHIFT OR
   000           OR           { Set RGB Color } 
   CreatePen ;


: COLOUR-PEN     ( -- hpen )  { Create a colored pen style, thickness, RGB Color }
   PS_SOLID 1                 { Style and Thickness                              }
   190 16 LSHIFT                                   { R }
   100  8 LSHIFT OR                                { G }
   200           OR           { Set RGB Color }    { B }
   CreatePen ;


: BLACK-BRUSH   ( -- hbrush )  { Sets brush color to full black hue }
   050 16 LSHIFT
   050  8 LSHIFT OR
   050           OR 
   CreateSolidBrush ;


: COLOUR-BRUSH   ( -- hbrush )  { Sets brush color to colour hue }
   190 16 LSHIFT                                   { R } 
   100  8 LSHIFT OR                                { G }
   200           OR                                { B } 
   CreateSolidBrush ;



{ ----------------------------- Life Stuff Goes Here ------------------------ }


100   Constant Update_Timer    { Sets update rate of windows - modest delay   }
                               { Smaller = faster refresh                     }

5 Constant Rect_Size           { Length of edges of rectangle used to display }
                               { life, must be >= 3 or blank display all balck}


z @  constant world_x_size     { x size of the world matrix }

z @  constant world_y_size     { y size of the world matrix }



variable world_size        { Total number of world elements (World_x_size * World_y_size) }

variable Life_Counter      { Number of live cells to output to screen }

variable Rect_Points       { Holds starting address of ext-memory for points defining rectangles } 

world_y_size world_x_size * world_size !

world_size @ 4 * 1 +  cells Allocate drop Rect_Points ! { Allocate memory for Array of rectangle data - size <n> x 4 + 1 }



{ : Random_Life_Array }              { Fills the Life_Array with random live / dead cells at each turn }
{  world_size @ 2 + 0 do }          { For testing purposes only.                                      }
{  2 Rnd Life_Array @ i cells + ! }
{  loop }
{ ; }



: Life
                                                                { The main Life routine goes here - we start with a random output }	 
  update_life                                                   { Replace this with your own Life routines to get them to display }
;



: Life>Rect                                                   { Turn Life Data into a series of rectangle         }
  0 Life_Counter !                                            { coordinates for painting to the screen            }
  World_y_Size 0 do
   World_x_Size  0 do
    Life_Array32 @ i World_y_Size j * + cells + @               { See if cell at (x,y) is alive                     }
     1 = if                                                   { If cell alive, make rectangle describing position }
     i Rect_Size * Rect_Points @ Life_Counter @ 4 * 1 + cells + ! 
     j Rect_Size * Rect_Points @ Life_Counter @ 4 * 2 + cells + !
     i Rect_Size * Rect_Size + Rect_Points @ Life_Counter @ 4 * 3 + cells + !
     j Rect_Size * Rect_Size + Rect_Points @ Life_Counter @ 4 * 4 + cells + ! 
     Life_Counter @ 1 +             
     Life_Counter !                                            { Incrememnt number of live cells this turn }
    then 
  loop
 loop
 Life_Counter @ Rect_Points @ !                                { Put no. of live cells into 1st posn of rect_array }
; 



: Next_Rect ( n -- x,y x',y')        { Take an integer <n> and put a set of 4 points defining the } 
   dup 1 - do                        { corners of the n'th rectangle on the stack                 }   
    Rect_Points @ i 4 * 1 + cells + @ 
    Rect_Points @ i 4 * 2 + cells + @
    Rect_Points @ i 4 * 3 + cells + @
    Rect_Points @ i 4 * 4 + cells + @
   loop
;



: CLEAR-RECT ( -- )                  { Clear a window by repainting it black }
   DUP GetDC
   BLACK-BRUSH                       { Select a black brush to paint rectangle with   }
   0 LOCALS| old brush dc hwnd |
   dc brush SelectObject TO old
   dc BLACK-PEN SelectObject         { Select A black pen with null action for border }
   hwnd PAD GetClientRect DROP
   dc 0 0 1000 1000 Rectangle DROP   { Paint an 1000 x 1000 rectangle black}
   hwnd dc ReleaseDC DROP
   brush DeleteObject DROP
;



: MULTI-RECT ( hwnd -- )             { Draw multiple rectangles in one go - corners stored in Rect_Points array }
   DUP GetDC 
   COLOUR-BRUSH    
   0 LOCALS| old brush dc hwnd |
   dc brush SelectObject TO old
   dc BLACK-PEN SelectObject
   hwnd PAD GetClientRect DROP
   Life Life>Rect                    { Call word to set up an array of rectangle data to output }
   Rect_Points @ @ 1 + 1 do          { Get number of rectangles to do                           }
   dc i Next_Rect Rectangle DROP     { Loop through rectangles from Rect_Points array           }
   loop
   hwnd dc ReleaseDC DROP
   brush DeleteObject DROP
;


: RECT-CREATE ( -- res ) HWND 1 Update_Timer 0 SetTimer DROP  0 ;

: RECT-TIMER  ( -- res ) HWND CLEAR-RECT 0 HWND MULTI-RECT 0    ;

[+SWITCH AppMessages WM_CREATE  RUNS RECT-CREATE WM_TIMER   RUNS RECT-TIMER SWITCH]



{ ------------------------------- Call appstart to run code -------------------------------- }



: go appstart drop ;


