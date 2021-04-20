//
//  ManageViewController.swift
//  Lafeef
//
//  Created by Renad nasser on 13/04/2021.
//

import Foundation
protocol ManageViewController {

    var levelNum : String! {get set}
    
    func presentAdvReport()
    
    func showGoalMessage()
    
    func startGame(with advAmount:Float, for adv:Int)
        
    func displayDailyReport(_ report:DailyReport)
        
    func displayWainningReport(_ report:DailyReport)
    
    func displayNormalReport(_ report:DailyReport)
    
    func displayLosingReport(_ report:DailyReport)
    
    func exitPlayChallengeMode()
    
    func exitPlaying()
    
    
}
