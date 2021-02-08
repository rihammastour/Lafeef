//
//  AddLevels.swift
//  Lafeef
//
//  Created by Renad Nasser on 08/02/2021.
//

import Foundation

class AddLevels{
static func one(){
    let order1 = Order(allTime: 120, base: "cake", size: 1, toppings:nil)
    let order2 = Order(allTime: 120, base: "cake", size: 1, toppings:["strawberry":1])
    let order3 = Order(allTime: 120, base: "cake", size: 1, toppings:["strawberry":2])
    let order4 = Order(allTime: 120, base: "cake", size: 1, toppings:["strawberry":3])
    let level = Level(duration: 8, orders: [order1,order2,order3,order4])

    FirebaseRequest.addLevel(levelNum: "1",level: level) { (success, err) in
        print("isearted?",success,"errrr",err)
    }
}
}
