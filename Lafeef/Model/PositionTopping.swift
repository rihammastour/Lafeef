//
//  PositionTopping.swift
//  Lafeef
//
//  Created by Renad nasser on 13/02/2021.
//

import Foundation
import SpriteKit

enum PositionTopping : Equatable {
    
    //cases ..
    case topLeft(String)
    case topRight(String)
    case bottomLeft(String)
    case bottomRight(String)
    case center(String)
    
    //generateNode
    func generateNode() -> SKSpriteNode{
        
        switch self {
        case .topLeft(let toppingName):
            let node = SKSpriteNode(imageNamed: toppingName)
            node.anchorPoint = CGPoint(x: 0.5, y: 0.5)
            node.position = CGPoint(x: -14, y: 30)
            node.size = CGSize(width: 60, height: 60)
            node.zRotation = -2.25
            return node
            
        case .topRight(let toppingName):
            let node = SKSpriteNode(imageNamed: toppingName)
            node.anchorPoint = CGPoint(x: 0.5, y: 0.5)
            node.position = CGPoint(x: 19, y: 25)
            node.size = CGSize(width: 60, height: 60)
            node.zRotation = 2.25
            return node
            
        case .bottomLeft(let toppingName):
            let node = SKSpriteNode(imageNamed: toppingName)
            node.anchorPoint = CGPoint(x: 0.5, y: 0.5)
            node.position = CGPoint(x: -25, y: -1)
            node.size = CGSize(width: 60, height: 60)
            node.zRotation = -1
            return node
            
        case .bottomRight(let toppingName):
            let node = SKSpriteNode(imageNamed: toppingName)
            node.anchorPoint = CGPoint(x: 0.5, y: 0.5)
            node.position = CGPoint(x: 28, y: -5)
            node.size = CGSize(width: 60, height: 60)
            node.zRotation = 0.5
            return node
        
        case .center(let toppingName):
            let node = SKSpriteNode(imageNamed: toppingName)
            node.anchorPoint = CGPoint(x: 0.5, y: 0.5)
            node.size = CGSize(width: 60, height: 60)
            return node
        }
        
    }
    
}
