//
//  Topping.swift
//  Lafeef
//
//  Created by Renad nasser on 14/02/2021.
//

import Foundation
enum Topping : String {
    
    //cases
    case strawberry
    case kiwi = "oval-kiwi"
    case pineapple
    case darkChocolate = "dark-chocolate"
    case whiteChocolate = "white-chocolate"
    
    func getZRotate() -> Float?{
        switch self {
        case .kiwi:
            return 2.25
        default:
            return nil
        }
    }

}
