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
        case .fiftyRiyal , .tenRiyal , .fiveRiyal, .riyal :
            return CGSize(width: 130, height: 60)
            
        case .riyalHalf, .riyalQuarter:
            return CGSize(width: 50, height: 50)
        }
    }
    
 
}
