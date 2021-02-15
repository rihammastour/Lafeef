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
    case topRight(Base)
    case topLeft(Base)
    case bottomLeft(Base)
    case bottomRight(Base)
    
    //generateNode
    func getPosition() -> CGPoint{
        switch self {
        case .topRight(let base):
            
            if( base == .cake || base == .threequarterCake){
                return CGPoint(x: 25, y: 30)
                
            }else if(base == .halfCake){
                return  CGPoint(x: 25, y: 12.5)
                
            }else if(base == .quarterCake){
                return CGPoint(x: -5, y: 12)
                
            }else{ //Cupcake position
                return CGPoint(x: 0, y: 15)
            }
        case .topLeft(let base):
            
            if( base == .cake || base == .threequarterCake){
                return CGPoint(x: -25, y: 30)
            }else if(base == .halfCake){
                return CGPoint(x: -25, y: 12.5)
            }else{
                //Should Not be excuted for cupcake and qurter cake
                return CGPoint(x: 0, y: 0)
            }
            
        case .bottomLeft:
            return CGPoint(x: -25, y: -8)
            
        case .bottomRight:
            return CGPoint(x: 25, y: -8)
        }
    }
    
    func getZRotation(for topping:Topping) -> CGFloat{
        
        if topping == Topping.kiwi{
            return CGFloat(topping.getZRotate()!) }
        
        switch self {
        case .topRight:
            return 2.25
        case .topLeft:
            return -2.25
        case .bottomLeft:
            return -1
        case .bottomRight:
            return 0.5
        }
    }
    
}
