//
//  GoalService.swift
//  Lafeef
//
//  Created by Mihaf on 11/08/1442 AH.
//


import UIKit
class GoalService {
    func goal(levelNum:String) -> BackeryViewController {
        let storyboard = UIStoryboard(name: "Challenge", bundle: nil)
        let Vc = storyboard.instantiateViewController(identifier: Constants.Storyboard.backery) as BackeryViewController
 
        Vc.levelNum = levelNum
        return Vc
      }
    
  
}
