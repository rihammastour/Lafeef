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
    
    var report : DailyReport!
    // customer satisfaction
    @IBOutlet weak var sadLabel: UILabel!
    @IBOutlet weak var happyLabel: UILabel!
    @IBOutlet weak var normalLabel: UILabel!
    // animation trophy
    @IBOutlet weak var trophyView: AnimationView!
    // star rate
    @IBOutlet weak var starView: CosmosView!
    
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var winningView: UIView!
    @IBOutlet weak var smallBackground: UIView!
    @IBOutlet weak var moneyLabel: UILabel!
    @IBOutlet weak var moneyView: UIView!
    @IBOutlet weak var scoreView: UIView!
    @IBOutlet weak var cancelOutlet: UIButton!
    @IBOutlet weak var nextDayOutlet: UIButton!
   
   // to convert into Arabic
   let formatter: NumberFormatter = NumberFormatter()
    let toChangeLevel: DailyReportViewController? = nil
  
    
  
    override func viewDidLoad() {
        super.viewDidLoad()
        formatter.locale = NSLocale(localeIdentifier: "ar") as Locale?
        // front end
        smallBackground.layer.cornerRadius = 20
        winningView.layer.cornerRadius = 30
        cancelOutlet.layer.cornerRadius = cancelOutlet.frame.size.height/2
        nextDayOutlet.layer.cornerRadius = nextDayOutlet.frame.size.height/2
        scoreView.layer.cornerRadius = 20
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
        starView.settings.starSize = 22
        
        // set customer satisfaction
//        setCustomerSatisfaction(happy: report.happyFaces, normal: report.normalFaces, sad: report.sadFaces)
        //set score
        setScore(score: Int(report.collectedScore))
        // set money
        setMoney(money:report.collectedMoney)
        
    }
    
    @IBAction func nextDay(_ sender: Any) {
        var  levelnum = Int(report.levelNum!)
        levelnum! += 1
       report.levelNum = String(levelnum!)
        navigationController?.popViewController(animated: true)

    }
    @IBAction func cancel(_ sender: Any) {
        navigationController?.popViewController(animated: true)
        //
    }
    
    func setCustomerSatisfaction(happy: Int, normal: Int,sad: Int)  {

        normalLabel.text = formatter.string(from:normal as NSNumber)
        happyLabel.text = formatter.string(from:happy as NSNumber)
        sadLabel.text = formatter.string(from:sad as NSNumber)

        
    }
    
    func setScore(score:Int)  {
        scoreLabel.text = formatter.string(from:score as NSNumber)! + " نقطة "
        starView.rating = Double(score*100)/5

            }

   func setMoney(money:Float)  {
    moneyLabel.text = formatter.string(from:money as NSNumber)! +  " ريال "
        }
        
      

}
