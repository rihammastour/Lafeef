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
    let  sound = SoundManager()
    var alertService = AlertService()
    var childInfo : Child?
    var flag = false
 
   
    


 
   
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
        GameScene.currentCustomer = 0
      
       
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
        var child = LocalStorageManager.getChild()
        child?.money += LevelGoalViewController.report.collectedMoney 
        child?.score += Int(LevelGoalViewController.report.collectedScore)
        var levelnum = Int(LevelGoalViewController.report.levelNum)
        if (LevelGoalViewController.report.isPassed && LevelGoalViewController.report.levelNum != "4"){
           
            levelnum = levelnum!+1
            child?.currentLevel = levelnum!
        }else{
              child?.currentLevel = levelnum!
        }
        getChildData()
       
        
//        LocalStorageManager.setChild(child!)
        
    }
    func getChildData(){
        let child = LocalStorageManager.getChild()
        
        if let child = child {
            childInfo = child
            
        }else{
            print("No Child Found")
            self.present(self.alertService.Alert(body: "لايوجد مستخدم"),animated:true)
           
            //TODO: Alert..
            updateChildInfo()
            // need to complete
            
        }
    }
    func updateChildInfo(){
        
        
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
    
        let ReportData = LevelReportData(levelNum:LevelGoalViewController.report.levelNum, collectedMoney: Float(LevelGoalViewController.report.collectedMoney + LevelGoalViewController.report.advertismentAmount + Float(LevelGoalViewController.report.reward)), collectedScore: LevelGoalViewController.report.collectedScore, isPassed: LevelGoalViewController.report.isPassed)

      
        FirebaseRequest.getChalleangeLevelesReports(childID: FirebaseRequest.getUserId()!) { [self] (data, error) in
            if error == ""{
                do{
           let level = try FirebaseDecoder().decode(CompletedLevel.self, from: data!)
                    self.setCompletedLevel(completed: level)
                 
                    
                    let levelnum = LevelGoalViewController.report.levelNum
                    print(levelnum)
                  
                    if completedLevel.reportData.count == 1 &&
                        completedLevel.reportData.first?.isPassed == false{
                        let array = [ReportData]
                        self.completedLevel = CompletedLevel(reportData: array)
                        print("first if ")
                         // the first time
                        // overrite
                    }else {
                        for var report in completedLevel.reportData{
                            if report.levelNum == levelnum{
                                report = ReportData
                                flag = true
                              
                            }
                        }
                    }
                        if !flag{
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
   
    func updateScoreSum(){
        
    }
    func getChildId(){
        self.childId =  FirebaseRequest.getUserId() ?? ""
    }


    func setCompletedLevel(completed:CompletedLevel){
        print("inside set")
    self.completedLevel = completed
}
}


