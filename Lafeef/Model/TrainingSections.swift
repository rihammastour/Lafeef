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
    func getObject(for type:String)-> String {
        switch self {
        
        case .shapes:
            if type == "circle" {
                return "Kiwi CompleteCake RiyalHalf RiyalQuarter" //need preprocessing
            } else if type == "triangle" {
                return "Pineapple"
            }
            
        case .colors:
            if type == "brown" {
                return "ChocolateBrown BrownCupcake"
            } else if type == "red" {
                return "Strawberry"
            }

        case .calculations:
            if type == "addition" {
                return "FiftyRiyal"
            } else if type == "subtraction" {
                return "OneRiyal"
            } else if type == "multiplication" {
                return "OneRiyal OneRiyal OneRiyal OneRiyal"
            }
            
         }
        return  ""
    }
}
