//
//  Order.swift
//  Lafeef
//
//  Created by Renad nasser on 08/02/2021.
//

import Foundation
import UIKit
import GameplayKit

struct Order: Codable {
    var allTime:Int
    var base:String
    var size:Int
    var toppings:[String:Int]?
    
}

