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
    var challeangeVC = ChallengeViewController()
    var completedLevel  =  CompletedLevel(reportData: [])
    var childId :String?
    var home = HomeViewController()
    let sound = SoundManager()
    var alertService = AlertService()
    var childInfo : Child?
    var flag = false
    var levelnum : Int = 1
    var report:DailyReport!

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
        
        
        getChildId {
            self.calcultateIncome()
        }
        
        styleUI()
        hideAdv()
        calculateReward()
        passReportData()
        updatelevelNum()
    }
    
    //MARK:- Functions
    
    // Styling UI
    func styleUI(){
        dailyReportView.layer.cornerRadius = 30
        Utilities.styleFilledButton(nextButton, color: "blueApp")
        convertLabelsToArabic()
    }
    func updatemoneyLabel(){ //Must be done in firestore
        
        GameScene.setMoneyLabel(report.collectedMoney)
        childInfo?.money += report.collectedMoney
        childInfo?.score += Int(report.collectedScore)
        updateChildInfo()
    }
    
    
    func updatelevelNum(){ //Must be changed in firebase!!
        levelnum = Int(report.levelNum)!
        if (report.isPassed && report.levelNum != "4"){
            
            levelnum = levelnum+1
            childInfo?.currentLevel = levelnum
        }else{
            childInfo?.currentLevel = levelnum
        }
    }
    
    func updateChildInfo(){ //Firebase update methods
        FirebaseRequest.updateChildInfo(report.collectedScore+Float(childInfo!.score), Money: report.collectedMoney+childInfo!.money, levelnum) { (complete, error) in
            
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
        sales.text = "\(report.salesAmount)".convertedDigitsToLocale(Locale(identifier: "AR"))
        ingredients.text = "\(report.ingredientsAmount)".convertedDigitsToLocale(Locale(identifier: "AR"))
        backaging.text = "\(report.backagingAmount)".convertedDigitsToLocale(Locale(identifier: "AR"))
        advAmount.text = "\(report.advertismentAmount)".convertedDigitsToLocale(Locale(identifier: "AR"))
    }
    
    // Caluctate Income
    func calcultateIncome(){
        let incomeDigit = report.salesAmount - report.ingredientsAmount - report.backagingAmount + report.advertismentAmount
        income.text = "\(incomeDigit)".convertedDigitsToLocale(Locale(identifier: "AR"))
        
        //................................ missing money reward!
        report.collectedMoney += incomeDigit
        updatemoneyLabel()
    }
    
    func calculateReward(){
        switch report.levelNum {
        case "1":
            if report.collectedScore>=50{
                report.reward = 5
                report.isRewarded = true
            }
            break
        case "2":
            if report.collectedScore>=60{
                report.reward = 10
                report.isRewarded = true
            }
            break
        case "3":
            if report.collectedScore>=70{
                report.reward = 15
               report.isRewarded = true
            }
            
            break
        default:
            if report.collectedScore>=80{
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
            self.performSegue(withIdentifier: Constants.Segue.showWinningReport, sender: self)
        } else if  report.isPassed{
            self.performSegue(withIdentifier: Constants.Segue.showNormalReport, sender: self)
        } else{
            self.performSegue(withIdentifier: Constants.Segue.showLosingReport, sender: self)
            
        }
    }
    // Assert data to firestore
    func passReportData(){
        
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
                        self.completedLevel = CompletedLevel(reportData: array)
                        print("first if ")
                        flag = true 
                        // the first time
                        // overrite
                    }else {
                        for var report in completedLevel.reportData{
                            if report.levelNum == levelnum{
                                report = ReportData
                                flag = true
                                print("loop in if ")
                                
                            }
                            print("out loop ")
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
    
    
    func getChildId(completion: @escaping ()  -> Void) {
        
        self.childId =  FirebaseRequest.getUserId() ?? ""
        childInfo = LocalStorageManager.getChild()
        
    }
    
    
    func setCompletedLevel(completed:CompletedLevel){
        print("inside set")
        self.completedLevel = completed
    }
}


