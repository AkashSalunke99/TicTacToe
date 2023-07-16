# TicTacToe

The game consist 3x3 grid layout:
* User and system can place their marks in this grid layout.

The user plays as 'X' and the system plays as 'O':
* Created two custom shapes `X` & `O` to represent the user and system’s play respectively.
* Implemented the logic to handle user input (tap gesture) for placing 'X' marks on the board.
* After the user’s turn, the system auto plays its turn by marking the cell with `O`.

The game handles the following cases:
* No winner: The game continues until there is a winner or all cells are filled.
* Winner: Determined and displayed the winner when a player has three marks in a row
(horizontally, vertically, or diagonally).
* Displayed the winner sign when a player wins.
* Provided an option to start a new game after a winner is determined or when the game ends in a tie.
* Drew a straight line connecting the three winning marks to visually indicate the winning combination (vertical, horizontal, or diagonal).

UI: 
* The 'X' shape drawn in the color RED, and the 'O' shape drawn in the color blue.

UI Video: https://drive.google.com/file/d/1O5jTsftg82m2OH2NubuCuG-fYqrY8dTI
