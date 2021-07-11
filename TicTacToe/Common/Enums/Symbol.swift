import Foundation
import UIKit

enum Symbol: String {
  case cross = "X"
  case circle = "O"
  case none
  
  var attributes: [NSAttributedString.Key: Any] {
    switch self {
    case .cross:
      return [.foregroundColor: Colors.blue]
    case .circle:
      return [.foregroundColor: Colors.red]
    case .none:
      return [.foregroundColor: UIColor.black]
    }
  }
}
