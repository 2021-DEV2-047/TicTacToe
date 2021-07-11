import Foundation
import RxCocoa
import RxSwift

class GameViewModel {
  
  private let ticTacToe = TicTacToe()
  
  var alertMessage: Observable<String> { ticTacToe.alertMessage.asObservable() }
}
