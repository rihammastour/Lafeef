//
//  CustmerSatisfaction.swift
//  Lafeef
//
//  Created by Renad nasser on 20/02/2021.
//

import Foundation
import GameplayKit


enum CustmerSatisfaction : String {
    
    case happey = "happy-customer"
    case normal = "normal-customer"
    case sad = "sad-customer"
    
    func barIncreasedByNum()->CGFloat{

        switch self {
        case .happey:
            return 50
        case .normal:
            return 35
        case .sad:
            return 20
        }
        
    }
    
    static func getCusSat(for value: Int) -> CustmerSatisfaction {
        switch value {
        case 5,6:
            return .happey
        case 4,3:
            return .normal
        default:
            return .sad
        }
    }
    
}
