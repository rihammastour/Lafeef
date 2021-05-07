//
//  Base.swift
//  Lafeef
//
//  Created by Renad nasser on 14/02/2021.
//

import Foundation
import SpriteKit

enum Base : String,Codable {
    
    //cases
    case cake = "cake"
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
    
    func getAnswerBaseSize() -> CGSize {
        
        switch self {
        case .cake , .quarterCake , .halfCake,.threequarterCake:
            return CGSize(width: 200, height: 200)
            
        case .chocolateCupcake , .vanilaCupcake:
            return CGSize(width: 150, height: 150)
        }
    }
    
    
    func getPrice() -> Float {
        
        switch self {
        case .cake : return 42.5
        case .quarterCake : return 10.625
        case .halfCake : return 21.25
        case .threequarterCake: return 31.875
        case .chocolateCupcake , .vanilaCupcake: return 12.75

        }
    }
    
    func getTax() -> Float {
        switch self {
        case .cake : return 7.5
        case .quarterCake : return 1.875
        case .halfCake : return 3.75
        case .threequarterCake: return 5.625
        case .chocolateCupcake , .vanilaCupcake: return 2.25

        }
    }
    
}
