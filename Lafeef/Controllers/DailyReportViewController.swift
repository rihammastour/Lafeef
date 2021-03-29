//
//  DailyReportViewController.swift
//  Lafeef
//
//  Created by Riham Mastour on 27/06/1442 AH.
//

import UIKit
import CodableFirebase

class DailyReportViewController: UIViewController {
    
    //MARK:- Proprities
    //variables
    var challeangeVC = ChallengeViewController()
    var completedLevel  =  CompletedLevel(reportData: [])
    var  childId :String?
    var home = HomeViewController()
   
    


 
   
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
        getChildId()
    }
    
    //MARK:- Functions
    
    // Styling UI
    func styleUI(){
        dailyReportView.layer.cornerRadius = 30
        Utilities.styleFilledButton(nextButton, color: "blueApp")
        convertLabelsToArabic()
    }
    func updatemoneyLabel(){
        GameScene.setMoneyLabel(LevelGoalViewController.report.collectedMoney)
        home.setScore(Int(LevelGoalViewController.report.collectedScore))
        home.setMoney(LevelGoalViewController.report.collectedMoney)
        if (LevelGoalViewController.report.isPassed && LevelGoalViewController.report.levelNum != "4"){
            var levelnum = Int(LevelGoalViewController.report.levelNum)
            levelnum = levelnum!+1
            home.setCurrentLevel(levelnum!)
        }else{
        
            home.setCurrentLevel(Int(LevelGoalViewController.report.levelNum)!)

        
    }
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
        updatemoneyLabel()
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
        print(FirebaseRequest.getUserId(),"idd")
        let ReportData = LevelReportData(levelNum:LevelGoalViewController.report.levelNum, collectedMoney: Int(LevelGoalViewController.report.collectedMoney + LevelGoalViewController.report.advertismentAmount + Float(LevelGoalViewController.report.reward)), collectedScore: LevelGoalViewController.report.collectedScore, isPassed: LevelGoalViewController.report.isPassed)

      
        FirebaseRequest.getChalleangeLevelesReports(childID: FirebaseRequest.getUserId()!) { [self] (data, error) in
            if error == ""{
                do{
           let level = try FirebaseDecoder().decode(CompletedLevel.self, from: data!)
                    self.setCompletedLevel(completed: level)
                    print("completedlevel")
                    print(completedLevel.reportData.count,"count")
                    
                    let levelnum = LevelGoalViewController.report.levelNum
                    print(levelnum)
                    print(self.completedLevel.reportData.count ,"count")
                    if completedLevel.reportData.count == 1 &&
                        completedLevel.reportData.first?.isPassed == false{
                        let array = [ReportData]
                        self.completedLevel = CompletedLevel(reportData: array)
                        print("first if ")
                    }else if (completedLevel.reportData.count == Int(levelnum)){
                        print("second if ")
                        for var report in completedLevel.reportData{
                            if report.levelNum == levelnum{
                           report = ReportData
                            }
                        }
                    }else{
                        self.completedLevel.reportData.append(ReportData)
                        }

                    FirebaseRequest.passCompletedLevelData(childID:FirebaseRequest.getUserId()! , reports: self.completedLevel) { (success, err) in
                    if (err != nil){
                    print("success")
                    } else{
                        print("error")
                        }


                    }


            }catch{
             print("error while decoding child report ",error)
               }


            }else{
                print("error")

            }
        }
 

    }
    func getChildId(){
        self.childId =  FirebaseRequest.getUserId() ?? ""
    }


    func setCompletedLevel(completed:CompletedLevel){
        print("inside set")
    self.completedLevel = completed
}
}


