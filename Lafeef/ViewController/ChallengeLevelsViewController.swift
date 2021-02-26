//
//  ChallengeLevelsViewController.swift
//  Lafeef
//
//  Created by Renad nasser on 28/01/2021.
//

import UIKit

class ChallengeLevelsViewController: UIViewController {

    //MARK: - Proprites
    
    //Buttons
    @IBOutlet weak var levelOneButton: UIButton!
    
    //MARK: - Life cycle functions
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    //MARK: - Functions
    
    //MARK: - Actions, Elements Tapped
    @IBAction func goBackTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    

    @IBAction func levelOneTapped(_ sender: Any) {

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.Segue.challengeSegue {
            let vc = segue.destination as! ChallengeViewController
                        print("Segue proformed")
            vc.levelNum = "1"
            GameScene.circleDecrement=true

            
        }
    }
 
    
}
