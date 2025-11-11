//
//  CustomSlider.swift
//  ddshoshina@edu.hse.ru
//
//  Created by Диана on 23/09/2025.
//
import UIKit

final class CustomSlider: UIView {
    var valueChanged: ((Double) -> Void)?
    
    var slider = UISlider()
    var titleView = UILabel()
    
    enum Constants {
        
        static let leadingAncestorConstant: CGFloat = 20
        static let topAncestorConstant: CGFloat = 10
        static let bottomAncestorConstant: CGFloat = -10
    }

    
    init(title: String, min: Double, max: Double) {
        super.init(frame: .zero)
        titleView.text = title
        slider.minimumValue = Float(min)
        slider.maximumValue = Float(max)
        slider.addTarget(self, action: #selector(sliderValueChanged), for: .valueChanged)
        configureUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func configureUI() {
        backgroundColor = .white
        translatesAutoresizingMaskIntoConstraints = false
        
        for view in [slider, titleView] {
            addSubview(view)
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            titleView.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleView.topAnchor.constraint(equalTo: topAnchor, constant: Constants.topAncestorConstant),
            titleView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.leadingAncestorConstant),
            
            slider.topAnchor.constraint(equalTo: titleView.bottomAnchor),
            slider.centerXAnchor.constraint(equalTo: centerXAnchor),
            slider.bottomAnchor.constraint(equalTo: bottomAnchor, constant: Constants.bottomAncestorConstant),
            slider.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.leadingAncestorConstant)
        ])
    }
    var currentValue: Float {
            return slider.value
        }
    
    @objc func sliderValueChanged() {
        valueChanged?(Double(slider.value))
    }
}
