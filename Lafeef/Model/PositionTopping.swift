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
    case topLeft(Topping)
    case topRight(Topping)
    case bottomLeft(Topping)
    case bottomRight(Topping)
    case center(Topping)
    
    //generateNode
    func generateNode(for base:Base) -> SKSpriteNode{
        
        switch base {
        case .cake,.threequarterCake:
            return generateCakeNode()
        case .halfCake:
            return generateHalfCakeNode()
        case .quarterCake:
            return generateQuarterCakeNode()//Must be changed
        default:
            return generateCupcakeNode() //Must be changed
        }
    }
    
    
    //generate node for Cake and Threequarter Cake
    func generateCakeNode() -> SKSpriteNode{
        
        switch self {
        case .topLeft(let topping):
            
            let zRot = checkKiwi(-2.25,topping)
            
            let node = SKSpriteNode(imageNamed: topping.rawValue)
            node.anchorPoint = CGPoint(x: 0.5, y: 0.5)
            node.position = CGPoint(x: -25, y: 30)
            node.size = CGSize(width: 60, height: 60)
            node.zRotation = zRot
            return node
            
        case .topRight(let topping):
            
            let zRot = checkKiwi(2.25,topping)
            
            let node = SKSpriteNode(imageNamed: topping.rawValue)
            
            node.anchorPoint = CGPoint(x: 0.5, y: 0.5)
            node.position = CGPoint(x: 25, y: 30)
            node.size = CGSize(width: 60, height: 60)
            node.zRotation = zRot
            return node
            
        case .bottomLeft(let topping):
            
            let zRot = checkKiwi(-1,topping)
            
            let node = SKSpriteNode(imageNamed: topping.rawValue)
            node.anchorPoint = CGPoint(x: 0.5, y: 0.5)
            node.position = CGPoint(x: -25, y: -8)
            node.size = CGSize(width: 60, height: 60)
            node.zRotation = zRot
            return node
            
        case .bottomRight(let topping):
            
            let zRot = checkKiwi(0.5,topping)
            
            let node = SKSpriteNode(imageNamed: topping.rawValue)
            node.anchorPoint = CGPoint(x: 0.5, y: 0.5)
            node.position = CGPoint(x: 25, y: -8)
            node.size = CGSize(width: 60, height: 60)
            node.zRotation = zRot
            return node
            
        case .center(let topping):
            let node = SKSpriteNode(imageNamed: topping.rawValue)
            node.anchorPoint = CGPoint(x: 0.5, y: 0.5)
            node.size = CGSize(width: 60, height: 60)
            return node
        }
        
        
    }
    
    //generate node for Half Cake
    func generateHalfCakeNode() -> SKSpriteNode{
        
        switch self {
        case .topLeft(let topping):
            
            let zRot = checkKiwi(-2.25,topping)
            
            let node = SKSpriteNode(imageNamed: topping.rawValue)
            node.anchorPoint = CGPoint(x: 0.5, y: 0.5)
            node.position = CGPoint(x: -25, y: 12.5)
            node.size = CGSize(width: 60, height: 60)
            node.zRotation = zRot
            return node
            
        case .topRight(let topping):
            
            let zRot = checkKiwi(2.25,topping)
            
            let node = SKSpriteNode(imageNamed: topping.rawValue)
            node.anchorPoint = CGPoint(x: 0.5, y: 0.5)
            node.position = CGPoint(x: 25, y: 12.5)
            node.size = CGSize(width: 60, height: 60)
            node.zRotation = zRot
            return node
            
        default:
            let node = SKSpriteNode(imageNamed: "kiwi")
            node.anchorPoint = CGPoint(x: 0.5, y: 0.5)
            node.position = CGPoint(x: 25, y: 30)
            node.size = CGSize(width: 60, height: 60)
            node.zRotation = 2.25
            return node
        }
        
    }
    
    //generate node for Quarter Cake
    func generateQuarterCakeNode() -> SKSpriteNode{
        
        switch self {
        case .topRight(let topping):
            
            let zRot = checkKiwi(-2.25,topping)
            
            let node = SKSpriteNode(imageNamed: topping.rawValue)
            node.anchorPoint = CGPoint(x: 0.5, y: 0.5)
            node.position = CGPoint(x: 0, y: 10)
            node.size = CGSize(width: 60, height: 60)
            node.zRotation = zRot
            return node
            
        default:
            let node = SKSpriteNode(imageNamed: "kiwi")
            node.anchorPoint = CGPoint(x: 0.5, y: 0.5)
            node.position = CGPoint(x: 25, y: 30)
            node.size = CGSize(width: 60, height: 60)
            node.zRotation = 2.25
            return node
        }
        
    }
    
    //generate node for Cup Cake
    func generateCupcakeNode() -> SKSpriteNode{
        
        switch self {
        case .topRight(let topping):
            
            let zRot = checkKiwi(-2.25,topping)
            
            let node = SKSpriteNode(imageNamed: topping.rawValue)
            node.anchorPoint = CGPoint(x: 0.5, y: 0.5)
            node.position = CGPoint(x: 0, y: 15)
            node.size = CGSize(width: 60, height: 60)
            node.zRotation = zRot
            return node
            
        default:
            let node = SKSpriteNode(imageNamed: "kiwi")
            node.anchorPoint = CGPoint(x: 0.5, y: 0.5)
            node.position = CGPoint(x: 25, y: 30)
            node.size = CGSize(width: 60, height: 60)
            node.zRotation = 2.25
            return node
        }
        
    }
    
    //checkKiwi
    func checkKiwi(_ zRot:CGFloat,_ topping:Topping) -> CGFloat{
        
        if topping == Topping.kiwi{
            return CGFloat(topping.getZRotate()!)
        }else{
            return zRot
        }
    }
    
}
