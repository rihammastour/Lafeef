
//
//  GuidanceInstructions.swift
//  Lafeef
//
//  Created by Raghad alfuhaid on 05/08/1442 AH.
//

import Foundation
import Foundation
import UIKit
class GuidanceInstructionsViewController2: UIViewController {
  
    @IBOutlet weak var stand: UIImageView!
    @IBOutlet weak var nextlOutlet: UIButton!
    
    @IBOutlet weak var instructionView: UIView!
    
    
    @IBOutlet weak var skiplOutlet: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nextlOutlet.layer.cornerRadius =  nextlOutlet.frame.size.height/2
        
        skiplOutlet?.layer.cornerRadius =  skiplOutlet.frame.size.height/2
        
        instructionView.layer.cornerRadius = 30
        stand.image = UIImage.gif(name: "instructions-Stand")
//        icecream.image = UIImage.gif(name: "Stand")
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
                backgroundImage.image = UIImage(named: "blank-bakery")
                backgroundImage.contentMode = UIView.ContentMode.scaleToFill
                self.view.insertSubview(backgroundImage, at: 0)
                
                view.backgroundColor = UIColor(white: 1, alpha: 0.5)
    }
    
    
}
