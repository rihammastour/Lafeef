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
    
    //getToppingsName
    static func getToppingsName(from array:[Topping:Int]?) -> [Topping]?{
        
        guard let array = array else {
            return nil
        }
        
        var toppingsName:[Topping] = []
        
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


