//
//  Reports.swift
//  Lafeef
//
//  Created by Mihaf on 26/06/1442 AH.
//
import UIKit
class Reports {
//    func displayWinningReport() ->  WinningViewController {
//        let storyboard = UIStoryboard(name: "MihafReports", bundle: nil)
//        let AlertVc = storyboard.instantiateViewController(identifier: "win") as WinningViewController
//
//        return AlertVc
//      }
//    func displayLossingReport() ->  LossingViewController {
//        let storyboard = UIStoryboard(name: "MihafReports", bundle: nil)
//        let AlertVc = storyboard.instantiateViewController(identifier: "lose") as LossingViewController
//
//        return AlertVc
//      }
    
    func displayDailyReport() ->  DailyReportViewController {
        let storyboard = UIStoryboard(name: "DailyAdvReports", bundle: nil)
        let report = storyboard.instantiateViewController(identifier: "DailyReport") as DailyReportViewController
      
        return report
      }
  
}
