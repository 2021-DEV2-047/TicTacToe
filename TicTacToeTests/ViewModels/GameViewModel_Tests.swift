import RxCocoa
import RxSwift
import XCTest

@testable import TicTacToe

class GameViewModel_Tests: XCTestCase {
  
  private let alertMessage = BehaviorRelay<String>(value: "")
  
  private let bag = DisposeBag()
  private let vm = GameViewModel()
  
  func test_initialize_game_view_model() {
    // arrange
    subscribe()
    // act & assert
    XCTAssertNotNil(vm)
    XCTAssertEqual(alertMessage.value, "The X begin.")
  }
}

// MARK: - Convenience Methods

extension GameViewModel_Tests {
  
  private func subscribe() {
    vm.alertMessage.bind(to: alertMessage).disposed(by: bag)
  }
}
