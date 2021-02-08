//
//  addLevels.swift
//  Lafeef
//
//  Created by Renad Nasser on 08/02/2021.
//

import Foundation
class AddLevel{
static func one(){
    let order1 = Order(base: "cake", size: 1, toppings:nil)
    let order2 = Order(base: "cake", size: 1, toppings:["strawberry":1])
    let order3 = Order(base: "cake", size: 1, toppings:["strawberry":2])
    let order4 = Order(base: "cake", size: 1, toppings:["strawberry":3])
    let level = Level(duration: 5, bestTime: 4, orders: [order1,order2,order3,order4])
    
    FirebaseRequest.addLevel(levelNum: "1",level: level) { (success, err) in
        print("isearted?",success,"errrr",err)
    }
}
}
