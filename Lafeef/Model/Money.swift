//
//  Money.swift
//  Lafeef
//
//  Created by Riham Mastour on 06/07/1442 AH.
//

import Foundation
import SpriteKit

enum Money: Float, Codable {
    //cases
    case fiftyRiyal = 50
    case tenRiyal = 10
    case fiveRiyal = 5
    case riyal = 1
    case riyalHalf = 0.5
    case riyalQuarter = 0.25
    
    func getMoneySize() -> CGSize {
        
        switch self {
        case .fiftyRiyal , .tenRiyal , .fiveRiyal:
            return CGSize(width: 350, height: 350)
            
        case .riyal , .riyalHalf, .riyalQuarter:
            return CGSize(width: 50, height: 50)
        }
    }
    
//    func convertToMoney(customerPaied: Float) -> Float{
//        print("convertToMoney excuted", customerPaied)
//        switch customerPaied {
//        case 50:
//            return [50,]
//        case 53:
////            return [.fiftyRiyal, .fiftyRiyal,.riyal,.riyal,.riyal]
////        case 100:
////            return [.fiftyRiyal, .fiftyRiyal]
////        case 100:
////            return [.fiftyRiyal, .fiftyRiyal]
//        default:
////            return []
//        }
//    }
 
}
