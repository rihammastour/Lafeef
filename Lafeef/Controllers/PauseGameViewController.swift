//
//  PauseGameViewController.swift
//  Lafeef
//
//  Created by Raghad alfuhaid on 04/07/1442 AH.
//


import Foundation
import UIKit
class PauseGameViewController: UIViewController{
    
 
    let timerClass = GameScene()
    var challengeScen:GameScene?
    @IBOutlet weak var pauseView: UIView!
    @IBOutlet weak var viewInstructionOutlet: UIButton!
    @IBOutlet weak var exitOutlet: UIButton!
    @IBOutlet weak var continueOutlet: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        pauseView.layer.cornerRadius = 40
//        pauseView.backgroundColor=UIColor(hue: 0.1389, saturation: 0.02, brightness: 0.98, alpha: 1.0)
        viewInstructionOutlet.layer.cornerRadius = viewInstructionOutlet.frame.size.height/2
        exitOutlet.layer.cornerRadius = exitOutlet.frame.size.height/2
        continueOutlet.layer.cornerRadius = continueOutlet.frame.size.height/2
        
    
    }
    

    @IBAction func gameContinue(_ sender: Any) {
        print("[[[[[[[[[[[[[[[[")
//        timerClass.timeLabel.text=timerClass.timeLeft.time
//        timerClass.timer.invalidate()
////        timerClass.PauseTime(true)
      
        print(GameScene.timeLeft.time)
        
        print("[[[[[[[[[[[[[[[[")
        GameScene.endTime = Date().addingTimeInterval(GameScene.timeLeft)
        GameScene.timer=Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self.challengeScen?.updateTime), userInfo: nil, repeats: true)
//        GameScene.timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
        self.dismiss(animated: true)
//
        
    }
    
    @IBAction func viewInstruction(_ sender: Any) {
        
    }
    @IBAction func exitGame(_ sender: Any) {
        GameScene.timer.invalidate()
    }

    
}
