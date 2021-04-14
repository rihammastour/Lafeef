//
//  BackeryViewController.swift
//  Lafeef
//
//  Created by Mihaf on 11/08/1442 AH.
//

import UIKit

class BackeryViewController: UIViewController, ManageViewController{

    
    
    var levelNum:String!
    var goalService = GoalService()

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
    
    func showGoalMessage(){
        if let goalLevelVC = storyboard?.instantiateViewController(identifier: Constants.Storyboard.goalLevelVC) as? LevelGoalViewController{
            goalLevelVC.levelNum =  levelNum
            goalLevelVC.delegate = self
            present(goalLevelVC, animated: true,completion:nil)
        }
                   
    }
    
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
    
    func startGame(){
        if(!checkAd()){
            if let challengeVC = self.storyboard?.instantiateViewController(identifier: Constants.Storyboard.challengeViewController) as? ObjectDetectionViewController{
                challengeVC.delegate = self
                challengeVC.levelNum = self.levelNum
                    self.present(challengeVC, animated: true,completion: nil)
                }
        }else{
            presentAdvReport()
        }
    }
    

    
    func displayDailyReport(_ report:DailyReport){
        if let reportVC = self.storyboard?.instantiateViewController(identifier: Constants.Storyboard.dailyReportViewController) as? DailyReportViewController{
            reportVC.report = report
            reportVC.delagate = self
                self.present(reportVC, animated: true,completion: nil)
            }
    }
    
    
    func presentAdvReport(){
        SoundManager().playSound(sound: Constants.Sounds.advertisment)
        let storyboard = UIStoryboard(name: "Challenge", bundle: nil)
        let advVC = storyboard.instantiateViewController(withIdentifier:Constants.Storyboard.advReportViewController) as! AdvReportViewController
        advVC.delagte = self
        self.present(advVC, animated: true,completion: nil)
    }
    
    
    func displayPauseMenue(){
        print("Comming")
    }

}
