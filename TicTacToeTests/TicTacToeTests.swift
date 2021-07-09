import XCTest

@testable import TicTacToe

class TicTacToeTests: XCTestCase {
  
  let ticTacToe = TicTacToe()

  func test_when_game_is_launched_then_the_board_is_initialized() {
    let board = ticTacToe.board
    XCTAssertEqual(board.count, 9)
  }
  
  func test_when_game_started_then_cross_should_begin() {
    ticTacToe.addSymbol(toBox: 1)
    let testedBox = ticTacToe.getBox(1)
    XCTAssertEqual(testedBox, "X")
  }
  
  func test_when_player_has_played_then_symbol_change() {
    ticTacToe.addSymbol(toBox: 1)
    ticTacToe.addSymbol(toBox: 2)
    let testedBox = ticTacToe.getBox(2)
    XCTAssertEqual(testedBox, "O")
  }
  
  func test_players_cannot_play_on_a_played_position() {
    ticTacToe.addSymbol(toBox: 1)
    ticTacToe.addSymbol(toBox: 1)
    let testedBox = ticTacToe.getBox(1)
    XCTAssertEqual(testedBox, "X")
  }
}
