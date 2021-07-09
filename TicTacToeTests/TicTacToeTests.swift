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
    let firstBox = ticTacToe.getBox(1)
    XCTAssertEqual(firstBox, "X")
  }
}
