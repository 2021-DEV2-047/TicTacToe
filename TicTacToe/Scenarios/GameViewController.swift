import UIKit
import RxCocoa
import RxSwift
import SnapKit

class GameViewController: UIViewController {
  
  private let alertLabel = UILabel()
  private let gridContainer = UIView()
  private var separators: [UIView] = []
  private let tapGesture = UITapGestureRecognizer()
  
  private let bag = DisposeBag()
  private let vm = GameViewModel()

  override func viewDidLoad() {
    super.viewDidLoad()
    setUpViews()
    setUpConstraints()
    setUpBindings()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    self.navigationController?.navigationBar.isHidden = true
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    setUpConstraintsForSeparators()
    vm.setUpBoxFrames(from: gridContainer.frame)
    setUpBoxImageViewFrames()
  }
}

// MARK: - Default Methods

extension GameViewController {
  
  private func setUpViews() {
    view.backgroundColor = .white
    
    alertLabel.textAlignment = .center
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
    let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
    gridContainer.addGestureRecognizer(tap)
    
    view.addSubview(gridContainer)
  }
  
  private func setUpConstraints() {
    alertLabel.snp.makeConstraints {
      $0.left.equalToSuperview().offset(16)
      $0.right.equalToSuperview().offset(-16)
      $0.bottom.equalTo(gridContainer.snp.top).offset(-32)
    }
    
    gridContainer.snp.makeConstraints {
      $0.left.right.equalTo(alertLabel)
      $0.height.equalTo(gridContainer.snp.width)
      $0.centerX.centerY.equalToSuperview()
    }
  }
  
  private func setUpBindings() {
    vm.alertMessage.bind(to: alertLabel.rx.text).disposed(by: bag)
    
    vm.board.subscribe { board in
      guard let _board = board.element else { return }
      _board.enumerated().forEach { (index, value) in
        if value == "X" {
          self.vm.boxImageViewsRelay.value[index].image = R.image.game.cross()
        } else if value == "O" {
          self.vm.boxImageViewsRelay.value[index].image = R.image.game.circle()
        }
      }
    }.disposed(by: bag)
  }
  
  @objc
  private func handleTap(_ sender: UITapGestureRecognizer? = nil) {
    guard let point = sender?.location(in: gridContainer) else {
      return
    }
    vm.didTappedGrid(at: point)
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
  
  private func setUpBoxImageViewFrames() {
    vm.setUpBoxImageViews()
    for imageView in vm.boxImageViewsRelay.value {
      gridContainer.addSubview(imageView)
    }
  }
}
