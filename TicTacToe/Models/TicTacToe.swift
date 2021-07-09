import Foundation

enum Symbol: String {
  case cross = "X"
  case circle = "O"
}

class TicTacToe {
  
  private var winner: Symbol? = nil
  private var currentSymbol: Symbol = .cross
  
  var winnerMessage: String {
    get {
      winner != nil ? "\(winner!.rawValue) win the game" : ""
    }
  }
  
  var board: [String] = [
    "", "", "",
    "", "", "",
    "", "", ""
  ]
  
  func addSymbol(toBox box: Int) {
    let selectedBox = board[box]
    if selectedBox.isEmpty && (winner == nil) {
      board[box] = currentSymbol.rawValue
      processBoard()
      currentSymbol = (currentSymbol == .cross) ? .circle : .cross
    }
  }
  
  func getBox(_ box: Int) -> String {
    board[box]
  }
}

// MARK: - Convenience Methods

extension TicTacToe {
  
  private func processBoard() {
    var _currentSymbol: Symbol? = nil
    
    var currentSymbolBoxes: [String] = []
    board.enumerated().forEach { (index, box) in
      if (box == currentSymbol.rawValue) {
        let indexString = String(index)
        currentSymbolBoxes.append(indexString)
      }
    }
    
    let stringArray = currentSymbolBoxes.joined(separator: ",")
    let winningCombinations = [
      "0,1,2", "3,4,5", "6,7,8",
      "0,3,6", "1,4,7", "2,5,8",
      "0,4,8", "2,4,7"
    ]
    winningCombinations.forEach { (winningCombination) in
      if (stringArray.contains(winningCombination)) {
        _currentSymbol = currentSymbol
        return
      }
    }
    
    winner = _currentSymbol
  }
}
