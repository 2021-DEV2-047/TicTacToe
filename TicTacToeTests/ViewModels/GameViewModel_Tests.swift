import RxCocoa
import RxSwift
import UIKit
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
  
  func test_when_game_is_initialized_then_box_frames_should_be_prepared() {
    // arrange
    let gridContainerFrame = CGRect(x: 0, y: 0, width: 3, height: 3)
    // act
    vm.getBoxFrames(from: gridContainerFrame)
    // assert
    XCTAssertEqual(vm.getBox(at: 0).frame, CGRect(x: 0, y: 0, width: 1, height: 1))
    XCTAssertEqual(vm.getBox(at: 1).frame, CGRect(x: 1, y: 0, width: 1, height: 1))
    XCTAssertEqual(vm.getBox(at: 2).frame, CGRect(x: 2, y: 0, width: 1, height: 1))
    XCTAssertEqual(vm.getBox(at: 3).frame, CGRect(x: 0, y: 1, width: 1, height: 1))
    XCTAssertEqual(vm.getBox(at: 4).frame, CGRect(x: 1, y: 1, width: 1, height: 1))
    XCTAssertEqual(vm.getBox(at: 5).frame, CGRect(x: 2, y: 1, width: 1, height: 1))
    XCTAssertEqual(vm.getBox(at: 6).frame, CGRect(x: 0, y: 2, width: 1, height: 1))
    XCTAssertEqual(vm.getBox(at: 7).frame, CGRect(x: 1, y: 2, width: 1, height: 1))
    XCTAssertEqual(vm.getBox(at: 8).frame, CGRect(x: 0, y: 2, width: 1, height: 1))
  }
}

// MARK: - Convenience Methods

extension GameViewModel_Tests {
  
  private func subscribe() {
    vm.alertMessage.bind(to: alertMessage).disposed(by: bag)
  }
}
