# TicTacToe

This project include the TicTacToe kata.

Tic-tac-toe (American English), noughts and crosses (Commonwealth English and British English), or Xs and Os/“X’y O’sies” (Ireland), is a paper-and-pencil game for two players, X and O, who take turns marking the spaces in a 3×3 grid. 
The player who succeeds in placing three of their marks in a diagonal, horizontal, or vertical row is the winner.

# Configuration

- The board has always 9 boxes : 3x3 grid.
- X always goes first.
- Players cannot play on a played position.
- Players alternate placing X’s and O’s on the board until either:
  - One player has three in a row, horizontally, vertically or diagonally
  - All nine squares are filled.
- If a player is able to draw three X’s or three O’s in a row, that player wins.
- If all nine squares are filled and neither player has three in a row, the game is a draw.

# Tests

- Tests cover the rule of the game:
  - A board should have 9 boxes
  - When the game is launched, then X should start
  - When a player has played, then symbol is changed
  - When a player played on a played position, then he cannot play and an alert message is displayed
  - Victory tests :
    - Horizontal row
    - Vertical row
    - Diagonal row
  - When nobody win then it's a draw and a message is displayed
  - When the game is finished and players try to play, then retry game message is displayed
  - When a game begin, the the alertMessage show the player that need to play and show the player who should play at the end of each round

# Build

Tests are included inside TicTacToe_Tests.swift and test the TicTacToe.swift class.
If you want to build all the tests, press command + U : ⌘ + U
