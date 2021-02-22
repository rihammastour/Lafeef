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
    var base:Base
    var customerPaid:Float
    var toppings:[Topping]?
    
}
