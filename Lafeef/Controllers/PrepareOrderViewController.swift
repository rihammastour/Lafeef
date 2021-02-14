//
//  OrderViewController.swift
//  Lafeef
//
//  Created by Renad nasser on 09/02/2021.
//

import UIKit
import Foundation
import SpriteKit

class PrepareOrderViewController {
    
    //MARK: - Functions
    
    //getBase
    static func gatBaseName(_ baseOrder:String) -> String {
        
        switch baseOrder {
        case "cake":
            return "cake"
        case "halfCake":
            return "half-cake"
        case "quarterCake":
            return "quarter-cake"
        case "threeQuarterCake":
            return "threequarter-cake"
        case "cupcakeCh":
            return "cupcake-ch"
        case "cupcakeVan":
            return "cupcake-van"
        default:
            return "cake"
        }
    }
    
    
    //getToppingsName
    static func getToppingsName(from array:[String:Int]?) -> [String]?{
        
        guard let array = array else {
            return nil
        }
        
        var toppingsName:[String] = []
        
        for (key, value) in array{
            if toppingsName.count == 4 {
                break }
            //Stract number of topping as repeated of its name
            for _ in 1 ... value{
                toppingsName.append(key)
            }
        }
        return toppingsName
    }
    
    
    
    
    
}


