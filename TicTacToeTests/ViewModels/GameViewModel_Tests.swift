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
    // arrange & act
    givenPreparedGrid()
    // assert
    XCTAssertEqual(vm.getBox(at: 0), CGRect(x: 0, y: 0, width: 1, height: 1))
    XCTAssertEqual(vm.getBox(at: 1), CGRect(x: 1, y: 0, width: 1, height: 1))
    XCTAssertEqual(vm.getBox(at: 2), CGRect(x: 2, y: 0, width: 1, height: 1))
    XCTAssertEqual(vm.getBox(at: 3), CGRect(x: 0, y: 1, width: 1, height: 1))
    XCTAssertEqual(vm.getBox(at: 4), CGRect(x: 1, y: 1, width: 1, height: 1))
    XCTAssertEqual(vm.getBox(at: 5), CGRect(x: 2, y: 1, width: 1, height: 1))
    XCTAssertEqual(vm.getBox(at: 6), CGRect(x: 0, y: 2, width: 1, height: 1))
    XCTAssertEqual(vm.getBox(at: 7), CGRect(x: 1, y: 2, width: 1, height: 1))
    XCTAssertEqual(vm.getBox(at: 8), CGRect(x: 2, y: 2, width: 1, height: 1))
  }
  
  func test_when_user_press_the_grid_then_symbol_should_appear_in_the_right_box() {
    // arrange
    givenPreparedGrid()
    // act
    let tappedLocation = CGPoint(x: 0.2, y: 0.6)
    vm.didTappedGrid(at: tappedLocation)
    // assert
    XCTAssertEqual(vm.getBox(at: 0).image, R.image.game.cross())
    XCTAssertEqual(alertMessage.value, "O has to play.")
  }
}

// MARK: - Convenience Methods

extension GameViewModel_Tests {
  
  private func givenPreparedGrid() {
    let gridContainerFrame = CGRect(x: 0, y: 0, width: 3, height: 3)
    vm.setUpBoxFrames(from: gridContainerFrame)
  }
  
  private func subscribe() {
    vm.alertMessage.bind(to: alertMessage).disposed(by: bag)
  }
}
