import RxCocoa
import RxSwift
import UIKit
import XCTest

@testable import TicTacToe

class GameViewModel_Tests: XCTestCase {
  
  private let alertMessage = BehaviorRelay<String>(value: "")
  private let boxImageViewsRelay = BehaviorRelay<[UIImageView]>(value: [])
  
  private let bag = DisposeBag()
  private let vm = GameViewModel()
  
  func test_when_game_is_initialized_then_alert_message_should_be_set() {
    // arrange
    subscribe()
    // act & assert
    XCTAssertEqual(alertMessage.value, "The X begin")
  }
  
  func test_when_game_is_initialized_then_box_frames_should_be_prepared() {
    // arrange & act
    givenPreparedGrid()
    // assert
    XCTAssertEqual(vm.getBoxFrame(at: 0), CGRect(x: 0, y: 0, width: 1, height: 1))
    XCTAssertEqual(vm.getBoxFrame(at: 1), CGRect(x: 1, y: 0, width: 1, height: 1))
    XCTAssertEqual(vm.getBoxFrame(at: 2), CGRect(x: 2, y: 0, width: 1, height: 1))
    XCTAssertEqual(vm.getBoxFrame(at: 3), CGRect(x: 0, y: 1, width: 1, height: 1))
    XCTAssertEqual(vm.getBoxFrame(at: 4), CGRect(x: 1, y: 1, width: 1, height: 1))
    XCTAssertEqual(vm.getBoxFrame(at: 5), CGRect(x: 2, y: 1, width: 1, height: 1))
    XCTAssertEqual(vm.getBoxFrame(at: 6), CGRect(x: 0, y: 2, width: 1, height: 1))
    XCTAssertEqual(vm.getBoxFrame(at: 7), CGRect(x: 1, y: 2, width: 1, height: 1))
    XCTAssertEqual(vm.getBoxFrame(at: 8), CGRect(x: 2, y: 2, width: 1, height: 1))
  }
  
  func test_when_user_press_the_grid_then_symbol_should_appear_in_the_right_box() {
    // arrange
    subscribe()
    givenPreparedGrid()
    givenPreparedBoxImageViews()
    
    // act
    let tappedLocation = CGPoint(x: 0.2, y: 0.6)
    vm.didTappedGrid(at: tappedLocation)
    
    // assert
    XCTAssertEqual(alertMessage.value, "O has to play")
    let arrayShouldBe = getBoxImageViewsTestedArray(with: R.image.game.cross(), at: 0)
    XCTAssertEqual(boxImageViewsRelay.value, arrayShouldBe)
  }
}

// MARK: - Convenience Methods

extension GameViewModel_Tests {
  
  private func givenPreparedGrid() {
    let gridContainerFrame = CGRect(x: 0, y: 0, width: 3, height: 3)
    vm.setUpBoxFrames(from: gridContainerFrame)
  }
  
  private func givenPreparedBoxImageViews() {
    vm.setUpBoxImageViews()
  }
  
  private func getBoxImageViewsTestedArray(with image: UIImage?, at row: Int) -> [UIImageView] {
    var arrayShouldBe = boxImageViewsRelay.value
    let imageView = arrayShouldBe[row]
    imageView.image = image
    arrayShouldBe[row] = imageView
    return arrayShouldBe
  }
  
  private func subscribe() {
    vm.alertMessage.bind(to: alertMessage).disposed(by: bag)
    vm.boxImageViewsRelay.bind(to: boxImageViewsRelay).disposed(by: bag)
  }
}
