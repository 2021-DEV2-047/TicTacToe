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
    
    let firstBox = CGRect(x: 0, y: 0, width: boxWidth, height: boxHeight)
    let secondBox = CGRect(x: boxWidth, y: 0, width: boxWidth, height: boxHeight)
    let thirdBox = CGRect(x: boxWidth * 2, y: 0, width: boxWidth, height: boxHeight)
    
    let fourthBox = CGRect(x: 0, y: boxHeight, width: boxWidth, height: boxHeight)
    let fifthBox = CGRect(x: boxWidth, y: boxHeight, width: boxWidth, height: boxHeight)
    let sixthBox = CGRect(x: boxWidth * 2, y: boxHeight, width: boxWidth, height: boxHeight)
    
    let seventhBox = CGRect(x: 0, y: boxHeight * 2, width: boxWidth, height: boxHeight)
    let eighthBox = CGRect(x: boxWidth, y: boxHeight * 2, width: boxWidth, height: boxHeight)
    let ninthBox = CGRect(x: boxWidth * 2, y: boxHeight * 2, width: boxWidth, height: boxHeight)
    
    
    [firstBox, secondBox, thirdBox,
     fourthBox, fifthBox, sixthBox,
     seventhBox, eighthBox, ninthBox].forEach {
      boxFrames.append($0)
    }
  }
  
  func getBox(at index: Int) -> CGRect {
    boxFrames[index]
  }
}
