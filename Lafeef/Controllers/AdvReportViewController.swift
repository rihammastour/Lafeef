//
//  AdvReportViewController.swift
//  Lafeef
//
//  Created by Riham Mastour on 28/06/1442 AH.
//

import UIKit
import Lottie

class AdvReportViewController: UIViewController {
    
    //MARK:- Proprities
    //variables
    let storageManger = FirebaseRequest()
    static var randomNum = 0
    var advType: String = ""
    var child = Child()
    var challeangeVC = ChallengeViewController()
    let levelGoal = LevelGoalViewController()
    let  sound = SoundManager()
    
    //outlets
    @IBOutlet weak var advReportView: UIView!    
    @IBOutlet weak var animationView: AnimationView!
    @IBOutlet weak var advImage: UIImageView!
    @IBOutlet weak var accept: UIButton!
    @IBOutlet weak var reject: UIButton!
    @IBOutlet weak var advAmount: UILabel!
    var  scene : GameScene!
    
    //MARK:- Life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        sound.playSound(sound: Constants.Sounds.advertisment)
        
        // Do any additional setup after loading the view.
        styleUI()
        animateStars()
        setUpAdv()
        
    }
    
    //MARK:- Functions
    
    // Styling UI
    func styleUI(){
        advReportView.layer.cornerRadius = 30
        advImage.layer.cornerRadius = 30
        Utilities.styleFilledButton(accept, color: "GreenApp")
        Utilities.styleFilledButton(reject, color: "RedApp")
    }
    
    func animateStars(){
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.animationSpeed = 0.5
        animationView.play()
    }
    
    // Setup Advertisment
    func setUpAdv(){
        // 0 to (param - 1)
        AdvReportViewController.randomNum = Int(arc4random_uniform(_:2)) + 1
        storageManger.downloadImage(randPath: AdvReportViewController.randomNum) {(image, err) in
            self.advImage.image = image
            if AdvReportViewController.randomNum == 1 {
                self.advAmount.text = "٢٠٠"
                self.advType = "ice-cream"
            } else {
                self.advAmount.text = "٢٥٠"
                self.advType = "juice"
            }
        }
    }
    
    func convertStringToInt(str: String) -> Int{
        if let value = Int(str) {
            return value
        }
        return 0
    }
    
    //MARK:- Actions
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        ObjectDetectionViewController.detectionOverlay.isHidden = true
        let destinationVC = segue.destination as! DailyReportViewController
        if (segue.identifier == Constants.Segue.acceptAdvSegue) {
            // Text processing
            let advAmountStr = self.advAmount.text!.convertedDigitsToLocale(Locale(identifier: "EN"))
            let advAmount  = self.convertStringToInt(str: advAmountStr)
           
//            destinationVC.advertismentAmount = advAmount
            
            //TODO: Add money to wallet in top bar & firestore
            child.money += Float(advAmount)
            LevelGoalViewController.report.advertismentAmount = Float(advAmount)
            
            //Present Adv in bakery env
            challeangeVC.showAdvOnBakery()

            dismiss(animated: true) {
                self.scene.startGame()
                
            }
        }
        if (segue.identifier == Constants.Segue.rejectAdvSegue) {
//            destinationVC.advertismentAmount = 0
            dismiss(animated: true) {
                self.scene.startGame()
                
            }
        }
        UpdateAdvCounter()
       

        }


func UpdateAdvCounter(){
    let defaults = UserDefaults.standard
    var levelTwoCount = UserDefaults.standard.integer(forKey: "levelTwoCount")
    var levelFourCount = UserDefaults.standard.integer(forKey: "levelFourCount")

    
    if LevelGoalViewController.report.levelNum == "2"{
        levelTwoCount = 1
    }else  if LevelGoalViewController.report.levelNum == "4"{
        levelFourCount = 1
    }
    defaults.set(levelTwoCount, forKey: "levelTwoCount")
    defaults.set(levelFourCount, forKey: "levelFourCount")
}
   
}
