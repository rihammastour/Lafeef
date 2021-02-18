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
        GameScene.timeLeft = GameScene.timeLeft
        
        GameScene.displayTime?.fontName =  "FF Hekaya"
        GameScene.timeLeft = GameScene.endTime?.timeIntervalSinceNow ?? 0
        GameScene.timer.fire()
//        GameScene.displayTime?.text = GameScene.endTime?.timeIntervalSinceNow ?? 0
        print("befor start")
//        timerClass.startTimer()
        print(GameScene.timeLeft.time)
    
        print("after start")
      
        
//        GameScene.timer=Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(challengeScen!.updateTime), userInfo: nil, repeats: true)
//        GameScene.timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
        self.dismiss(animated: true)
//

    }
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == Constants.Segue.continueGame {
//            let vc = segue.destination as! ChallengeViewController
//                        print("Segue proformed")
////            vc.levelNum = "1"
//
//        }
//    }
    
    
    
    @IBAction func viewInstruction(_ sender: Any) {
        
    }
    @IBAction func exitGame(_ sender: Any) {
        
        GameScene.timer.invalidate()
        GameScene.timeLeft = 120//when exit and enter the game again the timer restart 
    }

    
}
