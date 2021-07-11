import Foundation
import UIKit

enum Symbol: String {
  case cross = "X"
  case circle = "O"
  case none
  
  var attributes: [NSAttributedString.Key: Any] {
    switch self {
    case .cross:
      return [.foregroundColor: Colors.blue, .font: UIFont.systemFont(ofSize: 17, weight: .bold)]
    case .circle:
      return [.foregroundColor: Colors.red, .font: UIFont.systemFont(ofSize: 17, weight: .bold)]
    case .none:
      return [.foregroundColor: UIColor.black, .font: UIFont.systemFont(ofSize: 17, weight: .bold)]
    }
  }
}
