//
//  GuidanceInstructions.swift
//  Lafeef
//
//  Created by Raghad alfuhaid on 05/08/1442 AH.
//

import Foundation
import Foundation
import UIKit
class GuidanceInstructionsViewController: UIViewController {
    @IBOutlet weak var icecream: UIImageView!
    @IBOutlet weak var instructionView: UIView!
    @IBOutlet weak var nextlOutlet: UIButton!
    @IBOutlet weak var skiplOutlet: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nextlOutlet.layer.cornerRadius =  nextlOutlet.frame.size.height/2
        
        skiplOutlet?.layer.cornerRadius =  skiplOutlet.frame.size.height/2
        
        instructionView.layer.cornerRadius = 30
        icecream.image = UIImage.gif(name: "icecream")
    }
    
    
}
