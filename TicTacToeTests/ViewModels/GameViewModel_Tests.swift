import RxCocoa
import RxSwift
import UIKit
import XCTest

@testable import TicTacToe

class GameViewModel_Tests: XCTestCase {
  
  private let alertMessage = BehaviorRelay<NSAttributedString>(value: NSAttributedString(string: ""))
  private let boxImageViewsRelay = BehaviorRelay<[UIImageView]>(value: [])
  private let retryButtonIsVisibleRelay = BehaviorRelay<Bool>(value: false)
  
  private let bag = DisposeBag()
  private let vm = GameViewModel()
  
  func test_when_game_is_initialized_then_alert_message_should_be_set() {
    // arrange
    subscribe()
    // act & assert
    XCTAssertEqual(alertMessage.value.string, "The X begin")
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
    
    // act
    let tappedLocation = CGPoint(x: 0.2, y: 0.6)
    vm.didTappedGrid(at: tappedLocation)
    
    // assert
    XCTAssertEqual(alertMessage.value.string, "O has to play")
    let array: [UIImage?] = [
      R.image.game.cross(), nil, nil,
      nil, nil, nil,
      nil, nil, nil,
    ]
    let arrayShouldBe = getImageViewArray(from: array)
    
    for (index, boxImageView) in boxImageViewsRelay.value.enumerated() {
      let testedImageView = arrayShouldBe[index].image
      XCTAssertEqual(boxImageView.image, testedImageView)
    }
  }
  
  func test_when_a_game_is_finished_then_retrieve_button_should_be_visible() {
    // arrange
    subscribe()
    givenPreparedGrid()
    
    // act
    XCTAssertEqual(retryButtonIsVisibleRelay.value, false)
    var tappedLocation = CGPoint(x: 0.2, y: 0.6) // X
    vm.didTappedGrid(at: tappedLocation)
    // assert
    XCTAssertEqual(retryButtonIsVisibleRelay.value, false)
    
    // act
    tappedLocation = CGPoint(x: 1.2, y: 0.6) // O
    vm.didTappedGrid(at: tappedLocation)
    tappedLocation = CGPoint(x: 0.2, y: 1.6) // X
    vm.didTappedGrid(at: tappedLocation)
    tappedLocation = CGPoint(x: 1.2, y: 1.6) // O
    vm.didTappedGrid(at: tappedLocation)
    tappedLocation = CGPoint(x: 0.2, y: 2.6) // X
    vm.didTappedGrid(at: tappedLocation)
    // assert
    XCTAssertEqual(alertMessage.value.string, "X win the game")
    XCTAssertEqual(retryButtonIsVisibleRelay.value, true)
  }
  
  func test_when_a_game_is_finished_then_retry_button_should_clean_the_board() {
    // arrange
    subscribe()
    givenPreparedGrid()
    
    // act
    var tappedLocation = CGPoint(x: 0.2, y: 0.6) // X
    vm.didTappedGrid(at: tappedLocation)
    tappedLocation = CGPoint(x: 1.2, y: 0.6) // O
    vm.didTappedGrid(at: tappedLocation)
    tappedLocation = CGPoint(x: 0.2, y: 1.6) // X
    vm.didTappedGrid(at: tappedLocation)
    tappedLocation = CGPoint(x: 1.2, y: 1.6) // O
    vm.didTappedGrid(at: tappedLocation)
    tappedLocation = CGPoint(x: 0.2, y: 2.6) // X
    vm.didTappedGrid(at: tappedLocation)
    
    var images: [UIImage?] = [
      R.image.game.cross(), R.image.game.circle(), nil,
      R.image.game.cross(), R.image.game.circle(), nil,
      R.image.game.cross(), nil, nil
    ]
    var arrayShouldBe = getImageViewArray(from: images)
    
    for (index, boxImageView) in boxImageViewsRelay.value.enumerated() {
      let testedImageView = arrayShouldBe[index].image
      XCTAssertEqual(boxImageView.image, testedImageView)
    }
    
    vm.resetGame()
    
    // assert
    images = [
      nil, nil, nil,
      nil, nil, nil,
      nil, nil, nil
    ]
    arrayShouldBe = getImageViewArray(from: images)
    
    for (index, boxImageView) in boxImageViewsRelay.value.enumerated() {
      let testedImageView = arrayShouldBe[index].image
      XCTAssertEqual(boxImageView.image, testedImageView)
    }
  }
}

// MARK: - Convenience Methods

extension GameViewModel_Tests {
  
  private func givenPreparedGrid() {
    let gridContainerFrame = CGRect(x: 0, y: 0, width: 3, height: 3)
    vm.setUpBoxFrames(from: gridContainerFrame)
    vm.setUpBoxImageViews()
  }
  
  private func getImageViewArray(from images: [UIImage?]) -> [UIImageView] {
    return images.map { image -> UIImageView in UIImageView(image: image) }
  }
  
  private func subscribe() {
    vm.alertMessage.bind(to: alertMessage).disposed(by: bag)
    
    vm.board.subscribe { event in
      guard let _board = event.element else { return }
      _board.enumerated().forEach { (index, value) in
        if value.isEmpty { return }
        let image = (value == Symbol.cross.rawValue) ? R.image.game.cross() : R.image.game.circle()
        self.vm.boxImageViewsRelay.value[index].image = image
      }
    }.disposed(by: bag)
    
    vm.boxImageViewsRelay.bind(to: boxImageViewsRelay).disposed(by: bag)
    vm.retryButtonIsHidden.bind(to: retryButtonIsVisibleRelay).disposed(by: bag)
  }
}
