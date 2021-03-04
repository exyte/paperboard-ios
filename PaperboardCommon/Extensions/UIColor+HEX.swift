//
//  UIColor+HEX.swift
//  Paperboard
//
//  Created by Igor Zapletnev on 04.03.2021.
//  Copyright © 2021 Exyte. All rights reserved.
//
import UIKit

extension UIColor {
    convenience init(hex: String, alpha: CGFloat = 1.0) {
            let hexString: String = hex.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
            let scanner = Scanner(string: hexString)
            if (hexString.hasPrefix("#")) {
                scanner.scanLocation = 1
            }
            var color: UInt32 = 0
            scanner.scanHexInt32(&color)
            let mask = 0x000000FF
            let r = Int(color >> 16) & mask
            let g = Int(color >> 8) & mask
            let b = Int(color) & mask
            let red   = CGFloat(r) / 255.0
            let green = CGFloat(g) / 255.0
            let blue  = CGFloat(b) / 255.0
            self.init(red:red, green:green, blue:blue, alpha:alpha)
        }
}
