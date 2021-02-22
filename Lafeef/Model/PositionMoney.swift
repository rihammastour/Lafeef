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
    case first(Money)
    case seconed(Money)
    case third(Money)
    case fourth(Money)
    case fifth(Money)
    case sixth(Money)

    //generateNode
    func getPosition() -> CGPoint{
        switch self {
        case .first:
            return CGPoint(x: 0,  y: 0)
            
        case .seconed(let money):
            if money == .riyal || money == .riyalHalf || money == .riyalQuarter {
                return CGPoint(x: 0,  y: 0)
            }
            return CGPoint(x: 20,  y: 0)
            
        case .third:
            return CGPoint(x: 40,  y: 0)
            
        case .fourth:
            return CGPoint(x: 60,  y: 0)
            
        case .fifth:
            return CGPoint(x: 80,  y: 0)
            
        case .sixth:
            return CGPoint(x: 100,  y: 0)
        }
    }
    
    func getZRotation() -> CGFloat{
        let conversionFactor = 0.01745329252
        switch self {
        case .first:
            return CGFloat(conversionFactor * 60) // multiplied by degree
            
        case .seconed(let money):
            if money == .riyal || money == .riyalHalf || money == .riyalQuarter {
                return CGFloat(conversionFactor * 220)
            }
            return CGFloat(conversionFactor * 80)
            
        case .third:
            return CGFloat(conversionFactor * 100)
            
        case .fourth:
            return CGFloat(conversionFactor * 120)
            
        case .fifth:
            return CGFloat(conversionFactor * 140)
            
        case .sixth:
            return CGFloat(conversionFactor * 160)
        }
    }
    
}
