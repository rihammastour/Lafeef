//
//  GoalViewController.swift
//  Lafeef
//
//  Created by Mihaf on 29/07/1442 AH.
//

import UIKit
import Lottie
class GoalViewController: UIViewController {

    @IBOutlet weak var goal: UIView!
    @IBOutlet weak var animationGoal: AnimationView!
    override func viewDidLoad() {
        super.viewDidLoad()
        animationGoal!.frame = view.bounds
        animationGoal!.contentMode = .scaleAspectFit
        animationGoal!.loopMode = .loop
        animationGoal!.animationSpeed = 0.5
        animationGoal!.play()
        goal.layer.cornerRadius = 30 
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
