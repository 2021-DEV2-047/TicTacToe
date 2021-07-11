import Foundation

class TicTacToe {

  private let winningCombinations = [
    "0,1,2", "3,4,5", "6,7,8",
    "0,3,6", "1,4,7", "2,5,8",
    "0,4,8", "2,4,7"
  ]
  
  private var board: [String] = [
    "", "", "",
    "", "", "",
    "", "", ""
  ]
  
  private var alertMessage: String = "The X begin."
  
  private var currentSymbol: Symbol = .cross
  private var winner: Symbol? = nil
  private var userHasWon = false
}

// MARK: - Public Methods

extension TicTacToe {
  
  func addSymbol(toBox box: Int) {
    if theGameIsEnded() {
      return
    }
    
    let selectedBox = board[box]
    guard selectedBox.isEmpty else {
      alertMessage = "You cannot play on a played position !"
      return
    }
    
    board[box] = currentSymbol.rawValue
    processBoard()
    
    if theGameIsEnded() {
      return
    }
    
    currentSymbol = (currentSymbol == .cross) ? .circle : .cross
    alertMessage = "\(currentSymbol.rawValue) has to play."
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
    userHasWon = verifyIfUserHasWon(from: playerCombinations)
    
    if userHasWon {
      winner = currentSymbol
    } else if boardIsFilled() {
      winner = Symbol.none
    }
  }
  
  private func getPlayerCombinations() -> String {
    board.enumerated().compactMap { (index, box) -> String? in
      (box == currentSymbol.rawValue) ? String(index) : nil
    }.joined(separator: ",")
  }
  
  private func verifyIfUserHasWon(from combinations: String) -> Bool {
    winningCombinations.first(where: { combinations.contains($0) }) != nil
  }
  
  private func boardIsFilled() -> Bool {
    board.first(where: { $0 == "" }) == nil
  }
  
  private func theGameIsEnded() -> Bool {
    if userHasWon || boardIsFilled() {
      alertMessage = getMessage(for: winner)
      return true
    }
    return false
  }
  
  private func getMessage(for winner: Symbol?) -> String {
    guard let _winner = winner else {
      return "The game is not yet over !"
    }
    switch _winner {
    case .circle, .cross:
      return "\(_winner.rawValue) win the game."
    case .none:
      return "Draw. The game is over, start a new game."
    }
  }
}
