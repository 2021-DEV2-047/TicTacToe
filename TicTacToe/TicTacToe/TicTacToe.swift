import Foundation
import RxCocoa
import RxSwift

class TicTacToe {

  private let winningCombinations = [
    [0,1,2], [3,4,5], [6,7,8],
    [0,3,6], [1,4,7], [2,5,8],
    [0,4,8], [2,4,6]
  ]
  
  var board = BehaviorRelay<[String]>(value: [
    "", "", "",
    "", "", "",
    "", "", ""
  ])
  
  private let attributedString = NSAttributedString(string: R.string.ticTacToe.xBegin(), attributes: Symbol.cross.attributes)
  lazy var alertMessage = BehaviorRelay<NSAttributedString>(value: attributedString)
  
  var resetButtonIsHidden = BehaviorRelay<Bool>(value: true)
  
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
      let stringValue = R.string.ticTacToe.cannotPlayOnSamePosition()
      let attributedString = NSAttributedString(string: stringValue, attributes: Symbol.none.attributes)
      alertMessage.accept(attributedString)
      return
    }
    
    var newBoard = board.value
    newBoard[box] = currentSymbol.rawValue
    board.accept(newBoard)
    
    processBoard()
    
    if theGameIsEnded() { return }
    
    currentSymbol = (currentSymbol == .cross) ? .circle : .cross
    
    let stringValue = R.string.ticTacToe.symbolHasToPlay(currentSymbol.rawValue)
    let attributedString = NSAttributedString(string: stringValue, attributes: currentSymbol.attributes)
    alertMessage.accept(attributedString)
  }
  
  func getBox(_ box: Int) -> String {
    board.value[box]
  }
  
  func boardSize() -> Int {
    board.value.count
  }
  
  func resetGame() {
    alertMessage.accept(attributedString)
    var newBoard = board.value
    for (index, _) in newBoard.enumerated() {
      newBoard[index] = ""
    }
    board.accept(newBoard)
    resetButtonIsHidden.accept(true)
    
    currentSymbol = .cross
    winner = nil
    userHasWon = false
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
  
  private func getPlayerCombinations() -> [Int] {
    board.value.enumerated()
      .sorted(by: { $0.offset < $1.offset })
      .compactMap { (index, box) -> Int? in
        (box == currentSymbol.rawValue) ? index : nil
      }
  }
  
  private func verifyIfUserHasWon(from combinations: [Int]) -> Bool {
    var winningArray = [false, false, false]
    
    for winningCombination in winningCombinations {
      for (index, winningNumber) in winningCombination.enumerated() {
        winningArray[index] = combinations.contains(winningNumber)
      }
      
      if winningArray.elementsEqual([true, true, true]) {
        break
      }
    }
    
    return winningArray.elementsEqual([true, true, true])
  }
  
  private func boardIsFilled() -> Bool {
    board.value.first(where: { $0 == "" }) == nil
  }
  
  private func theGameIsEnded() -> Bool {
    guard let winner = winner else { return false }
    let message = getMessage(for: winner)
    alertMessage.accept(message)
    resetButtonIsHidden.accept(false)
    return true
  }
  
  private func getMessage(for winner: Symbol) -> NSAttributedString {
    var stringValue = ""
    
    switch winner {
    case .circle, .cross:
      stringValue = R.string.ticTacToe.symbolWinTheGame(winner.rawValue)
    case .none:
      stringValue = R.string.ticTacToe.draw()
    }
    
    return NSAttributedString(string: stringValue, attributes: winner.attributes)
  }
}
