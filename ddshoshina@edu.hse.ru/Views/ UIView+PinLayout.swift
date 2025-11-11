//
//   UIView+PinLayout.swift
//  ddshoshina@edu.hse.ru
//
//  Created by Диана on 10/11/2025.
//

import UIKit

extension UIView {
    func setHeight(_ height: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: height).isActive = true
    }

    func pinBottom(to view: UIView, _ inset: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        bottomAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.bottomAnchor,
            constant: -inset
        ).isActive = true
    }

    // nail left+right
    func pinHorizontal(to view: UIView, _ inset: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        leadingAnchor.constraint(
            equalTo: view.leadingAnchor,
            constant: inset
        ).isActive = true

        trailingAnchor.constraint(
            equalTo: view.trailingAnchor,
            constant: -inset
        ).isActive = true
    }
    // nail yourself to the edges of another view
    func pin(to view: UIView, _ inset: CGFloat = 0) {
            translatesAutoresizingMaskIntoConstraints = false

            NSLayoutConstraint.activate([
                topAnchor.constraint(
                    equalTo: view.safeAreaLayoutGuide.topAnchor,
                    constant: inset
                ),
                leadingAnchor.constraint(
                    equalTo: view.safeAreaLayoutGuide.leadingAnchor,
                    constant: inset
                ),
                trailingAnchor.constraint(
                    equalTo: view.safeAreaLayoutGuide.trailingAnchor,
                    constant: -inset
                ),
                bottomAnchor.constraint(
                    equalTo: view.safeAreaLayoutGuide.bottomAnchor,
                    constant: -inset
                )
            ])
        }
    // nail the top+bottom
    func pinVertical(to view: UIView, _ inset: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        topAnchor.constraint(
            equalTo: view.topAnchor,
            constant: inset
        ).isActive = true
        
        bottomAnchor.constraint(
            equalTo: view.bottomAnchor,
            constant: -inset
        ).isActive = true
    }
    // press the top to the specified view
    func pinTop(to view: UIView, _ inset: CGFloat = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        topAnchor.constraint(
            equalTo: view.topAnchor,
            constant: inset
        ).isActive = true
    }

    // press down the left edge
    func pinLeading(to view: UIView, _ inset: CGFloat = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        leadingAnchor.constraint(
            equalTo: view.leadingAnchor,
            constant: inset
        ).isActive = true
    }

    // press down the right edge
    func pinTrailing(to view: UIView, _ inset: CGFloat = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        trailingAnchor.constraint(
            equalTo: view.trailingAnchor,
            constant: -inset
        ).isActive = true
    }

    // view under another view
    func pinBelow(_ otherView: UIView, _ spacing: CGFloat = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        topAnchor.constraint(
            equalTo: otherView.bottomAnchor,
            constant: spacing
        ).isActive = true
    }
}

