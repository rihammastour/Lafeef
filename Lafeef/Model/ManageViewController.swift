//
//  ManageViewController.swift
//  Lafeef
//
//  Created by Renad nasser on 13/04/2021.
//

import Foundation
protocol ManageViewController {

    //var someVariable : String {get set}

    func startGame()
    
    func displayDailyReport(_ report:DailyReport)
    
    func displayPauseMenue()
    
    func presentAdvReport()
}
