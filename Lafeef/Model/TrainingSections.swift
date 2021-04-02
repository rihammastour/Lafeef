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
                return "kiwi cake" //need preprocessing
            } else if type == "triangle" {
                return "pineapple"
            }
            
        case .colors:
            if type == "brown" {
                return "darkChocolate"
            } else if type == "red" {
                return "strawberry"
            }

        case .calculations:
            if type == "addition" {
                return "5"
            } else if type == "subtraction" {
                return "1"
            } else if type == "multiplication" {
                return "4"
            }
            
         }
        return  ""
    }
}
