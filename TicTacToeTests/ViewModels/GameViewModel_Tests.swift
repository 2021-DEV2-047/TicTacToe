import XCTest

@testable import TicTacToe

class GameViewModel_Tests: XCTestCase {
  
  let vm = GameViewModel()
  
  func test_initialize_game_view_model() {
    XCTAssertNotNil(vm)
  }
}
