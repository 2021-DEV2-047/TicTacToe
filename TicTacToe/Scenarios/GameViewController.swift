import UIKit
import SnapKit

class GameViewController: UIViewController {
  
  private let alertLabel = UILabel()
  private let gridContainer = UIView()
  private var separators: [UIView] = []
  private let tapGesture = UITapGestureRecognizer()
  
  let vm = GameViewModel()

  override func viewDidLoad() {
    super.viewDidLoad()
    setUpViews()
    setUpConstraints()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    self.navigationController?.navigationBar.isHidden = true
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    setUpConstraintsForSeparators()
  }
}

// MARK: - Default Methods

extension GameViewController {
  
  private func setUpViews() {
    view.backgroundColor = .white
    
    view.addSubview(alertLabel)
    
    for _ in 1...4 {
      separators.append(UIView())
    }
    for separator in separators {
      separator.backgroundColor = .black
      gridContainer.addSubview(separator)
    }
    gridContainer.layer.cornerRadius = 8
    gridContainer.layer.borderWidth = 1
    gridContainer.layer.borderColor = UIColor.black.cgColor
    gridContainer.addGestureRecognizer(tapGesture)
    view.addSubview(gridContainer)
  }
  
  private func setUpConstraints() {
    alertLabel.snp.makeConstraints {
      $0.top.equalTo(view.safeAreaLayoutGuide).offset(16)
      $0.left.equalToSuperview().offset(16)
      $0.right.equalToSuperview().offset(-16)
    }
    
    gridContainer.snp.makeConstraints {
      $0.width.equalTo(UIScreen.main.bounds.width - 32)
      $0.height.equalTo(gridContainer.snp.width)
      $0.centerX.centerY.equalToSuperview()
    }
  }
}

// MARK: - Convenience Methods

extension GameViewController {
  
  private func setUpConstraintsForSeparators() {
    let gridWidth = gridContainer.frame.width
    let gridHeight = gridContainer.frame.height
    
    for (index, separator) in separators.enumerated() {
      switch index {
      case 0, 1:
        separator.snp.makeConstraints {
          $0.width.equalTo(1)
          $0.top.bottom.equalToSuperview()
          if index == 0 {
            $0.left.equalToSuperview().offset(gridWidth / 3)
          } else {
            $0.right.equalToSuperview().offset(-(gridWidth / 3))
          }
        }
      case 2, 3:
        separator.snp.makeConstraints {
          $0.height.equalTo(1)
          $0.left.right.equalToSuperview()
          if index == 2 {
            $0.top.equalToSuperview().offset(gridHeight / 3)
          } else {
            $0.bottom.equalToSuperview().offset(-(gridHeight / 3))
          }
        }
      default:
        break
      }
    }
  }
}
