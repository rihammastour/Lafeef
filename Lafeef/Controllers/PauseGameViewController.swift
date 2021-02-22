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
       
        print(GameScene.timeLeft.time)
//        GameScene.stop = false
        GameScene.TimerShouldNotDelay = true
       
        print("[[[[[[[[[[[[[[[[")
        GameScene.endTime = Date().addingTimeInterval(GameScene.timeLeft)
        GameScene.timeLeft = GameScene.timeLeft
        
        GameScene.displayTime?.fontName =  "FF Hekaya"
        GameScene.timeLeft = GameScene.endTime?.timeIntervalSinceNow ?? 0
        print("befor start")
//        timerClass.startTimer()
        print(GameScene.timeLeft.time)
        GameScene.circleBool=true
        print("after start")
        GameScene.isPaused11=true
        print(GameScene.isPaused11)
        GameScene.displayTime?.text=GameScene.timeLeft.time
//        GameScene.updateTime()
        GameScene.circle!.isPaused=false
        self.dismiss(animated: true, completion: nil)
        
//        performSegue(withIdentifier: "ContinueGame", sender: self)
        //        timerClass.timeLabel.text=timerClass.timeLeft.time
        //        timerClass.timer.invalidate()
        ////        timerClass.PauseTime(true)
//        GameScene.circle?.isPaused=false
//        GameScene.circle?.speed=1
//        GameScene.timer.fire()
//        GameScene.displayTime?.text = GameScene.endTime?.timeIntervalSinceNow ?? 0
//        GameScene.displayTime?.text=GameScene.timeLeft.time+"kkkkk"
        //        GameScene.timer=Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(challengeScen!.updateTime), userInfo: nil, repeats: true)
        //        GameScene.timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)

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
//    @IBAction func exitGame(_ sender: Any) {
//
//        GameScene.timer.invalidate()
//        GameScene.timeLeft = 120//when exit and enter the game again the timer restart
////        GameScene.circleBool=true
//        GameScene.percent=CGFloat(1.0)
//
//    }
    
    
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "exitGame" {
                let vc = segue.destination as! ChallengeLevelsViewController
                            print("Segue proformed")
    //            vc.levelNum = "1"
                        GameScene.timer.invalidate()
                        GameScene.timeLeft = 30//when exit and enter the game again the timer restart
                //        GameScene.circleBool=true
//                        GameScene.percent=CGFloat(1.0)
            }
        }

    
}
