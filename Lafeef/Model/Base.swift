//
//  Base.swift
//  Lafeef
//
//  Created by Renad nasser on 14/02/2021.
//

import Foundation
import SpriteKit

enum Base : String {
    
    //cases
    case cake
    case quarterCake = "quarter-cake"
    case halfCake = "half-cake"
    case threequarterCake = "threequarter-cake"
    case vanilaCupcake = "cupcake-van"
    case chocolateCupcake = "cupcake-ch"
    
    
    func getBaseSize() -> CGSize {
        
        switch self {
        case .cake , .quarterCake , .halfCake,.threequarterCake:
            return CGSize(width: 150, height: 150)
            
        case .chocolateCupcake , .vanilaCupcake:
            return CGSize(width: 80, height: 80)
        }
    }
    
    func getPrice() -> Float {
        
        switch self {
        case .cake : return 100
        case .quarterCake : return 25
        case .halfCake : return 50
        case .threequarterCake: return 75
        case .chocolateCupcake , .vanilaCupcake: return 15

        }
    }
    
}
