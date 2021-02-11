//
//  stopGameViewController.swift
//  Lafeef
//
//  Created by Raghad alfuhaid on 29/06/1442 AH.
//

import Foundation
import UIKit
class StopGameViewController: UIViewController{
    
 
 
    @IBOutlet weak var pauseView: UIView!
    @IBOutlet weak var viewInstructionOutlet: UIButton!
    @IBOutlet weak var exitOutlet: UIButton!
    @IBOutlet weak var continueOutlet: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        pauseView.layer.cornerRadius = 40
        pauseView.backgroundColor=UIColor(hue: 0.1389, saturation: 0.02, brightness: 0.98, alpha: 1.0)
        viewInstructionOutlet.layer.cornerRadius = viewInstructionOutlet.frame.size.height/2
        exitOutlet.layer.cornerRadius = exitOutlet.frame.size.height/2
        continueOutlet.layer.cornerRadius = continueOutlet.frame.size.height/2
        
    
    }
    

    @IBAction func gameContinue(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func viewInstruction(_ sender: Any) {
        
    }
    @IBAction func exitGame(_ sender: Any) {
    }

    
}
