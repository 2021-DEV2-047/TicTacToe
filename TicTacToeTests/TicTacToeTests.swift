import XCTest

@testable import TicTacToe

class TicTacToeTests: XCTestCase {
  
  let ticTacToe = TicTacToe()

  func test_when_game_is_launched_then_the_board_is_initialized() {
    // arrange & act
    let board = ticTacToe.board
    // assert
    XCTAssertEqual(board.count, 9)
  }
  
  func test_when_game_started_then_cross_should_begin() {
    // arrange & act
    ticTacToe.addSymbol(toBox: 0)
    // assert
    let testedBox = ticTacToe.getBox(0)
    XCTAssertEqual(testedBox, "X")
  }
  
  func test_when_player_has_played_then_symbol_change() {
    // arrange
    ticTacToe.addSymbol(toBox: 0)
    // act
    ticTacToe.addSymbol(toBox: 1)
    // assert
    let testedBox = ticTacToe.getBox(1)
    XCTAssertEqual(testedBox, "O")
  }
  
  func test_players_cannot_play_on_a_played_position() {
    // arrange
    ticTacToe.addSymbol(toBox: 0)
    // act
    ticTacToe.addSymbol(toBox: 0)
    // assert
    let testedBox = ticTacToe.getBox(0)
    XCTAssertEqual(testedBox, "X")
  }
  
  func test_when_the_player_lines_up_three_symbols_horizontally_then_he_wins() {
    // arrange
    ticTacToe.addSymbol(toBox: 0) // X
    ticTacToe.addSymbol(toBox: 3) // O
    ticTacToe.addSymbol(toBox: 1) // X
    ticTacToe.addSymbol(toBox: 4) // O
    ticTacToe.addSymbol(toBox: 2) // X
    // act
    ticTacToe.addSymbol(toBox: 5)
    // assert
    let testedBox = ticTacToe.getBox(5)
    XCTAssertEqual(testedBox, "")
  }
}
