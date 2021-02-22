//
//  UIViewController.swift
//  Lafeef
//
//  Created by Riham Mastour on 11/06/1442 AH.
//

import Foundation
import UIKit

extension UIView {

    //MARK: - GradientBackground
    
    func setGradientBackground(redTop: CGFloat, greenTop: CGFloat, blueTop: CGFloat,redBottom: CGFloat, greenBottom: CGFloat, blueBottom: CGFloat, type: String, isFirstTimeInserting: Bool) {
        let colorTop =  UIColor(red: redTop, green:greenTop, blue: blueTop, alpha: 1.0).cgColor
        let colorBottom = UIColor(red: redBottom, green: greenBottom, blue: blueBottom, alpha: 1.0).cgColor
                    
        let gradientLayer = CAGradientLayer()

        switch type {
        case "radial":
            gradientLayer.type = .radial
        default:
            gradientLayer.type = .axial
        }
        
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.startPoint = CGPoint(x:0.5, y:0.5)
        gradientLayer.endPoint = CGPoint(x:1, y:1)
        gradientLayer.locations = [0.0, 1]
        gradientLayer.frame = self.bounds
        
        if isFirstTimeInserting {
            self.layer.insertSublayer(gradientLayer, at: 0)
           }
           else
           {
            if self.layer.sublayers!.count >= 1 {
                self.layer.insertSublayer(gradientLayer, at: UInt32((self.layer.sublayers!.count - 2)))
               }
           }
    }
}

extension String {
    private static let formatter = NumberFormatter()

    func clippingCharacters(in characterSet: CharacterSet) -> String {
        components(separatedBy: characterSet).joined()
    }

    func convertedDigitsToLocale(_ locale: Locale = .current) -> String {
        let digits = Set(clippingCharacters(in: CharacterSet.decimalDigits.inverted))
        guard !digits.isEmpty else { return self }

        Self.formatter.locale = locale
        let maps: [(original: String, converted: String)] = digits.map {
            let original = String($0)
            guard let digit = Self.formatter.number(from: String($0)) else {
                assertionFailure("Can not convert to number from: \(original)")
                return (original, original)
            }
            guard let localized = Self.formatter.string(from: digit) else {
                assertionFailure("Can not convert to string from: \(digit)")
                return (original, original)
            }
            return (original, localized)
        }

        var converted = self
        for map in maps { converted = converted.replacingOccurrences(of: map.original, with: map.converted) }
        return converted
    }
}
