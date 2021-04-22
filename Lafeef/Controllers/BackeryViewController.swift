//
//  BackeryViewController.swift
//  Lafeef
//
//  Created by Mihaf on 11/08/1442 AH.
//

import UIKit

class BackeryViewController: UIViewController, ManageViewController{

    //MARK: -  variables
    
    var levelNum:String!
    var goalService = GoalService()
    let sound = SoundManager()

    //MARK:- LifeCycle Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Set bakery Background
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "previewBackground")
        backgroundImage.contentMode = UIView.ContentMode.scaleToFill
        self.view.insertSubview(backgroundImage, at: 0)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.showGoalMessage()
        }
  
    }
    
//MARK:- Helper Functions
    
    func checkAd()->Bool{
        let levelTwoCount = UserDefaults.standard.integer(forKey: "levelTwoCount")
        let levelFourCount = UserDefaults.standard.integer(forKey: "levelFourCount")
        
        
        if self.levelNum == "2" && levelTwoCount < 1  || self.levelNum == "4"  && levelFourCount < 1{
            return true
        }else{
            return false
        }
        
    }
    
    //MARK: - Delagate Methods
    func showGoalMessage(){
        if let goalLevelVC = storyboard?.instantiateViewController(identifier: Constants.Storyboard.goalLevelVC) as? LevelGoalViewController{
            goalLevelVC.levelNum =  levelNum
            goalLevelVC.delegate = self
            present(goalLevelVC, animated: true,completion:nil)
        }
    }
    
    func presentAdvReport(){
        SoundManager().playSound(sound: Constants.Sounds.advertisment)
        let storyboard = UIStoryboard(name: "Challenge", bundle: nil)
        let advVC = storyboard.instantiateViewController(withIdentifier:Constants.Storyboard.advReportViewController) as! AdvReportViewController
        advVC.delagte = self
        advVC.levelNum = self.levelNum
        self.present(advVC, animated: true,completion: nil)
    }
    
    
    func startGame(with advAmount:Float, for adv:Int){
        if(!checkAd()){
            if let challengeVC = self.storyboard?.instantiateViewController(identifier: Constants.Storyboard.challengeViewController) as? ObjectDetectionViewController{
                challengeVC.delegate = self
                challengeVC.levelNum = self.levelNum
                //Set Adv if any 
                challengeVC.report.advertismentAmount = advAmount
                challengeVC.randomAdv = adv
                challengeVC.sound = sound
                self.present(challengeVC, animated: true){
                    self.sound.playSound(sound:Constants.Sounds.bakery)
                }
                }
        }else{
            presentAdvReport()
        }
    }
    
    
    func displayDailyReport(_ report:DailyReport){
        if let reportVC = self.storyboard?.instantiateViewController(identifier: Constants.Storyboard.dailyReportViewController) as? DailyReportViewController{
            reportVC.report = report
            reportVC.delagate = self
            self.present(reportVC, animated: true){
                    self.sound.player?.stop()
                }
            }
    }
    
    //MARK: Rewards Reports
    ///Wainnig Report
    func displayWainningReport(_ report:DailyReport){
        if let reportVC = self.storyboard?.instantiateViewController(identifier: Constants.Storyboard.WinningViewController) as? WinningViewController{
            reportVC.report = report
            reportVC.delagate = self
                self.present(reportVC, animated: true,completion: nil)
            }
    }
    ///Normal Report
    func displayNormalReport(_ report:DailyReport){
        if let reportVC = self.storyboard?.instantiateViewController(identifier: Constants.Storyboard.NormalViewController) as? NormalViewController{
            reportVC.report = report
            reportVC.delagate = self
                self.present(reportVC, animated: true,completion: nil)
            }
    }
    
    ///Losing Report
    func displayLosingReport(_ report:DailyReport){
        if let reportVC = self.storyboard?.instantiateViewController(identifier: Constants.Storyboard.losingViewController) as? LosingViewController{
            reportVC.report = report
            reportVC.delagate = self
                self.present(reportVC, animated: true,completion: nil)
            }
    }
    
    ///Exit Play Mode
    func exitPlayChallengeMode(){
        self.dismiss(animated: true, completion: nil)
    }
    
    ///Exit Play Mode
    func exitPlaying(){
        self.dismiss(animated: true, completion:{
            self.dismiss(animated: false, completion: nil)
        })
    }
    


}
