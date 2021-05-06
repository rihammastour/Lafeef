//
//  TrainingSections.swift
//  Lafeef
//
//  Created by Riham Mastour on 19/08/1442 AH.
//

import Foundation

enum TrainingSections: String,Codable {
    case shapes 
    case colors
    case calculations
     
    //answers
    func getObject(for type:String)-> [String] {
        var getAnswer : [String] = []
        switch self {
        
        case .shapes:
            if type == "circle" {
                getAnswer[0] = "Kiwi"
                getAnswer[1] = "CompleteCake"
                getAnswer[2] = "RiyalHalf"
                getAnswer[3] = "RiyalQuarter"
                return getAnswer //need preprocessing
            } else if type == "sqaure" {
                getAnswer[0] = "ChocolateBrown"
                return getAnswer
            }
            
        case .colors:
            if type == "brown" {
                getAnswer[0] = "ChocolateBrown"
                getAnswer[1] = "BrownCupcake"
                return getAnswer
            } else if type == "white" {
                getAnswer[0] = "WhiteChocolate"
                return getAnswer
            }

        case .calculations:
            if type == "addition" {
                getAnswer[0] = "Kiwi"
                getAnswer[1] = "Kiwi"
                return getAnswer
            } else if type == "subtraction" {
                getAnswer[0] = "ChocolateBrown"
                
                return getAnswer
            } else if type == "multiplication" {
                getAnswer[0] = "Pineapple"
                getAnswer[1] = "Pineapple"
                getAnswer[2] = "Pineapple"
                getAnswer[3] = "Pineapple"

            
                
                return getAnswer
            }
            
         }
        return  getAnswer
    }
}
