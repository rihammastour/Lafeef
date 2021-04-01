//
//  LossingViewController.swift
//  Lafeef
//
//  Created by Mihaf on 26/06/1442 AH.
//

import UIKit
import SwiftGifOrigin
import Cosmos

class LosingViewController: UIViewController {
    // customer satisfaction
    @IBOutlet weak var happyLabel: UILabel!
    @IBOutlet weak var normalLabel: UILabel!
    @IBOutlet weak var sadLabel: UILabel!
    var challeangeReport = ChallengeViewController()

    
    
    

 
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var moneyLabel: UILabel!
    @IBOutlet weak var starView: CosmosView!
    @IBOutlet weak var smallbackground: UIView!
    @IBOutlet weak var lossingView: UIView!
    @IBOutlet weak var icecream: UIImageView!
    @IBOutlet weak var scoreView: UIView!
    @IBOutlet weak var moneyView: UIView!
    @IBOutlet weak var cancelOutlet: UIButton!
    @IBOutlet weak var playAgainOutlet: UIButton!
    let  sound = SoundManager()
    
    
    // to convert into Arabic
    let formatter: NumberFormatter = NumberFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sound.playSound(sound: Constants.Sounds.tryAgain)
        formatter.locale = NSLocale(localeIdentifier: "ar") as Locale?
        
        smallbackground.layer.cornerRadius = 20 
        lossingView.layer.cornerRadius = 30
        cancelOutlet.layer.cornerRadius = cancelOutlet.frame.size.height/2
        playAgainOutlet.layer.cornerRadius = playAgainOutlet.frame.size.height/2
        scoreView.layer.cornerRadius = 20
        moneyView.layer.cornerRadius = 20
        smallbackground.layer.shadowColor = UIColor.black.cgColor
        smallbackground.layer.shadowOpacity = 0.2
        smallbackground.layer.shadowOffset = .zero
        smallbackground.layer.shadowRadius = 5
        

        icecream.image = UIImage.gif(name: "icecream")
        
        // star rates
        starView.settings.updateOnTouch = false
        starView.settings.fillMode = .full
        starView.settings.starMargin = 0
        starView.settings.emptyBorderWidth = 2
        starView.settings.filledBorderColor = UIColor.yellow
        starView.settings.filledColor = UIColor.yellow
        starView.settings.emptyBorderColor = UIColor.yellow
        starView.rating = 3
        //score/5
        starView.settings.starSize = 22
        
        // set customer satisfaction
   
            
            self.setCustomerSatisfaction()
            //set score
            self.setScore(score:( LevelGoalViewController.report.collectedScore))
            // set money
        self.setMoney(money:( LevelGoalViewController.report.collectedMoney))
      
        
       
    }
    


    @IBAction func playAgain(_ sender: Any) {
        
        // need some code
        GameScene.timeLeft = 30
        
        self.performSegue(withIdentifier: "playAgain", sender: self)

  
     
     
    }
    
    @IBAction func cancel(_ sender: Any) {
        self.performSegue(withIdentifier: "showCalendar", sender: self)

        
    }
    
    func setCustomerSatisfaction()  {
        
        print("inside customer")
        print(LevelGoalViewController.report.customerSatisfaction)
        var happy = 0
        var sad = 0
        var normal = 0
        
        for sat in  LevelGoalViewController.report.customerSatisfaction{
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
    
    func setScore(score:Float)  {
        scoreLabel.text = formatter.string(from:score as NSNumber)! + " نقطة "
        if( score == 0){
            starView.rating = 0
        }else if (score > 0 && score <= 20){
            starView.rating = 1
        }else if(score >= 21 && score <= 40){
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
