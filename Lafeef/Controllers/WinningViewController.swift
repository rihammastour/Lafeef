//
//  WinningViewController.swift
//  Lafeef
//
//  Created by Mihaf on 26/06/1442 AH.
//

import UIKit
import Lottie
import Cosmos

class WinningViewController: UIViewController {
    
    var challeangeReport = ChallengeViewController()
    var delagate:ManageViewController!
    var report:DailyReport!
  
    @IBOutlet weak var Winning: UIView!
    
    // customer satisfaction
    @IBOutlet weak var rewardView: UIView!
    @IBOutlet weak var sadLabel: UILabel!
    @IBOutlet weak var happyLabel: UILabel!
    @IBOutlet weak var normalLabel: UILabel!
    // animation trophy
    @IBOutlet weak var trophyView: AnimationView!
    // star rate
    @IBOutlet weak var starView: CosmosView!
    
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var smallBackground: UIView!
    @IBOutlet weak var moneyLabel: UILabel!
    @IBOutlet weak var moneyView: UIView!
    @IBOutlet weak var scoreView: UIView!
    @IBOutlet weak var cancelOutlet: UIButton!
    @IBOutlet weak var nextDayOutlet: UIButton!
   
   // to convert into Arabic
   let formatter: NumberFormatter = NumberFormatter()
    let toChangeLevel: DailyReportViewController? = nil
    let  sound = SoundManager()
  
    
  
    override func viewDidLoad() {
        super.viewDidLoad()
        sound.playSound(sound: Constants.Sounds.reward)
        formatter.locale = NSLocale(localeIdentifier: "ar") as Locale?
        // front end
        smallBackground.layer.cornerRadius = 20
    
        Winning.layer.cornerRadius = 30
        cancelOutlet.layer.cornerRadius = cancelOutlet.frame.size.height/2
        nextDayOutlet.layer.cornerRadius = nextDayOutlet.frame.size.height/2
        scoreView.layer.cornerRadius = 20
        rewardView.layer.cornerRadius = 20
        moneyView.layer.cornerRadius = 20
        smallBackground.layer.shadowColor = UIColor.black.cgColor
        smallBackground.layer.shadowOpacity = 0.2
        smallBackground.layer.shadowOffset = .zero
        smallBackground.layer.shadowRadius = 5
        
        // trophy animation
        trophyView!.frame = view.bounds
        trophyView!.contentMode = .scaleAspectFit
        trophyView!.loopMode = .loop
        trophyView!.animationSpeed = 0.5
        trophyView!.play()
        

        // star rates
        starView.settings.updateOnTouch = false
        starView.settings.fillMode = .full
        starView.settings.starMargin = 0
        starView.settings.emptyBorderWidth = 2
        starView.settings.filledBorderColor = UIColor.yellow
        starView.settings.filledColor = UIColor.yellow
        starView.settings.emptyBorderColor = UIColor.yellow
        starView.settings.starSize = 18
        
        // set customer satisfaction
        setCustomerSatisfaction()
        //set score
        setScore(score: Int(report.collectedScore))
        // set money
        setMoney(money:report.collectedMoney)
        
        if report.levelNum == "4"{
            nextDayOutlet.isHidden = true
        cancelOutlet.frame.size = CGSize(width: 280, height: 60)
        
    }
    }
    @IBAction func nextDay(_ sender: Any) {
        
        if report.levelNum != "4"{
            let  levelnum = 1 + ( Int(report.levelNum) ?? 0 )
            delagate.levelNum = "\(levelnum)"
            dismiss(animated: true) {
                self.delagate.showGoalMessage()
            }
        }else{
            self.dismiss(animated: true) {
                self.delagate.exitPlayChallengeMode()
            }
        }
    }
    @IBAction func cancel(_ sender: Any) {
        self.dismiss(animated: true) {
            self.delagate.exitPlayChallengeMode()
        }
    }
    
    func setCustomerSatisfaction()  {
        var happy = 0
        var sad = 0
        var normal = 0
        
        for sat in  report.customerSatisfaction{
            switch sat{
            case .happey:
                happy += 1
                break
            case .sad:
                sad += 1
                break
            default:
                normal += 1
            }
        }
        normalLabel.text = formatter.string(from:normal as NSNumber)
        happyLabel.text = formatter.string(from:happy as NSNumber)
        sadLabel.text = formatter.string(from:sad as NSNumber)

    }
    func setScore(score:Int)  {
        scoreLabel.text = formatter.string(from:score as NSNumber)! + " نقطة "
        if (score >= 0 && score <= 20){
            starView.rating = 1
        }else if  (score >= 21 && score <= 40){
            starView.rating = 2
        }else if  (score >= 41 && score <= 60){
            starView.rating = 3
        }else if  (score >= 61 && score <= 80){
            starView.rating = 4
        }else{ starView.rating = 5}

            }

   func setMoney(money:Float)  {
    moneyLabel.text = formatter.string(from:money as NSNumber)! +  " ريال "
        }
        
      

}
