//
//  TrainingSectionViewController.swift
//  Lafeef
//
//  Created by Raghad alfuhaid on 21/08/1442 AH.
//

import Foundation
import UIKit
class TrainingSectionViewController: UIViewController {
    
    static var sectionType="colors"
    
    override func viewDidLoad() {
    let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
            backgroundImage.image = UIImage(named: "Training-Background")
            backgroundImage.contentMode = UIView.ContentMode.scaleToFill
            self.view.insertSubview(backgroundImage, at: 0)
            
            view.backgroundColor = UIColor(white: 1, alpha: 0.5)
    }
    
    @IBAction func colorSection(_ sender: Any) {
        TrainingSectionViewController.sectionType="colors"
        goToTrainingBoard()
    }
    
    @IBAction func shapeSection(_ sender: Any) {
        TrainingSectionViewController.sectionType="shapes"
        goToTrainingBoard()
    }
    
    
    @IBAction func calculateSection(_ sender: Any) {
        
        TrainingSectionViewController.sectionType="calculations"
        
        goToTrainingBoard()
    }
    
    func goToTrainingBoard(){
    print("display")
            let storyboard = UIStoryboard(name: "TrainingSection", bundle: nil)
        let goalVC = storyboard.instantiateViewController(withIdentifier:Constants.Storyboard.TrainingBoardViewController) as! TrainingBoardViewController
    
            self.present(goalVC, animated: true)
        
    }
    
}
