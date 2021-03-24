//
//  DailyReportViewController.swift
//  Lafeef
//
//  Created by Riham Mastour on 27/06/1442 AH.
//

import UIKit

class DailyReportViewController: UIViewController {
    
    //MARK:- Proprities
    //variables
    var challeangeVC = ChallengeViewController()
   
    
    //.......................... Don't forget to pass attributes to this VC
  
//    var salesAmount = 0
//    var ingredientsAmount = 0
//    var backagingAmount = 0
//    var advertismentAmount = 0
//    var collectedScore = 0
//    var collectedMoney = 0
//    var isPassed = false
 
   
    //outlets
    @IBOutlet weak var dailyReportView: UIView!
    @IBOutlet weak var sales: UILabel!
    @IBOutlet weak var ingredients: UILabel!
    @IBOutlet weak var backaging: UILabel!
    @IBOutlet weak var advAmount: UILabel!
    @IBOutlet weak var income: UILabel!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var adv: UIStackView!
    
    //MARK:- Life cycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        calcultateIncome()
        styleUI()
        hideAdv()
        calculateReward()
        passReportData()
    }
    
    //MARK:- Functions
    
    // Styling UI
    func styleUI(){
        dailyReportView.layer.cornerRadius = 30
        Utilities.styleFilledButton(nextButton, color: "blueApp")
        convertLabelsToArabic()
    }
    
    func hideAdv(){
        // advertismentAmount passed from AdvReportVC
        if LevelGoalViewController.report.advertismentAmount == 0 {
            adv.isHidden = true
        }
    }

    func convertLabelsToArabic(){
        sales.text = "\(LevelGoalViewController.report.salesAmount)".convertedDigitsToLocale(Locale(identifier: "AR"))
        ingredients.text = "\(LevelGoalViewController.report.ingredientsAmount)".convertedDigitsToLocale(Locale(identifier: "AR"))
        backaging.text = "\(LevelGoalViewController.report.backagingAmount)".convertedDigitsToLocale(Locale(identifier: "AR"))
        advAmount.text = "\(LevelGoalViewController.report.advertismentAmount)".convertedDigitsToLocale(Locale(identifier: "AR"))
    }
    
    // Caluctate Income
    func calcultateIncome(){
        let incomeDigit = LevelGoalViewController.report.salesAmount - LevelGoalViewController.report.ingredientsAmount - LevelGoalViewController.report.backagingAmount + LevelGoalViewController.report.advertismentAmount
        income.text = "\(incomeDigit)".convertedDigitsToLocale(Locale(identifier: "AR"))
        
        //................................ missing money reward!
        LevelGoalViewController.report.collectedMoney += incomeDigit
    }
    
    func calculateReward(){
        switch LevelGoalViewController.report.levelNum {
        case "1":
            if LevelGoalViewController.report.collectedScore>=50{
                LevelGoalViewController.report.reward = 5
                LevelGoalViewController.report.isRewarded = true
            }
            break
        case "2":
            if LevelGoalViewController.report.collectedScore>=60{
                LevelGoalViewController.report.reward = 10
                LevelGoalViewController.report.isRewarded = true
            }
            break
        case "3":
            if LevelGoalViewController.report.collectedScore>=70{
                LevelGoalViewController.report.reward = 15
                LevelGoalViewController.report.isRewarded = true
            }
   
            break
        default:
            if LevelGoalViewController.report.collectedScore>=80{
                LevelGoalViewController.report.reward = 20
                LevelGoalViewController.report.isRewarded = true
            }
            break
        }
     
    }
    

    
    // insert the data to database

    //MARK:- Actions
    @IBAction func next(_ sender: Any) {
//        passReportData()
        if LevelGoalViewController.report.isRewarded {
            self.performSegue(withIdentifier: Constants.Segue.showWinningReport, sender: self)
        } else if  LevelGoalViewController.report.isPassed{
            self.performSegue(withIdentifier: Constants.Segue.showNormalReport, sender: self)
        } else{
                self.performSegue(withIdentifier: Constants.Segue.showLosingReport, sender: self)
                
            }
        }
    // Assert data to firestore
    func passReportData(){
        let levelReportData = LevelReportData(collectedMoney: Int(LevelGoalViewController.report.collectedMoney + LevelGoalViewController.report.advertismentAmount + Float(LevelGoalViewController.report.reward)), collectedScore: LevelGoalViewController.report.collectedScore, isPassed: LevelGoalViewController.report.isPassed)

        let completedLevel = CompletedLevel(childID: FirebaseRequest.getUserId()!, reportData: levelReportData)

        FirebaseRequest.passCompletedLevelData(levelNum: LevelGoalViewController.report.levelNum, completedLevel: completedLevel) { (success, err) in
            print(err)
        }
    }
    
}
    

