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
    var randomNum = 0
    var advType: String = ""
    var challeangeVC = ChallengeViewController()
    let levelGoal = LevelGoalViewController()
    let sound = SoundManager()
    var levelNum:String!
    
    //outlets
    @IBOutlet weak var advReportView: UIView!    
    @IBOutlet weak var animationView: AnimationView!
    @IBOutlet weak var advImage: UIImageView!
    @IBOutlet weak var accept: UIButton!
    @IBOutlet weak var reject: UIButton!
    @IBOutlet weak var advAmount: UILabel!
    var delagte : ManageViewController!
    
    //MARK:- Life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        sound.playSound(sound: Constants.Sounds.advertisment)
        
        // Do any additional setup after loading the view.
        styleUI()
        animateStars()
        setUpAdv()
        UpdateAdvCounter()
        
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
        randomNum = Int(arc4random_uniform(_:2)) + 1
        storageManger.downloadImage(randPath: randomNum) {(image, err) in
            self.advImage.image = image
            
            if  self.randomNum == 1 {
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
    
    //MARK: - IBAction
    
    @IBAction func acceptButtonTapped(_ sender: Any) {
        ObjectDetectionViewController.detectionOverlay.isHidden = true
        
        let advAmountStr = self.advAmount.text!.convertedDigitsToLocale(Locale(identifier: "EN"))
        
        let advAmount  = self.convertStringToInt(str: advAmountStr)
        
        dismiss(animated: true) {
            self.delagte.startGame(with: Float(advAmount),for: self.randomNum)
            
        }
    }
    
    @IBAction func rejectButtonTapped(_ sender: Any) {
        ObjectDetectionViewController.detectionOverlay.isHidden = true
        
        dismiss(animated: true) {
            self.delagte.startGame(with: 0,for: 0)
            
        }
    }
    

    
    
    func UpdateAdvCounter(){
        let defaults = UserDefaults.standard
        var levelTwoCount = UserDefaults.standard.integer(forKey: "levelTwoCount")
        var levelFourCount = UserDefaults.standard.integer(forKey: "levelFourCount")
        
        if levelNum == "2"{
            levelTwoCount = 1
        }else  if levelNum == "4"{
            levelFourCount = 1
        }
        defaults.set(levelTwoCount, forKey: "levelTwoCount")
        defaults.set(levelFourCount, forKey: "levelFourCount")
    }
    
}
