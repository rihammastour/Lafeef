//
//  CustmerSatisfaction.swift
//  Lafeef
//
//  Created by Renad nasser on 20/02/2021.
//

import Foundation
import GameplayKit


enum CustmerSatisfaction {
    
    case happey
    case normal
    case sad
    
    func barIncreasedByNum()->CGFloat{

        switch self {
        case .happey:
            return 50
        case .normal:
            return 30
        case .sad:
            return 10

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
