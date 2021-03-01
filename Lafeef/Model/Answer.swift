//
//  Answer.swift
//  Lafeef
//
//  Created by Renad nasser on 22/02/2021.
//

import Foundation

struct Answer: Codable {
    var base:Base?
    var change:Float
    var atTime:Float
    var toppings:[Topping]?
}
