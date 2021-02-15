//
//  PrepareOrderController.swift
//  Lafeef
//
//  Created by Renad nasser on 09/02/2021.
//

import UIKit
import Foundation
import SpriteKit

class PrepareOrderController {
    
    //MARK: - Functions
    
    //getBase
    static func gatBaseName(_ baseOrder:String) -> Base {
        
        switch baseOrder {
        case "cake":
            return Base.cake
        case "halfCake":
            return Base.halfCake
        case "quarterCake":
            return Base.quarterCake
        case "threeQuarterCake":
            return Base.threequarterCake
        case "cupcakeCh":
            return Base.chocolateCupcake
        case "cupcakeVan":
            return Base.vanilaCupcake
        default:
            return Base.cake
        }
    }
    
    
    //getToppingsName
    static func getToppingsName(from array:[String:Int]?) -> [Topping]?{
        
        guard let array = array else {
            return nil
        }
        
        var toppingsName:[Topping] = []
        
        for (key, value) in array{
            if toppingsName.count == 4 {
                break }
            //Stract number of topping as repeated of its name
            for _ in 1 ... value{
                                
                switch key {
                case "strawberry":
                    toppingsName.append(Topping.strawberry)
                case "pineapple":
                    toppingsName.append(Topping.pineapple)
                case "kiwi":
                    toppingsName.append(Topping.kiwi)
                case "darkChocolate":
                    toppingsName.append(Topping.darkChocolate)
                case "whiteChocolate":
                    toppingsName.append(Topping.whiteChocolate)
                default:
                    print("undefined topping")
                }
                            }
        }
        return toppingsName
    }
    
    
    
    
    
}


