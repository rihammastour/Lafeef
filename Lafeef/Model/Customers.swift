//
//  Customers.swift
//  Lafeef
//
//  Created by MACBOOKPRO on 2/20/21.
//

import Foundation
enum Customers: Int {
    case orange = 1
    case apple = 2
    case pineapple = 3
    case strawberry = 4
    case pear = 5
    case watermelon = 6
    
    func createCustomerNode() -> CustomerNode{
        switch self {
        case .orange :
            return CustomerNode(customerName:"Orange")
        case .apple :
            return CustomerNode(customerName:"Apple")
        case .pineapple :
            return CustomerNode(customerName:"Pineapple")
        case .strawberry :
            return CustomerNode(customerName:"Strawberry")
        case .pear :
            return CustomerNode(customerName:"Pear")
        case .watermelon :
            return CustomerNode(customerName:"Watermelon")
        }
    }
    
    
}

