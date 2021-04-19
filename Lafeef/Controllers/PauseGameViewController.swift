
//  PauseGameViewController.swift
//  Lafeef
//
//  Created by Raghad alfuhaid on 04/07/1442 AH.
//


import Foundation
import UIKit
class PauseGameViewController: UIViewController{


    //MARK: - Variables
    var challengeScen:GameScene!
    var leftTimeTemp:TimeInterval!
    var delegate:ManageViewController!

    @IBOutlet weak var pauseView: UIView!
    @IBOutlet weak var viewInstructionOutlet: UIButton!
    @IBOutlet weak var exitOutlet: UIButton!
    @IBOutlet weak var continueOutlet: UIButton!
    var stopImage = UIImage(named: "stopGame")
    var pauseImage = UIImage(named: "Pause")
    
    //MARK: - Lifecycle Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        pauseView.layer.cornerRadius = 40
        viewInstructionOutlet.layer.cornerRadius = viewInstructionOutlet.frame.size.height/2
        exitOutlet.layer.cornerRadius = exitOutlet.frame.size.height/2
        continueOutlet.layer.cornerRadius = continueOutlet.frame.size.height/2
        
        self.leftTimeTemp = challengeScen.timeLeft

    }
    
    //MARK: -IBAction

    @IBAction func gameContinue(_ sender: Any) {

        if( ChallengeViewController.stopCircleNil){
//            DispatchQueue.main.async {
//                self.challengeScen.timer.invalidate()
//            }
//            challengeScen.timeLeft=30
//            GameScene.endTime = Date().addingTimeInterval(challengeScen.timeLeft)
//            challengeScen.timeLeft = GameScene.endTime?.timeIntervalSinceNow ?? 0
//            GameScene.circle?.isHidden=false
//            GameScene.circle =  GameScene.circle
//            GameScene.circle?.isPaused=false
//            GameScene.TimerShouldDelay = true
//            ChallengeViewController.stopImageBool=true
//            ChallengeViewController.stopCircleNil=false
        }else{
//            GameScene.countStop+=1
////            GameScene.circle =  GameScene.circle
//            print(challengeScen.timeLeft.time)
//            GameScene.TimerShouldDelay = true
//            GameScene.endTime = Date().addingTimeInterval(challengeScen.timeLeft)
//            challengeScen.timeLeft = challengeScen.timeLeft
//            challengeScen.timeLeft = GameScene.endTime?.timeIntervalSinceNow ?? 0
//            print("after start")
//            print(challengeScen.timeLeft.time)
//            ChallengeViewController.stopImageBool=true
//            GameScene.circleDecrement=true
            GameScene.TimerShouldDelay = true
            GameScene.endTime = Date().addingTimeInterval(self.leftTimeTemp)
            GameScene.circleDecrement=true
            GameScene.circle!.isPaused=false
            ChallengeViewController.stopImageBool=true
            self.challengeScen.pleaseRUUUNN(as: self.leftTimeTemp)
        }

        //self.challengeScen.circleShouldDelay()
        self.dismiss(animated: true, completion: nil)
    }



    @IBAction func viewInstruction(_ sender: Any) {

    }
    
    @IBAction func exitbuttonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion:{
            self.delegate.exitPlaying()
        })
    }
    



        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "exitGame" {
                let vc = segue.destination as! ChalleangeLevelCalendarViewController
                challengeScen.timer.invalidate()
                challengeScen.timeLeft = 30//when exit and enter the game again the
                        ChallengeViewController.stopImageBool=true
                GameScene.circleDecrement=true
            }
        }


}







