//
//  ChalleangeLevelCalendarViewController.swift
//  Lafeef
//
//  Created by Mihaf on 08/07/1442 AH.
//

import UIKit

class ChalleangeLevelCalendarViewController: UIViewController {

    var array : [Float]!
  
    var model2 :LevelReportData?
    var array2:[LevelReportData]?
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        FirebaseRequest.getChalleangeLevels {  (Level, error) in
            guard let level = Level , error == "" else{
             
              print(error)
                    
                   return
                    
                }
            self.setLevel(level:level)
                }
    }
        func setLevel(level:Level){
            array?.append(level.maxScore)
            print(array)
        }
     
//        FirebaseRequest.getChalleangeLevelesReports(childID: "fIK2ENltLvgqTR5NODCx4MJz5143") { (Report, error) in
//
//            if error == ""{
//                self.array2?.append(Report!)
//
//            }else{
//            print(error)
//
//                print(self.array2)
//        }
//
//        }
//
//        }

        // Do any additional setup after loading the view.
    }
    
