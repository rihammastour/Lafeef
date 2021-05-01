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
    
    //Variables
    let instructionData:[String] = ["instructions-reflector","instructions-Stand","lampInstruction"]
   var instructionIndex = 0
    //IBOutlet
    @IBOutlet weak var instructionView: UIView!
    @IBOutlet weak var reflector: UIImageView!
    @IBOutlet weak var nextlOutlet: UIButton!
    @IBOutlet weak var skiplOutlet: UIButton!
    @IBOutlet weak var doneOutlet: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nextlOutlet.layer.cornerRadius =  nextlOutlet.frame.size.height/2
        
        skiplOutlet?.layer.cornerRadius =  skiplOutlet.frame.size.height/2
        
        doneOutlet?.layer.cornerRadius =  skiplOutlet.frame.size.height/2
        
        instructionView.layer.cornerRadius = 30
        reflector.image = UIImage.gif(name: instructionData[instructionIndex])
//        icecream.image = UIImage.gif(name: "Stand")
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
                backgroundImage.image = UIImage(named: "blank-bakery")
                backgroundImage.contentMode = UIView.ContentMode.scaleToFill
                self.view.insertSubview(backgroundImage, at: 0)
                
                view.backgroundColor = UIColor(white: 1, alpha: 0.5)
    }
    
    func showNextInstruction(){
        instructionView.layer.cornerRadius = 30
        reflector.image = UIImage.gif(name: instructionData[instructionIndex])
    }
    
    func changeButton(){
        self.nextlOutlet.isHidden = true
        self.skiplOutlet.isHidden = true
        self.doneOutlet.isHidden = false
    }
    
    @IBAction func nextInstruction(_ sender: Any) {
        instructionIndex+=1
        if instructionIndex < instructionData.count{
            showNextInstruction()
            if instructionIndex == instructionData.count-1{
                changeButton()
            }
        }
    }
    
    @IBAction func skipInstructionsTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func doneTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
