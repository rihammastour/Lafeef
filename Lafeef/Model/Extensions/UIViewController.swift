//
//  UIViewController.swift
//  Lafeef
//
//  Created by Riham Mastour on 11/06/1442 AH.
//

import Foundation
import UIKit

extension UIViewController {

    func setGradientBackground(redTop: CGFloat, greenTop: CGFloat, blueTop: CGFloat,redBottom: CGFloat, greenBottom: CGFloat, blueBottom: CGFloat, type: String) {
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
        gradientLayer.frame = self.view.bounds
                
        self.view.layer.insertSublayer(gradientLayer, at:0)
    }

}
