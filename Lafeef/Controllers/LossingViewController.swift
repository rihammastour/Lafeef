//
//  LossingViewController.swift
//  Lafeef
//
//  Created by Mihaf on 26/06/1442 AH.
//

import UIKit
import SwiftGifOrigin

class LossingViewController: UIViewController {
    // customer satisfaction
    @IBOutlet weak var happyLabel: UILabel!
    @IBOutlet weak var normalLabel: UILabel!
    @IBOutlet weak var sadLabel: UILabel!
    
    

    @IBOutlet weak var smallbackground: UIView!
    @IBOutlet weak var lossingView: UIView!
    @IBOutlet weak var icecream: UIImageView!
   
    @IBOutlet weak var scoreView: UIView!
    @IBOutlet weak var moneyView: UIView!
    @IBOutlet weak var cancelOutlet: UIButton!
    @IBOutlet weak var playAgainOutlet: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        smallbackground.layer.cornerRadius = 20 
        lossingView.layer.cornerRadius = 30
        cancelOutlet.layer.cornerRadius = cancelOutlet.frame.size.height/2
        playAgainOutlet.layer.cornerRadius = playAgainOutlet.frame.size.height/2
        scoreView.layer.cornerRadius = 20
        moneyView.layer.cornerRadius = 20
        
        smallbackground.layer.shadowColor = UIColor.black.cgColor
        smallbackground.layer.shadowOpacity = 0.3
        smallbackground.layer.shadowOffset = .zero
        smallbackground.layer.shadowRadius = 10
        

        icecream.image = UIImage.gif(name: "icecream")
        
 

    }
    
    

    @IBAction func playAgain(_ sender: Any) {
        // need some code
    }
    
    @IBAction func cancel(_ sender: Any) {
       // navogate to level screen 
    }
}
