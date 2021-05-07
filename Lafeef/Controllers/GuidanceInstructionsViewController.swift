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
    var instructionData:[String] = ["instructions-reflector","instructions-Stand","lampInstruction","challeangecalendar","challeangeCake","payment","trainingsection","pineappleAnswer"]
    var instructionIndex = 0
    let formatter = NumberFormatter()
    let sound = SoundManager()
    //IBOutlet
    @IBOutlet weak var instructionView: UIView!
    @IBOutlet weak var reflector: UIImageView!
    @IBOutlet weak var nextlOutlet: UIButton!
    @IBOutlet weak var doneOutlet: UIButton!
    @IBOutlet weak var backOutlet: UIButton!
    @IBOutlet weak var instructionNumLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        formatter.locale = Locale(identifier: "ar")
        nextlOutlet.layer.cornerRadius =  nextlOutlet.frame.size.height/2
        
        backOutlet?.layer.cornerRadius =  backOutlet.frame.size.height/2
        
        doneOutlet?.layer.cornerRadius =  doneOutlet.frame.size.height/2
        instructionView.layer.cornerRadius = 30
        
        showInstruction()
        
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "blank-bakery")
        backgroundImage.contentMode = UIView.ContentMode.scaleToFill
        self.view.insertSubview(backgroundImage, at: 0)
        
        view.backgroundColor = UIColor(white: 1, alpha: 0.5)
    }
    
    func showInstruction(){
        sound.stopSound()
        reflector.image = UIImage.gif(name: instructionData[instructionIndex])
        if( instructionData[instructionIndex]=="payment" ){
            sound.playSound(sound: Constants.Sounds.paymentInstruction)
        }else if( instructionData[instructionIndex]=="challeangeCake" ){
            sound.playSound(sound: Constants.Sounds.orderInstruction)
        }
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
        instructionNumLabel.text = formatter.string(from: NSNumber(value: instructionIndex+1))!+"/"+formatter.string(from: NSNumber(value: instructionData.count))!
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
        sound.stopSound()
    }
    
    @IBAction func goBackTapped(_ sender: Any) {
        instructionIndex-=1
        if instructionIndex >= 0{
            showInstruction()
            if instructionIndex == 0{
                firstInstructionButtons()
            }else{
                middileInstructionButtons()
            }
        }
        
    }
    @IBAction func doneTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        sound.stopSound()
    }
    
}
