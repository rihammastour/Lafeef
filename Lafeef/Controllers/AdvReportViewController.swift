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
    var advType: String = ""
    var child = Child()
    
    //outlets
    @IBOutlet weak var advReportView: UIView!    
    @IBOutlet weak var animationView: AnimationView!
    @IBOutlet weak var advImage: UIImageView!
    @IBOutlet weak var accept: UIButton!
    @IBOutlet weak var reject: UIButton!
    @IBOutlet weak var advAmount: UILabel!
    
    //MARK:- Life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        let randomNum = Int(arc4random_uniform(_:2)) + 1
        storageManger.downloadImage(randPath: randomNum) {(image, err) in
            self.advImage.image = image
            if randomNum == 1 {
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
        let destinationVC = segue.destination as! DailyReportViewController
        if (segue.identifier == Constants.Segue.acceptAdvSegue) {
            // Text processing
            let advAmountStr = self.advAmount.text!.convertedDigitsToLocale(Locale(identifier: "EN"))
            let advAmount  = self.convertStringToInt(str: advAmountStr)
           
            destinationVC.advertismentAmount = advAmount
            
            //TODO: Add money to wallet in top bar & firestore
            child.money += Float(advAmount)

            present(destinationVC, animated: true) {
                print("successfully present daily report")
            }
        }
        if (segue.identifier == Constants.Segue.rejectAdvSegue) {
            destinationVC.advertismentAmount = 0
            present(destinationVC, animated: true) {
                print("successfully present daily report")
            }
        }
    }
}
