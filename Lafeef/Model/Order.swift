//
//  Order.swift
//  Lafeef
//
//  Created by Renad nasser on 08/02/2021.
//

import Foundation
struct Order: Codable {
    var base:String
    var size:Int
    var toppings:[String:Int]
}
