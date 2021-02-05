//
//  SplashAnimationView.swift
//  Lafeef
//
//  Created by Riham Mastour on 18/06/1442 AH.
//

import UIKit
import SwiftyGif

class SplashAnimationView: UIView {
    
    let logoGifImageView = try! UIImageView(gifImage: UIImage(gifName: "splash-animation.gif"), loopCount: 3)

        override init(frame: CGRect) {
            super.init(frame: frame)
            commonInit()
        }

        required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
            commonInit()
        }

        private func commonInit() {
            backgroundColor = UIColor(white: 246.0 / 255.0, alpha: 1)
            addSubview(logoGifImageView)
        }
  
    func pinEdgesToSuperView(to other: UIView) {
        logoGifImageView.translatesAutoresizingMaskIntoConstraints = false
        logoGifImageView.widthAnchor.constraint(equalToConstant: other.bounds.width ).isActive = true
        logoGifImageView.heightAnchor.constraint(equalToConstant: other.bounds.height).isActive = true
        logoGifImageView.centerXAnchor.constraint(equalTo: other.centerXAnchor).isActive = true
        logoGifImageView.centerYAnchor.constraint(equalTo: other.centerYAnchor).isActive = true

    }
    }


