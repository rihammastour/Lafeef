//
//  AddLevels.swift
//  Lafeef
//
//  Created by Renad Nasser on 08/02/2021.
//

import Foundation

class AddLevels{
    
    //add level one
static func one(){
    let order1 = Order(base: Base.cake, customerPaid: 100,toppings:nil)
    let order2 = Order(base: Base.cake, customerPaid: 103, toppings:[Topping.strawberry:1])
    let order3 = Order(base:  Base.cake, customerPaid: 106,toppings:[Topping.kiwi:2])
    let order4 = Order( base: Base.cake, customerPaid: 109,toppings:[Topping.pineapple:3])
    let level = Level(duration: 8, orders: [order1,order2,order3,order4])

    FirebaseRequest.addLevel(levelNum: "1",level: level) { (success, err) in
        print("isearted?",success,"errrr",err)
    }

}
    
    static func two(){
        let order1 = Order(base: Base.chocolateCupcake, customerPaid: 20,toppings:[Topping.strawberry:1])
        let order2 = Order(base: Base.vanilaCupcake, customerPaid: 19, toppings:[Topping.kiwi:1])
        let order3 = Order(base:  Base.cake, customerPaid: 110,toppings:[Topping.darkChocolate:2])
        let order4 = Order( base: Base.cake, customerPaid: 110,toppings:[Topping.strawberry:1,Topping.whiteChocolate:1])
        let level = Level(duration: 8, orders: [order1,order2,order3,order4])

        FirebaseRequest.addLevel(levelNum: "2",level: level) { (success, err) in
            print("isearted?",success,"errrr",err)
        }
}

    static func three(){
        let order1 = Order(base: Base.quarterCake, customerPaid: 30,toppings:[Topping.strawberry:1])
        let order2 = Order(base: Base.halfCake, customerPaid: 60, toppings:[Topping.pineapple:2])
        let order3 = Order(base:  Base.threequarterCake, customerPaid: 100,toppings:[Topping.darkChocolate:1,Topping.whiteChocolate:1,Topping.kiwi:1])
        let order4 = Order( base: Base.halfCake, customerPaid: 60,toppings:[Topping.strawberry:2])
        let level = Level(duration: 8, orders: [order1,order2,order3,order4])

        FirebaseRequest.addLevel(levelNum: "3",level: level) { (success, err) in
            print("isearted?",success,"errrr",err)
        }

}

    static func four(){
        let order1 = Order(base: Base.cake, customerPaid: 107.25,toppings:[Topping.strawberry:1,Topping.darkChocolate:1])
        let order2 = Order(base: Base.quarterCake, customerPaid: 30.25, toppings:[Topping.whiteChocolate:1])
        let order3 = Order(base:  Base.vanilaCupcake, customerPaid: 20.5,toppings:[Topping.strawberry:1])
        let order4 = Order( base: Base.threequarterCake, customerPaid: 144.25,toppings:[Topping.kiwi:3])
        let level = Level(duration: 8, orders: [order1,order2,order3,order4])

        FirebaseRequest.addLevel(levelNum: "4",level: level) { (success, err) in
            print("isearted?",success,"errrr",err)
        }
    }

}
