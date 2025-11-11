//
//  WishMakerViewModel.swift
//  ddshoshina@edu.hse.ru
//
//  Created by Диана on 23/09/2025.
//
import UIKit

final class WishMakerViewModel {
    var title: NSAttributedString {
        let text = "Wish Maker"
        let attributed = NSMutableAttributedString(string: text)

        for (i, _) in text.enumerated() {
            let randomHex = getUniqueColor()
            let color = UIColor(hex: randomHex)
            attributed.addAttribute(.foregroundColor, value: color, range: NSRange(location: i, length: 1))
        }

        attributed.addAttribute(.font, value: UIFont.boldSystemFont(ofSize: 32), range: NSRange(location: 0, length: text.count))
        return attributed
    }

    var description: NSAttributedString {
        let text = "This app will bring you joy and will fulfill all of your wishes !!!"
        let attributed = NSMutableAttributedString(string: text)
        attributed.addAttribute(.font, value: UIFont.systemFont(ofSize: 18), range: NSRange(location: 0, length: text.count))
        return attributed
    }
}
