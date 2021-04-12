//
//  LevelGoalViewController.swift
//  Lafeef
//
//  Created by Mihaf on 29/07/1442 AH.
//

import UIKit
import Lottie

class LevelGoalViewController: UIViewController {
    @IBOutlet weak var okbutton: UIButton!
    @IBOutlet weak var goalView: UIView!
    @IBOutlet weak var levelLabel: UILabel!
 
    var levelNum:String = ""
    var body :String = ""
    static var report = DailyReport(levelNum: "1", ingredientsAmount: 20, salesAmount: 0, backagingAmount: 20, advertismentAmount: 0, collectedScore: 0, collectedMoney: 0, isPassed: false, isRewarded: false, reward: 0, customerSatisfaction:[])

    override func viewDidLoad() {
        super.viewDidLoad()
        goalView.layer.cornerRadius = 30
        goalView.layer.shadowColor = UIColor.black.cgColor
        goalView.layer.shadowOpacity = 0.2
        goalView.layer.shadowOffset = .zero
        goalView.layer.shadowRadius = 5
        okbutton.layer.cornerRadius = okbutton.frame.size.height/2
 
        setlevelGoal()
  
    }
   func setlevelGoal(){
    if levelNum == "1"{
        levelLabel.text = "هدف المستوى الأول| ٥٠ نقطة "
        LevelGoalViewController.report.levelNum = "1"
    }else if  levelNum == "2"{
        levelLabel.text = "هدف المستوى الثاني | ٦٠ نقطة "
    }else if levelNum == "3"{
        LevelGoalViewController.report.levelNum = "3"
        levelLabel.text = "هدف المستوى الثالث | ٧٠ نقطة "
    }else{
        LevelGoalViewController.report.levelNum = "4"
        levelLabel.text = "هدف المستوى الرابع | ٨٠ نقطة "
    }

}


    @IBAction func ok(_ sender: Any) {
        self.performSegue(withIdentifier: Constants.Segue.challeange, sender: self)
    }
}
