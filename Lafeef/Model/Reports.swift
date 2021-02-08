//
//  Reports.swift
//  Lafeef
//
//  Created by Mihaf on 26/06/1442 AH.
//
import UIKit
class Reports {
    func displayWinningReport() ->  WinningViewController {
        let storyboard = UIStoryboard(name: "MihafReports", bundle: nil)
        let AlertVc = storyboard.instantiateViewController(identifier: "win") as WinningViewController
      
//        AlertVc.body = body
        return AlertVc
      }
    func displayLossingRepor() ->  LossingViewController {
        let storyboard = UIStoryboard(name: "MihafReports", bundle: nil)
        let AlertVc = storyboard.instantiateViewController(identifier: "lose") as LossingViewController
      
//        AlertVc.body = body
        return AlertVc
      }
  
}
