//
//  DailyReport.swift
//  Lafeef
//
//  Created by Mihaf on 24/07/1442 AH.
//

import Foundation
struct DailyReport: Codable {
    var levelNum:String?
    var ingredientsAmount:Float
    var backagingAmount:Int
    var advertismentAmount:Float

    var collectedScore:Int
    var collectedMoney: Int
    var isPassed :Bool
    var isRewarded : Bool
    var happyFaces: Int
    var normalFaces: Int
    var sadFaces:Int 
    
    
}
