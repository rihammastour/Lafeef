//
//  TrainingSectionViewController.swift
//  Lafeef
//
//  Created by Raghad alfuhaid on 21/08/1442 AH.
//

import Foundation
import UIKit
class TrainingSectionViewController: UIViewController {
    
    
    override func viewDidLoad() {
    let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
            backgroundImage.image = UIImage(named: "Training-Background")
            backgroundImage.contentMode = UIView.ContentMode.scaleToFill
            self.view.insertSubview(backgroundImage, at: 0)
            
            view.backgroundColor = UIColor(white: 1, alpha: 0.5)
    }
    
}
