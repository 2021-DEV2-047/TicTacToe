import Foundation
import RxCocoa
import RxSwift
import UIKit

class GameViewModel {
  
  private let ticTacToe = TicTacToe()
  
  private var boxFrames: [CGRect] = []
  
  var boxImageViewsRelay = BehaviorRelay<[UIImageView]>(value: [])
  
  var board: Observable<[String]> { ticTacToe.board.asObservable() }
  var alertMessage: Observable<String> { ticTacToe.alertMessage.asObservable() }
}

// MARK: - Convenience Methods

extension GameViewModel {
  
  func setUpBoxFrames(from frame: CGRect) {
    let boxWidth = frame.width / 3
    let boxHeight = frame.height / 3
    let ordinates = [0, boxHeight, boxHeight * 2]
    let abscissas = [0, boxWidth, boxWidth * 2]
    
    ordinates.forEach { y in
      abscissas.forEach { x in
        let boxFrame = CGRect(x: x, y: y, width: boxWidth, height: boxHeight)
        boxFrames.append(boxFrame)
      }
    }
  }
  
  func setUpBoxImageViews() {
    var _boxImageViews: [UIImageView] = []
    
    for i in 0...8 {
      let boxFrame = getBoxFrame(at: i)
      let imageView = UIImageView()
      imageView.frame = boxFrame
      _boxImageViews.append(imageView)
    }
    
    boxImageViewsRelay.accept(_boxImageViews)
  }
  
  func getBoxFrame(at index: Int) -> CGRect {
    boxFrames[index]
  }
  
  func didTappedGrid(at location: CGPoint) {
    let index = boxFrames.enumerated().first(where: { $1.contains(location) }).map { $0.offset }
    guard let _index = index else { return }
    ticTacToe.addSymbol(toBox: _index)
  }
}
