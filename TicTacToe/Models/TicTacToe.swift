import Foundation

enum Symbol: String {
  case cross = "X"
  case circle = "O"
}

class TicTacToe {
  
  private var currentSymbol: Symbol = .cross
  
  var board: [String] = [
    "", "", "",
    "", "", "",
    "", "", ""
  ]
  
  func addSymbol(toBox box: Int) {
    let selectedBox = board[box]
    if selectedBox.isEmpty {
      board[box] = currentSymbol.rawValue
      currentSymbol = (currentSymbol == .cross) ? .circle : .cross
    }
  }
  
  func getBox(_ box: Int) -> String {
    board[box]
  }
}
