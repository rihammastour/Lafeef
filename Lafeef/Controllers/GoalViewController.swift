//
//  GoalViewController.swift
//  Lafeef
//
//  Created by Mihaf on 07/09/1442 AH.
//

import UIKit

class GoalViewController: UIViewController {
    @IBOutlet weak var okbutton: UIButton!
    @IBOutlet weak var goalView: UIView!
    @IBOutlet weak var goalLabel: UILabel!
    var delegate : ManageViewController?
    var levelNum:String = ""
    var body :String = ""
        static var report = DailyReport(levelNum: "1", ingredientsAmount: 20, salesAmount: 0, backagingAmount: 20, advertismentAmount: 0, collectedScore: 0, collectedMoney: 0, isPassed: false, isRewarded: false, reward: 0, customerSatisfaction:[])


        //MARK:- LifeCicle Functions
        override func viewDidLoad() {
            super.viewDidLoad()
            setUIElments()
        }
        
        //MARK: - Set UI Elements
        
        func setUIElments(){
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
            goalLabel.text = "هدف المستوى الأول| ٦٠ نقطة "
            LevelGoalViewController.report.levelNum = "1"
        }else if  levelNum == "2"{
            goalLabel.text = "هدف المستوى الثاني | ٧٠ نقطة "
        }else if levelNum == "3"{
            LevelGoalViewController.report.levelNum = "3"
            goalLabel.text = "هدف المستوى الثالث | ٨٠ نقطة "
        }else{
            LevelGoalViewController.report.levelNum = "4"
            goalLabel.text = "هدف المستوى الرابع | ٩٠ نقطة "
        }

    }
        


    //MARK: - @IBAction
        @IBAction func ok(_ sender: Any) {
            self.dismiss(animated: true,completion:{
                self.delegate?.startGame(with: 0,for: 0)
                
            })
        }
        
        
    }

