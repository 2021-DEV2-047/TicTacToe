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
    let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
    gridContainer.addGestureRecognizer(tap)
    
    view.addSubview(gridContainer)
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
  }
  
  private func setUpBindings() {
    vm.alertMessage.bind(to: alertLabel.rx.attributedText).disposed(by: bag)
    
    vm.board.subscribe { event in
      guard let _board = event.element else { return }
      _board.enumerated().forEach { (index, value) in
        if value.isEmpty { return }
        let image = (value == Symbol.cross.rawValue) ? R.image.game.cross() : R.image.game.circle()
        self.vm.boxImageViewsRelay.value[index].image = image
      }
    }.disposed(by: bag)
  }
  
  @objc
  private func handleTap(_ sender: UITapGestureRecognizer? = nil) {
    guard let point = sender?.location(in: gridContainer) else { return }
    vm.didTappedGrid(at: point)
  }
}

// MARK: - Convenience Methods

extension GameViewController {
  
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
}
