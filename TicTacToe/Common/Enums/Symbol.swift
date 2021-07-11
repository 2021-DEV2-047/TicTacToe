import Foundation
import UIKit

enum Symbol: String {
  case cross = "X"
  case circle = "O"
  case none
  
  var attributes: [NSAttributedString.Key: Any] {
    switch self {
    case .cross:
      return [.foregroundColor: Colors.blue, .font: Fonts.defaultBoldFont]
    case .circle:
      return [.foregroundColor: Colors.red, .font: Fonts.defaultBoldFont]
    case .none:
      return [.foregroundColor: UIColor.black, .font: Fonts.defaultBoldFont]
    }
  }
}
