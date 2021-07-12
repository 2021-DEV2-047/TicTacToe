import UIKit
import RxCocoa
import RxSwift
import SnapKit

class GameViewController: UIViewController {
  
  private let alertContainer = UIView()
  private let alertLabel = UILabel()
  private let gridContainer = UIView()
  private var separators: [UIView] = []
  private let tapGesture = UITapGestureRecognizer()
  private let buttonContainer = UIView()
  private let resetButton = UIButton()
  
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
    
    resetButton.layer.cornerRadius = resetButton.frame.height / 2
  }
}

// MARK: - Default Methods

extension GameViewController {
  
  private func setUpViews() {
    view.backgroundColor = Colors.lightGray
    
    alertLabel.numberOfLines = 0
    alertLabel.textAlignment = .center
    alertContainer.addSubview(alertLabel)
    view.addSubview(alertContainer)
    
    for _ in 1...4 {
      separators.append(UIView())
    }
    for separator in separators {
      separator.backgroundColor = .black
      gridContainer.addSubview(separator)
    }
    
    gridContainer.layer.borderWidth = 1
    gridContainer.layer.borderColor = UIColor.black.cgColor
    view.addSubview(gridContainer)
    
    let attributedString = NSAttributedString(
      string: R.string.ticTacToe.retry(),
      attributes: [.foregroundColor: UIColor.white, .font: Fonts.defaultBoldFont]
    )
    resetButton.backgroundColor = Colors.red
    resetButton.setAttributedTitle(attributedString, for: .normal)
    buttonContainer.addSubview(resetButton)
    view.addSubview(buttonContainer)
  }
  
  private func setUpConstraints() {
    alertContainer.snp.makeConstraints {
      $0.top.equalTo(view.safeAreaLayoutGuide)
      $0.left.right.equalToSuperview()
      $0.bottom.equalTo(gridContainer.snp.top)
    }
    
    alertLabel.snp.makeConstraints {
      $0.left.equalToSuperview().offset(16)
      $0.right.equalToSuperview().offset(-16)
      $0.centerY.equalToSuperview()
    }
    
    gridContainer.snp.makeConstraints {
      $0.left.right.equalTo(alertLabel)
      $0.height.equalTo(gridContainer.snp.width)
      $0.centerX.centerY.equalToSuperview()
    }
    
    buttonContainer.snp.makeConstraints {
      $0.top.equalTo(gridContainer.snp.bottom)
      $0.left.right.equalToSuperview()
      $0.bottom.equalTo(view.safeAreaLayoutGuide)
    }
    
    resetButton.snp.makeConstraints {
      $0.width.equalToSuperview().dividedBy(3)
      $0.height.equalTo(45)
      $0.centerY.centerX.equalToSuperview()
    }
  }
  
  private func setUpBindings() {
    vm.alertMessage.bind(to: alertLabel.rx.attributedText).disposed(by: bag)
    
    vm.board.skip(1).subscribe { event in
      guard let _board = event.element else { return }
      _board.enumerated().forEach { (index, value) in
        if value.isEmpty { return }
        let image = (value == Symbol.cross.rawValue) ? R.image.game.cross() : R.image.game.circle()
        self.vm.boxImageViewsRelay.value[index].image = image
      }
    }.disposed(by: bag)
    
    let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
    gridContainer.addGestureRecognizer(tap)
    
    resetButton.addTarget(self, action: #selector(resetGame), for: .touchUpInside)
    vm.retryButtonIsHidden.bind(to: resetButton.rx.isHidden).disposed(by: bag)
  }
}

// MARK: - Convenience Methods

extension GameViewController {
  
  @objc
  private func handleTap(_ sender: UITapGestureRecognizer? = nil) {
    guard let point = sender?.location(in: gridContainer) else { return }
    vm.didTappedGrid(at: point)
  }
  
  @objc
  private func resetGame() {
    removeImageViewsFromSuperview()
    vm.resetGame()
  }
  
  private func setUpConstraintsForSeparators() {
    let gridWidth = gridContainer.frame.width
    let gridHeight = gridContainer.frame.height
    
    for (index, separator) in separators.enumerated() {
      if (index == 0 || index == 1) {
        separator.snp.makeConstraints {
          $0.width.equalTo(1)
          $0.top.bottom.equalToSuperview()
          if index == 0 {
            $0.left.equalToSuperview().offset(gridWidth / 3)
          } else {
            $0.right.equalToSuperview().offset(-(gridWidth / 3))
          }
        }
      }
      if (index == 2 || index == 3) {
        separator.snp.makeConstraints {
          $0.height.equalTo(1)
          $0.left.right.equalToSuperview()
          if index == 2 {
            $0.top.equalToSuperview().offset(gridHeight / 3)
          } else {
            $0.bottom.equalToSuperview().offset(-(gridHeight / 3))
          }
        }
      }
    }
  }
  
  private func setUpBoxImageViewFrames() {
    vm.setUpBoxImageViews()
    for imageView in vm.boxImageViewsRelay.value {
      gridContainer.addSubview(imageView)
    }
  }
  
  private func removeImageViewsFromSuperview() {
    for subview in gridContainer.subviews {
      if let imageView = subview as? UIImageView {
        let imageIsACross = imageView.image == R.image.game.cross()
        let imageIsACircle = imageView.image == R.image.game.circle()
        
        if imageIsACross || imageIsACircle {
          subview.removeFromSuperview()
        }
      }
    }
  }
}
