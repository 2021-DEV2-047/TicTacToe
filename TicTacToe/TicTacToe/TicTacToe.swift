import Foundation
import RxCocoa
import RxSwift

class TicTacToe {

  private let winningCombinations = [
    "0,1,2", "3,4,5", "6,7,8",
    "0,3,6", "1,4,7", "2,5,8",
    "0,4,8", "2,4,6"
  ]
  
  var board = BehaviorRelay<[String]>(value: [
    "", "", "",
    "", "", "",
    "", "", ""
  ])
  
  var alertMessage = BehaviorRelay<String>(value: R.string.ticTacToe.xBegin())
  
  private var currentSymbol: Symbol = .cross
  private var winner: Symbol? = nil
  private var userHasWon = false
}

// MARK: - Public Methods

extension TicTacToe {
  
  func addSymbol(toBox box: Int) {
    if theGameIsEnded() { return }
    
    let selectedBox = board.value[box]
    guard selectedBox.isEmpty else {
      alertMessage.accept(R.string.ticTacToe.cannotPlayOnSamePosition())
      return
    }
    
    var newBoard = board.value
    newBoard[box] = currentSymbol.rawValue
    board.accept(newBoard)
    
    processBoard()
    
    if theGameIsEnded() { return }
    
    currentSymbol = (currentSymbol == .cross) ? .circle : .cross
    alertMessage.accept(R.string.ticTacToe.symbolHasToPlay(currentSymbol.rawValue))
  }
  
  func getBox(_ box: Int) -> String {
    board.value[box]
  }
  
  func boardSize() -> Int {
    board.value.count
  }
}

// MARK: - Convenience Methods

extension TicTacToe {
  
  private func processBoard() {
    let playerCombinations = getPlayerCombinations()
    userHasWon = verifyIfUserHasWon(from: playerCombinations)
    
    if userHasWon {
      winner = currentSymbol
    } else if boardIsFilled() {
      winner = Symbol.none
    }
  }
  
  private func getPlayerCombinations() -> String {
    board.value.enumerated().compactMap { (index, box) -> String? in
      (box == currentSymbol.rawValue) ? String(index) : nil
    }.joined(separator: ",")
  }
  
  private func verifyIfUserHasWon(from combinations: String) -> Bool {
    winningCombinations.first(where: { combinations.contains($0) }) != nil
  }
  
  private func boardIsFilled() -> Bool {
    board.value.first(where: { $0 == "" }) == nil
  }
  
  private func theGameIsEnded() -> Bool {
    guard let winner = winner else { return false }
    let message = getMessage(for: winner)
    alertMessage.accept(message)
    return true
  }
  
  private func getMessage(for winner: Symbol) -> String {
    switch winner {
    case .circle, .cross:
      return R.string.ticTacToe.symbolWinTheGame(winner.rawValue)
    case .none:
      return R.string.ticTacToe.draw()
    }
  }
}
