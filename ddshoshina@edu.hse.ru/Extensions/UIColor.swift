//
//  UIColor.swift
//  ddshoshina@edu.hse.ru
//
//  Created by Диана on 23/09/2025.
//
import UIKit

// new inisializer for UIColor that create color from hex string
extension UIColor {
    convenience init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet(charactersIn: "#"))
        var rgbValue: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&rgbValue) // converts hex string to rgb number

        let redMask: UInt64 = 0xFF0000
        let greenMask: UInt64 = 0x00FF00
        let blueMask: UInt64 = 0x0000FF

        let redShift = 16
        let greenShift = 8
        let blueShift = 0

        let maxColorValue = 255.0

        let r = Double((rgbValue & redMask) >> redShift) / maxColorValue
        let g = Double((rgbValue & greenMask) >> greenShift) / maxColorValue
        let b = Double((rgbValue & blueMask) >> blueShift) / maxColorValue

        // calling standart UIColor inisializer
        self.init(red: r, green: g, blue: b, alpha: 1.0)
    }
}

// creating hex string with random color
func getUniqueColor() -> String {
    let hexAlphabit = "1234567890ABCDEF"
    var hexString = ""
        for _ in 0..<6 {
            let randomIndex = Int(arc4random_uniform(UInt32(hexAlphabit.count)))
            let randomChar = hexAlphabit[hexAlphabit.index(hexAlphabit.startIndex, offsetBy: randomIndex)]
            hexString.append(randomChar)
        }
        return hexString
}
