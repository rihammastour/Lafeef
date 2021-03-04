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
    
    // to convert into Arabic
    let formatter: NumberFormatter = NumberFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        setCustomerSatisfaction(happy: 2, normal: 3, sad: 3)
        //set score
        setScore(score: 3)
        // set money
        setMoney(money:4)
    }
    


    @IBAction func playAgain(_ sender: Any) {
        // need some code
        GameScene.timeLeft = 30
     
    }
    
    @IBAction func cancel(_ sender: Any) {
       // navogate to level screen 
    }
    func setCustomerSatisfaction(happy: Int, normal: Int,sad: Int)  {
        
        normalLabel.text = formatter.string(from:normal as NSNumber)
        happyLabel.text = formatter.string(from:happy as NSNumber)
        sadLabel.text = formatter.string(from:sad as NSNumber)

    }
    
    func setScore(score:Int)  {
        scoreLabel.text = formatter.string(from:score as NSNumber)! + " نقطة "
        starView.rating = Double(score)
        
        
            }

   func setMoney(money:Int)  {
    moneyLabel.text = formatter.string(from:money as NSNumber)! +  " ريال "
        }
    
  
}
