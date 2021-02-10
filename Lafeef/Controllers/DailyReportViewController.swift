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
        
        styleUI()
        hideAdv()
        calcultateIncome()
        convertLabelsToArabic()
    }
    
    
    //MARK:- Functions
    
    // Styling UI
    func styleUI(){
        dailyReportView.layer.cornerRadius = 30
        Utilities.styleFilledButton(nextButton, color: "blueApp")
    }
    
    func hideAdv(){
        let advAmount = self.convertUILabelToInt(label: self.advAmount)
        if advAmount == 0 {
            adv.isHidden = true
        }
    }
    
    func convertLabelsToArabic(){
        sales.text = sales.text?.convertedDigitsToLocale(Locale(identifier: "AR"))
        ingredients.text = ingredients.text?.convertedDigitsToLocale(Locale(identifier: "AR"))
        backaging.text = backaging.text?.convertedDigitsToLocale(Locale(identifier: "AR"))
        advAmount.text = advAmount.text?.convertedDigitsToLocale(Locale(identifier: "AR"))
    }
    
    // Caluctate Income
    func calcultateIncome(){
        let sales = self.convertUILabelToInt(label: self.sales)
        let ingredients = self.convertUILabelToInt(label: self.ingredients)
        let backaging = self.convertUILabelToInt(label: self.backaging)
        let advAmount = self.convertUILabelToInt(label: self.advAmount)
        let incomeDigit = "\(sales - ingredients - backaging + advAmount)"
        income.text = incomeDigit.convertedDigitsToLocale(Locale(identifier: "AR"))
    }
    
    func convertUILabelToInt(label: UILabel) -> Int{
        if let text = label.text, let value = Int(text) {
            return value
        }
        return 0
    }

    //MARK:- Actions
    @IBAction func next(_ sender: Any) {
        // if max score, display reward Screen
        // if min score, display lose Screen
        // display next level
        
    }
    

}
