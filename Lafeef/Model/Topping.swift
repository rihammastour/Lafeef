//
//  Topping.swift
//  Lafeef
//
//  Created by Renad nasser on 14/02/2021.
//

import Foundation
enum Topping : String,Codable {
    
    //cases
    case strawberry
    case kiwi = "oval-kiwi"
    case pineapple
    case darkChocolate = "dark-chocolate"
    case whiteChocolate = "white-chocolate"
    
    
    func getPrice() -> Float{
        switch self {
        case .kiwi , .strawberry , .pineapple:
            return 2.55
        case .whiteChocolate , .darkChocolate:
            return 3.44
        }
    }
    
    func getTax() -> Float{
        switch self {
        case .kiwi , .strawberry , .pineapple:
            return 0.45
        case .whiteChocolate , .darkChocolate:
            return 0.6
        }
    }
    
    //getZRotate
    func getZRotate() -> Float?{
        switch self {
        case .kiwi:
            return 2.25
        default:
            return nil
        }
    }

}
