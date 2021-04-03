//
//  TrainingBoardViewController.swift
//  Lafeef
//
//  Created by Raghad alfuhaid on 20/08/1442 AH.
//

import Foundation
import UIKit
class TrainingBoardViewController: UIViewController {
    @IBOutlet weak var nextlOutlet: UIButton!
    
    @IBOutlet weak var skiplOutlet: UIButton!
    
    @IBOutlet weak var QuestionLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "blank-bakery")
        backgroundImage.contentMode = UIView.ContentMode.scaleToFill
        self.view.insertSubview(backgroundImage, at: 0)
        
        view.backgroundColor = UIColor(white: 1, alpha: 0.5)
        
        nextlOutlet.layer.cornerRadius =  nextlOutlet.frame.size.height/2
        
        skiplOutlet?.layer.cornerRadius =  skiplOutlet.frame.size.height/2
        
        
        // make multiline
        QuestionLabel.numberOfLines = 0
        QuestionLabel.lineBreakMode = .byWordWrapping
        QuestionLabel.frame.size.width = 300
        QuestionLabel.sizeToFit()
    }
    
}
