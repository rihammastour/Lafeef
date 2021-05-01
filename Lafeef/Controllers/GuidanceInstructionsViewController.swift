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
    @IBOutlet weak var doneOutlet: UIButton!
    @IBOutlet weak var backOutlet: UIButton!
    @IBOutlet weak var instructionNumLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nextlOutlet.layer.cornerRadius =  nextlOutlet.frame.size.height/2
        
        backOutlet?.layer.cornerRadius =  backOutlet.frame.size.height/2
        
        doneOutlet?.layer.cornerRadius =  doneOutlet.frame.size.height/2
        
        showInstruction()
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
                backgroundImage.image = UIImage(named: "blank-bakery")
                backgroundImage.contentMode = UIView.ContentMode.scaleToFill
                self.view.insertSubview(backgroundImage, at: 0)
                
                view.backgroundColor = UIColor(white: 1, alpha: 0.5)
    }
    
    func showInstruction(){
        instructionView.layer.cornerRadius = 30
        reflector.image = UIImage.gif(name: instructionData[instructionIndex])
        updatLabel()
    }
    
    func lastInstructionButtons(){
        self.nextlOutlet.isHidden = true
        self.doneOutlet.isHidden = false
        self.backOutlet.isHidden = false
    }
    
    func middileInstructionButtons(){
        self.nextlOutlet.isHidden = false
        self.doneOutlet.isHidden = true
        self.backOutlet.isHidden = false
    }
    
    func firstInstructionButtons(){
        self.nextlOutlet.isHidden = false
        self.doneOutlet.isHidden = true
        self.backOutlet.isHidden = true
    }
    func updatLabel(){
        instructionNumLabel.text = "\(instructionData.count) \\ \(instructionIndex+1)"
    }
    
    
    @IBAction func nextInstruction(_ sender: Any) {
        instructionIndex+=1
        if instructionIndex < instructionData.count{
            showInstruction()
            if instructionIndex == instructionData.count-1{
                lastInstructionButtons()
            }else{
                middileInstructionButtons()
            }
        }
    }
    
    @IBAction func skipInstructionsTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func goBackTapped(_ sender: Any) {
        instructionIndex-=1
        if instructionIndex >= 0{
            showInstruction()
            if instructionIndex == 0{
                middileInstructionButtons()
            }else{
                firstInstructionButtons()
            }
        }
        
    }
    @IBAction func doneTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
