import XCTest

@testable import TicTacToe

class TicTacToe_Tests: XCTestCase {
  
  let ticTacToe = TicTacToe()

  func test_when_game_is_launched_then_the_board_is_initialized() {
    // arrange & act
    let boardSize = ticTacToe.boardSize()
    // assert
    XCTAssertEqual(boardSize, 9)
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
  
  func test_if_players_play_on_a_played_position_then_he_cannot_play_and_an_alert_message_is_displayed() {
    // arrange
    ticTacToe.addSymbol(toBox: 0)
    // act
    ticTacToe.addSymbol(toBox: 0)
    // assert
    let testedBox = ticTacToe.getBox(0)
    XCTAssertEqual(testedBox, "X")
    XCTAssertEqual(ticTacToe.getAlertMessage(), "You cannot play on a played position !")
  }
  
  func test_when_the_player_lines_up_three_symbols_horizontally_then_he_wins_and_the_other_player_cannot_play() {
    // arrange
    ticTacToe.addSymbol(toBox: 0) // X
    ticTacToe.addSymbol(toBox: 3) // O
    ticTacToe.addSymbol(toBox: 1) // X
    ticTacToe.addSymbol(toBox: 4) // O
    // act
    ticTacToe.addSymbol(toBox: 2) // X
    ticTacToe.addSymbol(toBox: 5)
    // assert
    let testedBox = ticTacToe.getBox(5)
    XCTAssertEqual(testedBox, "")
    XCTAssertEqual(ticTacToe.getAlertMessage(), "X win the game.")
  }
  
  func test_when_player_lines_up_three_symbols_vertically_then_he_wins() {
    // arrange
    ticTacToe.addSymbol(toBox: 0) // X
    ticTacToe.addSymbol(toBox: 1) // O
    ticTacToe.addSymbol(toBox: 3) // X
    ticTacToe.addSymbol(toBox: 4) // O
    // act
    ticTacToe.addSymbol(toBox: 6) // X
    // assert
    XCTAssertEqual(ticTacToe.getAlertMessage(), "X win the game.")
  }
  
  func test_when_player_make_a_diagonal_then_he_wins() {
    // arrange
    ticTacToe.addSymbol(toBox: 0) // X
    ticTacToe.addSymbol(toBox: 1) // O
    ticTacToe.addSymbol(toBox: 4) // X
    ticTacToe.addSymbol(toBox: 7) // O
    // act
    ticTacToe.addSymbol(toBox: 8) // X
    // assert
    XCTAssertEqual(ticTacToe.getAlertMessage(), "X win the game.")
  }
  
  func test_when_nobody_win_then_draw_message_should_be_presented() {
    // arrange & act
    givenDrawGame()
    // assert
    XCTAssertEqual(ticTacToe.getAlertMessage(), "Draw. The game is over, start a new game.")
  }
  
  func test_when_game_is_finished_and_player_plays_then_retry_game_message_is_displayed() {
    // arrange
    givenDrawGame()
    // act
    ticTacToe.addSymbol(toBox: 4)
    // assert
    XCTAssertEqual(ticTacToe.getAlertMessage(), "Draw. The game is over, start a new game.")
  }
}

// MARK: - Convenience Methods

extension TicTacToe_Tests {
  
  private func givenDrawGame() {
    ticTacToe.addSymbol(toBox: 4) // X
    ticTacToe.addSymbol(toBox: 0) // O
    ticTacToe.addSymbol(toBox: 2) // X
    ticTacToe.addSymbol(toBox: 6) // O
    ticTacToe.addSymbol(toBox: 3) // X
    ticTacToe.addSymbol(toBox: 5) // O
    ticTacToe.addSymbol(toBox: 7) // X
    ticTacToe.addSymbol(toBox: 1) // O
    ticTacToe.addSymbol(toBox: 8) // X
  }
}
