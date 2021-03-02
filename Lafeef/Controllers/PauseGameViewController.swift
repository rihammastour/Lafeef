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
    var stopImage = UIImage(named: "stopGame")
    var pauseImage = UIImage(named: "Pause")
    override func viewDidLoad() {
        super.viewDidLoad()
        pauseView.layer.cornerRadius = 40
        viewInstructionOutlet.layer.cornerRadius = viewInstructionOutlet.frame.size.height/2
        exitOutlet.layer.cornerRadius = exitOutlet.frame.size.height/2
        continueOutlet.layer.cornerRadius = continueOutlet.frame.size.height/2




    }

    @IBAction func gameContinue(_ sender: Any) {

        if( ChallengeViewController.stopCircleNil){
            GameScene.timer.invalidate()
            GameScene.timeLeft=30
            GameScene.endTime = Date().addingTimeInterval(GameScene.timeLeft)
            GameScene.timeLeft = GameScene.endTime?.timeIntervalSinceNow ?? 0
            GameScene.circle?.isHidden=false
            GameScene.circle =  GameScene.circle
            GameScene.circle!.isPaused=false
            GameScene.TimerShouldDelay = true
            ChallengeViewController.stopImageBool=true
            ChallengeViewController.stopCircleNil=false
        }else{
            GameScene.countStop+=1
//            GameScene.circle =  GameScene.circle
            print(GameScene.timeLeft.time)
            GameScene.TimerShouldDelay = true
            GameScene.endTime = Date().addingTimeInterval(GameScene.timeLeft)
            GameScene.timeLeft = GameScene.timeLeft
            GameScene.timeLeft = GameScene.endTime?.timeIntervalSinceNow ?? 0
            print("after start")
            print(GameScene.timeLeft.time)
            ChallengeViewController.stopImageBool=true




        }
        self.dismiss(animated: true, completion: nil)
    }




    @IBAction func viewInstruction(_ sender: Any) {

    }



        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "exitGame" {
                let vc = segue.destination as! ChalleangeLevelCalendarViewController
                            print("Segue proformed")
                        GameScene.timer.invalidate()
                        GameScene.timeLeft = 30//when exit and enter the game again the
                        ChallengeViewController.stopImageBool=true
                GameScene.circleDecrement=true
            }
        }


}








