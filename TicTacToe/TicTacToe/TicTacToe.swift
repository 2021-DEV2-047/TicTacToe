import Foundation

class TicTacToe {
  
  private var currentSymbol: Symbol = .cross
  private var winner: Symbol? = nil
  private var userHasWinned = false
  
  private var alertMessage: String = ""
  
  private var board: [String] = [
    "", "", "",
    "", "", "",
    "", "", ""
  ]
  
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
}

// MARK: - Public Methods

extension TicTacToe {
  
  func addSymbol(toBox box: Int) {
    let selectedBox = board[box]
    if selectedBox.isEmpty && !userHasWinned {
      board[box] = currentSymbol.rawValue
      processBoard()
      currentSymbol = (currentSymbol == .cross) ? .circle : .cross
    } else {
      alertMessage = "You cannot play on a played position !"
    }
  }
  
  func getBox(_ box: Int) -> String {
    board[box]
  }
  
  func boardSize() -> Int {
    board.count
  }
  
  func getAlertMessage() -> String {
    alertMessage
  }
}

// MARK: - Convenience Methods

extension TicTacToe {
  
  private func processBoard() {
    let playerCombinations = getPlayerCombinations()
    userHasWinned = verify(playerCombinations)
    
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
