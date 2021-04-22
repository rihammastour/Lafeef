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
    let sound = SoundManager()
    
    //MARK: - LifeCycle

    override func viewDidLoad() {
    let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
            backgroundImage.image = UIImage(named: "Training-Background")
            backgroundImage.contentMode = UIView.ContentMode.scaleToFill
            self.view.insertSubview(backgroundImage, at: 0)
            
            view.backgroundColor = UIColor(white: 1, alpha: 0.5)
    }
    
    //MARK: - IBAction
    @IBAction func colorSection(_ sender: Any) {
        TrainingSectionViewController.sectionType="colors"
        sound.playSound(sound: Constants.Sounds.learColors)

        DispatchQueue.main.asyncAfter(deadline: .now()+1) {
            self.goToTrainingBoard()
        }
    
    }
    
    @IBAction func shapeSection(_ sender: Any) {
        TrainingSectionViewController.sectionType="shapes"
        sound.playSound(sound: Constants.Sounds.learnShapes)
        DispatchQueue.main.asyncAfter(deadline: .now()+1) {
            self.goToTrainingBoard()
        }
    }
    
    
    @IBAction func calculateSection(_ sender: Any) {
        TrainingSectionViewController.sectionType="calculations"
        sound.playSound(sound: Constants.Sounds.learnMath)
        DispatchQueue.main.asyncAfter(deadline: .now()+1) {
            self.goToTrainingBoard()
        }
    }
    
    @IBAction func bcakTapped(_ sender: Any) {
        if let navigationController = self.navigationController {
            navigationController.popViewController(animated: true)
        }
    }
    
    //MARK:- Functions
    
    func goToTrainingBoard(){
    print("display")
            let storyboard = UIStoryboard(name: "TrainingSection", bundle: nil)
        let goalVC = storyboard.instantiateViewController(withIdentifier:Constants.Storyboard.TrainingBoardViewController) as! TrainingBoardViewController
    
        self.navigationController?.pushViewController(goalVC, animated: true)
        
    }
    

}
