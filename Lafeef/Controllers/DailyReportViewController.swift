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
    var delagate:ManageViewController!
    var report:DailyReport!
    
    var challeangeVC = ChallengeViewController()
    var completedLevel  =  CompletedLevel(reportData: [])
    var childId :String?
    var home = HomeViewController()
    let sound = SoundManager()
    var alertService = AlertService()
    var childInfo : Child?
    var flag = false
    var levelnum : Int = 1
    
    
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
        
        getChildInfo()
        styleUI()
        hideAdv()
        calculateReward()
        calcultateIncome()
        passReportData()
    }
    
    //MARK:- UI Functions
    
    // Styling UI
    func styleUI(){
        dailyReportView.layer.cornerRadius = 30
        Utilities.styleFilledButton(nextButton, color: "blueApp")
        convertLabelsToArabic()
    }
    
    //MARK:- Functions
    
    
    func newCurrentLevel()->Int{
           
        guard let child =  childInfo else {
            return 1
        }
           let childCurrentLevel = Int(child.currentLevel)
        if (report.isPassed && report.levelNum != "4" && Int(report.levelNum)! >= childCurrentLevel){
               
            return  childCurrentLevel+1
            
        }else{
               return child.currentLevel
           }
       }
    
    //MARK: - Get Data
    func getChildInfo(){
        let child = LocalStorageManager.getChild()
        if let child = child {
            self.childInfo = child
        }
    }
    
    //MARK:- Set Data
    
    //Firebase update methods
    func updateChildInfo(){
        guard let childInfo = self.childInfo else {
            return
        }
        
        let score = report.collectedScore+Float(childInfo.score)
        let money = report.collectedMoney+childInfo.money
        let currentLevel = newCurrentLevel()
        print("currentLevel ::::",currentLevel)
        FirebaseRequest.updateChildInfo(score, Money: money, currentLevel) { (complete, error) in
            
            if error == nil {
                print("successfuly update child info ")
                
            }else{
                print("error in update child info")
            }
        }
    }
    
    func hideAdv(){
        // advertismentAmount passed from AdvReportVC
        if report.advertismentAmount == 0 {
            adv.isHidden = true
        }
    }
    
    func convertLabelsToArabic(){
        checkSalesAmount()
        sales.text = "\(report.salesAmount)".convertedDigitsToLocale(Locale(identifier: "AR"))
        ingredients.text = "\(report.ingredientsAmount)".convertedDigitsToLocale(Locale(identifier: "AR"))
        backaging.text = "\(report.backagingAmount)".convertedDigitsToLocale(Locale(identifier: "AR"))
        advAmount.text = "\(report.advertismentAmount)".convertedDigitsToLocale(Locale(identifier: "AR"))
    }
    
    // Caluctate Income
    func calcultateIncome(){
        checkSalesAmount()
        let incomeDigit = report.salesAmount - report.ingredientsAmount - report.backagingAmount + report.advertismentAmount
        
        print("Sales amount",report.salesAmount)
        income.text = "\(incomeDigit)".convertedDigitsToLocale(Locale(identifier: "AR"))
        
        report.collectedMoney += incomeDigit + Float(report.reward)
        updateChildInfo()
    }
    
    func calculateReward(){
        switch report.levelNum {
        case "1":
            if report.collectedScore>=60{
                report.reward = 5
                report.isRewarded = true
            }
            break
        case "2":
            if report.collectedScore>=70{
                report.reward = 10
                report.isRewarded = true
            }
            break
        case "3":
            if report.collectedScore>=80{
                report.reward = 15
                report.isRewarded = true
            }
            
            break
        default:
            if report.collectedScore>=90{
                report.reward = 20
                report.isRewarded = true
            }
            break
        }
        
    }
    
    
    
    // insert the data to database
    
    //MARK:- Actions
    @IBAction func next(_ sender: Any) {
        if report.isRewarded {
            self.dismiss(animated: true) {
                self.delagate.displayWainningReport(self.report)
            }
        } else if  report.isPassed{
            
            self.dismiss(animated: true) {
                self.delagate.displayNormalReport(self.report)
            }
        } else{
            self.dismiss(animated: true) {
                self.delagate.displayLosingReport(self.report)
            }
            
        }
    }
    // Assert data to firestore
    func passReportData(){
        var newCompleted = CompletedLevel(reportData: [])
         
         let ReportData = LevelReportData(levelNum:report.levelNum, collectedMoney: Float(report.collectedMoney + report.advertismentAmount + Float(report.reward)), collectedScore: report.collectedScore, isPassed: report.isPassed)
         
         
         FirebaseRequest.getChalleangeLevelesReports(childID: FirebaseRequest.getUserId()!) { [self] (data, error) in
             if error == ""{
                 do{
                     let level = try FirebaseDecoder().decode(CompletedLevel.self, from: data!)
                     self.setCompletedLevel(completed: level)
                     
                     
                     let levelnum = report.levelNum
                     
                     if completedLevel.reportData.count == 1 &&
                         completedLevel.reportData.first?.isPassed == false{
                         let array = [ReportData]
                         newCompleted = CompletedLevel(reportData: array)
                         print("first if ")
                         flag = true
                         // the first time
                         // overrite
                     }else {
                         for var report in completedLevel.reportData{
                            if report.levelNum == levelnum && report.collectedScore < ReportData.collectedScore{
                                newCompleted.reportData.append(ReportData)
                                 flag = true
                                 print("loop in if ")
                                print(newCompleted,"loop in if")

                            }else if report.levelNum == levelnum && report.collectedScore > ReportData.collectedScore{
                                newCompleted.reportData.append(report)
                                flag = true
                               
                                
                            }else{
                                newCompleted.reportData.append(report)
                            }
                            
                         }
                     }
                     if !flag{
                        newCompleted = completedLevel
                        newCompleted.reportData.append(ReportData)
                     }
                     
                     FirebaseRequest.passCompletedLevelData(childID:FirebaseRequest.getUserId()! , reports: newCompleted) { (success, err) in
                         if (err == nil){
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
     
    
    func checkSalesAmount(){
            if report.salesAmount == 0.0 {
                report.ingredientsAmount = 0
                report.backagingAmount = 0
            }
        }
    
    
    func setCompletedLevel(completed:CompletedLevel){
        self.completedLevel = completed
    }
}


