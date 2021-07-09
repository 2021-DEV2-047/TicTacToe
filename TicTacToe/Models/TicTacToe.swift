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
    board[box] = currentSymbol.rawValue
  }
  
  func getBox(_ box: Int) -> String {
    board[box]
  }
}
