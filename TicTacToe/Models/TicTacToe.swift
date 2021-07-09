import Foundation

enum Symbol: String {
  case cross = "X"
  case circle = "O"
  case nobody
}

class TicTacToe {
  
  private var winner: Symbol? = nil
  private var currentSymbol: Symbol = .cross
  
  var winnerMessage: String {
    get {
      guard let _winner = winner else {
        return ""
      }
      switch _winner {
      case .cross, .circle:
        return "\(_winner.rawValue) win the game"
      case .nobody:
        return "Draw"
      }
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
    let playerCombinations = getPlayerCombinations()
    let userHasWinned = verify(playerCombinations)
    
    if userHasWinned {
      winner = currentSymbol
    } else if gameIsEnded() {
      winner = .nobody
    }
  }
  
  private func getPlayerCombinations() -> String {
    var currentSymbolBoxes: [String] = []
    board.enumerated().forEach { (index, box) in
      if (box == currentSymbol.rawValue) {
        let indexString = String(index)
        currentSymbolBoxes.append(indexString)
      }
    }
    return currentSymbolBoxes.joined(separator: ",")
  }
  
  private func verify(_ combinations: String) -> Bool {
    var userWin = false
    
    let winningCombinations = [
      "0,1,2", "3,4,5", "6,7,8",
      "0,3,6", "1,4,7", "2,5,8",
      "0,4,8", "2,4,7"
    ]
    winningCombinations.forEach { (winningCombination) in
      if (combinations.contains(winningCombination)) {
        userWin = true
        return
      }
    }
    
    return userWin
  }
  
  private func gameIsEnded() -> Bool {
    var gameIsEnded = true
    
    board.forEach { box in
      if box == "" {
        gameIsEnded = false
        return
      }
    }
    
    return gameIsEnded
  }
}
