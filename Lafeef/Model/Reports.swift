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

        return AlertVc
      }
    func displayLossingReport() ->  LosingViewController {
        let storyboard = UIStoryboard(name: "MihafReports", bundle: nil)
        let AlertVc = storyboard.instantiateViewController(identifier: "lose") as LosingViewController

        return AlertVc
      }
    
    func displayDailyReport() ->  DailyReportViewController {
        let storyboard = UIStoryboard(name: "Challenge", bundle: nil)
        let report = storyboard.instantiateViewController(identifier: Constants.Storyboard.dailyReportViewController) as DailyReportViewController
      
        return report
      }
    
    func displayAdvReport() ->  AdvReportViewController {
        let storyboard = UIStoryboard(name: "Challenge", bundle: nil)
        let report = storyboard.instantiateViewController(identifier: Constants.Storyboard.advReportViewController) as AdvReportViewController
      
        return report
      }
  
}
