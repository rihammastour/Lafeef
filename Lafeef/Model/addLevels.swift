
import Foundation

class AddLevels{
    
    //add level one
    static func one(){
        let order1 = Order(base: Base.cake, customerPaid: 50,toppings:nil)
        let order2 = Order(base: Base.cake, customerPaid: 53, toppings:[Topping.strawberry])
        let order3 = Order(base:  Base.cake, customerPaid: 56,toppings:[Topping.kiwi,Topping.kiwi])
        let order4 = Order( base: Base.cake, customerPaid: 59,toppings:[Topping.pineapple,Topping.pineapple,Topping.pineapple])
        let level = Level(duration: 8,maxScore: 8,minScore: 100, orders: [order1,order2,order3,order4])
        
        FirebaseRequest.addLevel(levelNum: "1",level: level) { (success, err) in
            print("isearted?",success,"errrr",err)
        }
        
    }
    //add level two
    static func two(){
        let order1 = Order(base: Base.chocolateCupcake, customerPaid: 20,toppings:[Topping.strawberry])
        let order2 = Order(base: Base.vanilaCupcake, customerPaid: 19, toppings:[Topping.kiwi])
        let order3 = Order(base:  Base.cake, customerPaid: 60,toppings:[Topping.darkChocolate,Topping.darkChocolate])
        let order4 = Order( base: Base.cake, customerPaid: 60,toppings:[Topping.strawberry,Topping.whiteChocolate])
        let level = Level(duration: 8,maxScore: 8,minScore: 100, orders: [order1,order2,order3,order4])
        
        FirebaseRequest.addLevel(levelNum: "2",level: level) { (success, err) in
            print("isearted?",success,"errrr",err)
        }
    }
    //add level three
    static func three(){
        let order1 = Order(base: Base.quarterCake, customerPaid: 16,toppings:[Topping.strawberry])
        let order2 = Order(base: Base.halfCake, customerPaid: 35, toppings:[Topping.pineapple,Topping.pineapple])
        let order3 = Order(base:  Base.threequarterCake, customerPaid: 50,toppings:[Topping.darkChocolate,Topping.whiteChocolate,Topping.kiwi])
        let order4 = Order( base: Base.halfCake, customerPaid: 35,toppings:[Topping.strawberry,Topping.strawberry])
        let level = Level(duration: 8,maxScore: 8,minScore: 100, orders: [order1,order2,order3,order4])
        
        FirebaseRequest.addLevel(levelNum: "3",level: level) { (success, err) in
            print("isearted?",success,"errrr",err)
        }
        
    }
    //add level four
    static func four(){
        let order1 = Order(base: Base.cake, customerPaid: 100,toppings:[Topping.strawberry,Topping.darkChocolate])
        let order2 = Order(base: Base.quarterCake, customerPaid: 50, toppings:[Topping.whiteChocolate])
        let order3 = Order(base:  Base.vanilaCupcake, customerPaid: 50,toppings:[Topping.strawberry])
        let order4 = Order( base: Base.threequarterCake, customerPaid: 50,toppings:[Topping.kiwi,Topping.kiwi,Topping.kiwi])
        let level = Level(duration: 8,maxScore: 50,minScore: 100, orders: [order1,order2,order3,order4])
        
        FirebaseRequest.addLevel(levelNum: "4",level: level) { (success, err) in
            print("isearted?",success,"errrr",err)
        }
    }
    
}
