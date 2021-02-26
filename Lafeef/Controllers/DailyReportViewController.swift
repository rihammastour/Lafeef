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
    //.......................... Don't forget to pass attributes to this VC
    var levelNum = "1"
    var salesAmount = 0
    var ingredientsAmount = 0
    var backagingAmount = 0
    var advertismentAmount = 0
    var collectedScore = 0
    var collectedMoney = 0
    var isPassed = false


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
        if advertismentAmount == 0 {
            adv.isHidden = true
        }
    }

    func convertLabelsToArabic(){
        sales.text = "\(salesAmount)".convertedDigitsToLocale(Locale(identifier: "AR"))
        ingredients.text = "\(ingredientsAmount)".convertedDigitsToLocale(Locale(identifier: "AR"))
        backaging.text = "\(backagingAmount)".convertedDigitsToLocale(Locale(identifier: "AR"))
        advAmount.text = "\(advertismentAmount)".convertedDigitsToLocale(Locale(identifier: "AR"))
    }
    
    // Caluctate Income
    func calcultateIncome(){
        let incomeDigit = self.salesAmount - self.ingredientsAmount - self.backagingAmount + self.advertismentAmount
        income.text = "\(incomeDigit)".convertedDigitsToLocale(Locale(identifier: "AR"))
        
        //................................ missing money reward!
        self.collectedMoney = incomeDigit
    }
    
    
    // Assert data to firestore
    func passReportData(){
        let levelReportData = LevelReportData(collectedMoney: self.collectedMoney, collectedScore: self.collectedScore, isPassed: self.isPassed)
        
        let completedLevel = CompletedLevel(childID: FirebaseRequest.getUserId()!, reportData: levelReportData)

        FirebaseRequest.passCompletedLevelData(levelNum: self.levelNum, completedLevel: completedLevel) { (success, err) in
            print(err)
        }
    }

    //MARK:- Actions
    @IBAction func next(_ sender: Any) {
        passReportData()
        
        //.............................. don't forget to move to another scene
        
    }
    

}
