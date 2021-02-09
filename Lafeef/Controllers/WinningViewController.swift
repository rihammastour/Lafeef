//
//  WinningViewController.swift
//  Lafeef
//
//  Created by Mihaf on 26/06/1442 AH.
//

import UIKit

class WinningViewController: UIViewController {
    // customer satisfaction
    @IBOutlet weak var sadLabel: UILabel!
    @IBOutlet weak var happyLabel: UILabel!
    @IBOutlet weak var normalLabel: UILabel!
    
    
    
    @IBOutlet weak var winningView: UIView!
    @IBOutlet weak var smallBackground: UIView!
    @IBOutlet weak var moneyView: UIView!
    @IBOutlet weak var scoreView: UIStackView!
    @IBOutlet weak var cancelOutlet: UIButton!
    @IBOutlet weak var nextDayOutlet: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        smallBackground.layer.cornerRadius = 20
        winningView.layer.cornerRadius = 30
        cancelOutlet.layer.cornerRadius = cancelOutlet.frame.size.height/2
        nextDayOutlet.layer.cornerRadius = nextDayOutlet.frame.size.height/2
        scoreView.layer.cornerRadius = 20
        moneyView.layer.cornerRadius = 20
        
        smallBackground.layer.shadowColor = UIColor.black.cgColor
        smallBackground.layer.shadowOpacity = 0.3
        smallBackground.layer.shadowOffset = .zero
        smallBackground.layer.shadowRadius = 10
        

      
    }
    
    @IBAction func nextDay(_ sender: Any) {
    }
    
    @IBAction func cancel(_ sender: Any) {
    }
    
}
