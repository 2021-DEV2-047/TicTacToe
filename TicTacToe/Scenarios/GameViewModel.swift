import Foundation
import RxCocoa
import RxSwift

class GameViewModel {
  
  private let ticTacToe = TicTacToe()
  
  private var boxFrames: [CGRect] = []
  
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
  
  func getBox(at index: Int) -> CGRect {
    boxFrames[index]
  }
}
