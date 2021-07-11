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

- Tests cover the rule of the game :
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
  - When a game begin, the alertMessage shows the player that has to play (The X). And then, shows the player who should play at the end of each round.
  
- Tests cover the GameViewModel class:
  - When the game is initialized, then alert message should have the correct message
  - When the game is initialized, then boxFrames should be prepared (they will contain images)
  - When the user press the grid, then the correct symbol should appear in the right box

# Build & Run

The project use the following libraries : 
- R.swift (to secure resources)
- RxCocoa and RxSwift (to make bindings)
- Snapkit (to build the graphical interfaces)

Please, make sure that you run the command "pod install" before opening the project.

If you want to build all the tests, press command + U (⌘ + U)

Tests are included inside :
- TicTacToe_Tests.swift and test the TicTacToe.swift class.
- GameViewModel_Tests.swft and test the GameViewModel.swift class

The game is playable on an iOS device :
- Fill the provisionning profile if you want to build it on your iPhone
- Select a device and press command + R (⌘ + R) if you want to run the project on simulator.

# Code Coverage

Code coverage is 100% for TicTacToe.swift and GameViewModel.swift
