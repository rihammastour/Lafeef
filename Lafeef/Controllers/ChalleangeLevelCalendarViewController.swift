//
//  ChalleangeLevelCalendarViewController.swift
//  Lafeef
//
//  Created by Mihaf on 08/07/1442 AH.
//

import UIKit

class ChalleangeLevelCalendarViewController: UIViewController {

    var levels = [Float]()
    var reports = [CompletedLevel]()
    override func viewDidLoad() {
        super.viewDidLoad()
        getlevelsMaxScore()
        getChildReports()
        }
    
    
    
    func   getlevelsMaxScore(){
        FirebaseRequest.getChalleangeLevels { [self]  (Level, error) in
            if error == ""{
                levels.append(Level!.maxScore)

            }else{
                print(error)

    }
        }
    }
        func getChildReports(){
           // need child id
                FirebaseRequest.getChalleangeLevelesReports(childID: "fIK2ENltLvgqTR5NODCx4MJz5143", completionBlock: { (CompletedLevel, error) in
                    if (error == ""){
                        self.reports.append(CompletedLevel!)
                    }else{
                        print(error)
                    }
                })
                
            }


    

    }
    
