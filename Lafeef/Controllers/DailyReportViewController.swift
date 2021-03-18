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
        if challeangeVC.report.advertismentAmount == 0 {
            adv.isHidden = true
        }
    }

    func convertLabelsToArabic(){
        sales.text = "\(challeangeVC.report.salesAmount)".convertedDigitsToLocale(Locale(identifier: "AR"))
        ingredients.text = "\(challeangeVC.report.ingredientsAmount)".convertedDigitsToLocale(Locale(identifier: "AR"))
        backaging.text = "\(challeangeVC.report.backagingAmount)".convertedDigitsToLocale(Locale(identifier: "AR"))
        advAmount.text = "\(challeangeVC.report.advertismentAmount)".convertedDigitsToLocale(Locale(identifier: "AR"))
    }
    
    // Caluctate Income
    func calcultateIncome(){
        let incomeDigit = challeangeVC.report.salesAmount - challeangeVC.report.ingredientsAmount - challeangeVC.report.backagingAmount + challeangeVC.report.advertismentAmount
        income.text = "\(incomeDigit)".convertedDigitsToLocale(Locale(identifier: "AR"))
        
        //................................ missing money reward!
        challeangeVC.report.collectedMoney += incomeDigit
    }
    
    func calculateReward(){
        switch challeangeVC.report.levelNum {
        case "1":
            if challeangeVC.report.collectedScore>=50{
            challeangeVC.report.reward = 5
            challeangeVC.report.isRewarded = true
            }
            break
        case "2":
            if challeangeVC.report.collectedScore>=60{
            challeangeVC.report.reward = 10
            challeangeVC.report.isRewarded = true
            }
            break
        case "3":
            if challeangeVC.report.collectedScore>=70{
            challeangeVC.report.reward = 15
            challeangeVC.report.isRewarded = true
            }
   
            break
        default:
            if challeangeVC.report.collectedScore>=80{
            challeangeVC.report.reward = 20
            challeangeVC.report.isRewarded = true
            }
            break
        }
     
    }
    

    
    // insert the data to database

    //MARK:- Actions
    @IBAction func next(_ sender: Any) {
//        passReportData()
        if challeangeVC.report.isRewarded {
            self.performSegue(withIdentifier: Constants.Segue.showWinningReport, sender: self)
        } else if  challeangeVC.report.isPassed{
            self.performSegue(withIdentifier: Constants.Segue.showNormalReport, sender: self)
        } else{
                self.performSegue(withIdentifier: Constants.Segue.showLosingReport, sender: self)
                
            }
        }
    // Assert data to firestore
    func passReportData(){
        let levelReportData = LevelReportData(collectedMoney: Int(challeangeVC.report.collectedMoney + challeangeVC.report.advertismentAmount + Float(challeangeVC.report.reward) + challeangeVC.report.collectedMoney), collectedScore: challeangeVC.report.collectedScore, isPassed: challeangeVC.report.isPassed)

//        let completedLevel = CompletedLevel(childID: FirebaseRequest.getUserId()!, reportData: levelReportData)

//        FirebaseRequest.passCompletedLevelData(levelNum: challeangeVC.report.levelNum, completedLevel: completedLevel) { (success, err) in
//            print(err)
//        }
    }
    
}
    
