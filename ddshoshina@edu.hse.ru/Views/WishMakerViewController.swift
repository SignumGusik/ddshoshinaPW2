//
//  WishMakerViewController.swift
//  ddshoshina@edu.hse.ru
//
//  Created by Диана on 23/09/2025.
//
import UIKit

// main screen
final class WishMakerViewController: UIViewController {
    private let viewModel = WishMakerViewModel()
    let stack = UIStackView()
    var toggleButton = UIButton()
    private let addWishButton: UIButton = UIButton(type: .system)

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }

    private func configureUI() {
        view.backgroundColor = .black
        configureTitle()
        configureDescription()
        configureaddWishButton()
        configureSliders()
        configureToggleButton()
    }
    
    enum Constants {
        static let sliderMin: Double = 0
        static let sliderMax: Double = 255
        
        static let titleTopAncestorConstant: CGFloat = 30
        static let leadingAncestorConstant: CGFloat = 20
        static let descriptionTopAncestorConstant: CGFloat = 80
        static let sliderBottomAncestorConstant: CGFloat = -40
        
        static let alpha: Double = 1.0
        
        static let cornerRadius: CGFloat = 20
        static let numberOfLines: Int = 0
        
        static let buttonHeight: CGFloat = 44
        static let buttonBottom: CGFloat = 20
        static let buttonSide: CGFloat = 100
        static let buttonText: String = "Добавить желание"
        static let buttonRadius: CGFloat = 10
    }

    private func configureTitle() {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.attributedText = viewModel.title
        title.textAlignment = .center

        view.addSubview(title)
        NSLayoutConstraint.activate([
            title.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            title.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Constants.titleTopAncestorConstant),
            title.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.leadingAncestorConstant)
        ])
    }

    private func configureDescription() {
        let description = UILabel()
        description.translatesAutoresizingMaskIntoConstraints = false
        description.attributedText = viewModel.description
        description.textAlignment = .center
        description.numberOfLines = Constants.numberOfLines //перенос строк

        view.addSubview(description)
        NSLayoutConstraint.activate([
            description.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            description.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Constants.descriptionTopAncestorConstant),
            description.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.leadingAncestorConstant)
        ])
    }
    
    private func configureSliders() {
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        view.addSubview(stack)
        stack.layer.cornerRadius = CGFloat(Constants.cornerRadius)
        stack.clipsToBounds = true
        stack.isHidden = true
        
        let sliderRed = CustomSlider(title: "Red", min: Constants.sliderMin, max: Constants.sliderMax)
        let sliderBlue = CustomSlider(title: "Blue", min: Constants.sliderMin, max: Constants.sliderMax)
        let sliderGreen = CustomSlider(title: "Green", min: Constants.sliderMin, max: Constants.sliderMax)
        
        for slider in [sliderRed, sliderBlue, sliderGreen] {
            stack.addArrangedSubview(slider)
        }
        NSLayoutConstraint.activate([
            stack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.leadingAncestorConstant),
            stack.bottomAnchor.constraint(equalTo: addWishButton.topAnchor, constant: Constants.sliderBottomAncestorConstant)
        ])
        sliderRed.valueChanged = { [weak self] value in
            self?.view.backgroundColor = UIColor(hex: getUniqueColor())
        }
        let updateColor: () -> Void = { [weak self] in
                guard let self = self else { return }
            let r = CGFloat(sliderRed.currentValue) / Constants.sliderMax
            let g = CGFloat(sliderGreen.currentValue) / Constants.sliderMax
            let b = CGFloat(sliderBlue.currentValue) / Constants.sliderMax
            self.view.backgroundColor = UIColor(red: r, green: g, blue: b, alpha: Constants.alpha)
            }
            
            sliderRed.valueChanged = { _ in updateColor() }
            sliderGreen.valueChanged = { _ in updateColor() }
            sliderBlue.valueChanged = { _ in updateColor() }
    }
    private func configureToggleButton() {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Show", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 18)
        button.addTarget(self, action: #selector(toggleSliders), for: .touchUpInside)
        
        view.addSubview(button)
        toggleButton = button
        NSLayoutConstraint.activate([
            button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            button.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20)
        ])
    }
    @objc private func toggleSliders() {
        let shouldShow = stack.isHidden
            
            UIView.animate(withDuration: 0.1) {
                self.stack.isHidden = !shouldShow
            }
            
            toggleButton.setTitle(shouldShow ? "Hide" : "Show", for: .normal)
    }
    private func configureaddWishButton() {
        view.addSubview(addWishButton)
        addWishButton.setHeight(Constants.buttonHeight)
        addWishButton.pinBottom(to: view, Constants.buttonBottom)
        addWishButton.pinHorizontal(to: view, Constants.buttonSide)
        
        addWishButton.backgroundColor = .white
        addWishButton.setTitleColor(.systemPink, for: .normal)
        addWishButton.setTitle(Constants.buttonText, for: .normal)
        
        addWishButton.layer.cornerRadius = Constants.buttonRadius
        addWishButton.addTarget(self, action: #selector(addWishButtonPressed), for: .touchUpInside)
        
    }
    @objc
    private func addWishButtonPressed() {
        present(WishStoringViewController(), animated: true)
    }
    

}

