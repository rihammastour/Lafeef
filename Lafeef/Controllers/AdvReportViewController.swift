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
    //......
    
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
    }
    
    //MARK:- Functions
    
    // Styling UI
    func styleUI(){
        advReportView.layer.cornerRadius = 30
        Utilities.styleFilledButton(accept, color: "GreenApp")
        Utilities.styleFilledButton(reject, color: "RedApp")
        //TODO: Setup adv image randomly
    }
    
    func animateStars(){
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.animationSpeed = 0.5
        animationView.play()
    }

    //MARK:- Actions
    @IBAction func acceptAdv(_ sender: Any) {
        //TODO: send advAmount to daily report
    }
    
    @IBAction func rejectAdv(_ sender: Any) {
        //TODO: send advAmount 0 to daily report
    }
    
}
