//
//  LevelGoalViewController.swift
//  Lafeef
//
//  Created by Mihaf on 29/07/1442 AH.
//

import UIKit
import Lottie

class LevelGoalViewController: UIViewController {
    var challeangeVC = ChallengeViewController()


    @IBOutlet weak var okbutton: UIButton!
    @IBOutlet weak var goalView: UIView!
    @IBOutlet weak var points: UILabel!
    @IBOutlet weak var levelLabel: UILabel!
    var  scene : GameScene!

    override func viewDidLoad() {
        super.viewDidLoad()
        goalView.layer.cornerRadius = 30
        goalView.layer.shadowColor = UIColor.black.cgColor
        goalView.layer.shadowOpacity = 0.2
        goalView.layer.shadowOffset = .zero
        goalView.layer.shadowRadius = 5
        okbutton.layer.cornerRadius = okbutton.frame.size.height/2
        
      setlevelLabel()
    }
    
    func setlevelLabel(){
        if challeangeVC.report.levelNum == "1"{
            levelLabel.text = "هدف المستوى الأول |"
            points.text = "٥٠ نقطة "
            
        }else if challeangeVC.report.levelNum == "2"{
            levelLabel.text = "هدف المستوى الثاني| "
            points.text = "٦٠ نقطة "
            
        }else if challeangeVC.report.levelNum == "3"{
            levelLabel.text = "هدف المستوى الثالث|"
            points.text = "٦٠ نقطة "
            
        }else{
            levelLabel.text = "هدف المستوى الرابع |"
            points.text = "٧٠ نقطة "
            
        }
    }


    @IBAction func ok(_ sender: Any) {
      
        dismiss(animated: true)
        challeangeVC.presentAdvReport()
        if ChallengeViewController.levelNum == "2" || ChallengeViewController.levelNum == "4" {
            DispatchQueue.main.asyncAfter(deadline: .now()+1) {
                self.challeangeVC.presentAdvReport()
                
            }
        } else{
            scene?.startGame()
        }


             
    }
}
