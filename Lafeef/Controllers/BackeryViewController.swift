//
//  BackeryViewController.swift
//  Lafeef
//
//  Created by Mihaf on 11/08/1442 AH.
//

import UIKit

class BackeryViewController: UIViewController {

    var levelNum:String!
    var goalService = GoalService()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Set bakery Background
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "calendarBackground")
        backgroundImage.contentMode = UIView.ContentMode.scaleToFill
        self.view.insertSubview(backgroundImage, at: 0)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            
            self.setlevelLabel()
        }
  
    }
    func setlevelLabel(){
            self.performSegue(withIdentifier: Constants.Segue.levelGoal, sender: self)
          
    }
    
    //MARK: - prepare seque
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! LevelGoalViewController
        destinationVC.levelNum =  levelNum
    }
 

}
