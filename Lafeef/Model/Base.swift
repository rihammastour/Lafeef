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
    
    
    func generateBaseNode() -> SKSpriteNode {
        switch self {
        case .cake , .quarterCake , .halfCake,.threequarterCake:
            let node = SKSpriteNode(imageNamed: self.rawValue)
            node.anchorPoint = CGPoint(x: 0.5, y: 0.5)
            node.position = CGPoint(x: 0, y: 15)
            node.size = CGSize(width: 150, height: 150)
            return node
        case .chocolateCupcake , .vanilaCupcake:
            let node = SKSpriteNode(imageNamed: self.rawValue)
            node.anchorPoint = CGPoint(x: 0.5, y: 0.5)
            node.position = CGPoint(x: 0, y: 15)
            node.size = CGSize(width: 80, height: 80)
            return node
        }
    }
    
    }


