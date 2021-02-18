//
//  PositionMoney.swift
//  Lafeef
//
//  Created by Riham Mastour on 06/07/1442 AH.
//

import Foundation
import SpriteKit

enum PositionMoney : Equatable {
    
    //cases ..
    case first
    case seconed
    case third
    case fourth
    case fifth
    case sixth

    //generateNode
    func getPosition() -> CGPoint{
        switch self {
        case .first:
            return CGPoint(x: 0,  y: 0)
            
        case .seconed:
            return CGPoint(x: 4,  y: 0)
            
        case .third:
            return CGPoint(x: 8,  y: 0)
            
        case .fourth:
            return CGPoint(x: 16,  y: 0)
            
        case .fifth:
            return CGPoint(x: 32,  y: 0)
            
        case .sixth:
            return CGPoint(x: 64,  y: 0)
        }
    }
    
    func getZRotation() -> CGFloat{
        
        switch self {
        case .first:
            return 12
            
        case .seconed:
            return 12.25
            
        case .third:
            return 12.5
            
        case .fourth:
            return 13
            
        case .fifth:
            return 13.25
            
        case .sixth:
            return 13.5
        }
    }
    
}
