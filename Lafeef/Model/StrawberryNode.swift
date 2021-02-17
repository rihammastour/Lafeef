//
//  StrawberryNode.swift
//  Lafeef
//
//  Created by Mihaf on 04/07/1442 AH.
//

import Foundation
import SpriteKit
import GameplayKit

class StrawberryNode {
    var strawberry = SKSpriteNode()
    var WalkingFrames: [SKTexture] = []
    var WaitingFrames: [SKTexture] = []
    var HappyFrames: [SKTexture] = []
    var SadFrames: [SKTexture] = []
    
    
    func buildStrawberry() {
        //
        let WalkingStrawberryAtlas = SKTextureAtlas(named: "NWStrawberry")
        var walkingStrawberryFrames: [SKTexture] = []
        
        
        let WaitingStrawberryAtlas = SKTextureAtlas(named: "WaitingStrawberry")
        var waitingStrawberryFrames: [SKTexture] = []
        
        
        let HappyStrawberryAtlas = SKTextureAtlas(named: "HappyStrawberry")
        var happyStrawberryFrames: [SKTexture] = []
        
        
        let SadStrawberryaAtlas = SKTextureAtlas(named: "SadStraberry")
        var sadStrawberryFrames: [SKTexture] = []
        
        
        
        let WaitingImages = WaitingStrawberryAtlas.textureNames.count
        let WalkingImages = WalkingStrawberryAtlas.textureNames.count
        let HappyImages = HappyStrawberryAtlas.textureNames.count
        let SadImages = SadStrawberryaAtlas.textureNames.count
        
        
      for i in 1...WaitingImages {
        let strawberryTextureName = "Waitingstrawberry\(i)"
        waitingStrawberryFrames.append(WaitingStrawberryAtlas.textureNamed(strawberryTextureName))
      }
        
        for i in 1...WalkingImages {
          let strawberryTextureName = "NWstrawberry\(i)"
            walkingStrawberryFrames.append(WalkingStrawberryAtlas.textureNamed(strawberryTextureName))
        }
        
        
        for i in 1...HappyImages {
          let strawberryTextureName = "Happystrawberry\(i)"
            happyStrawberryFrames.append(HappyStrawberryAtlas.textureNamed(strawberryTextureName))
        }
        
        
        for i in 1...SadImages {
          let strawberryTextureName = "SadStrawberry1\(i)"
            sadStrawberryFrames.append(SadStrawberryaAtlas.textureNamed(strawberryTextureName))
        }
        

        
    WaitingFrames = waitingStrawberryFrames
    HappyFrames = happyStrawberryFrames
    SadFrames = sadStrawberryFrames
    WalkingFrames = walkingStrawberryFrames
        
    let firstFrameTexture = waitingStrawberryFrames[0]
    strawberry = SKSpriteNode(texture: firstFrameTexture)
        
     
    }
    func animateStrawberry(frame:[SKTexture] ) {
        strawberry.run(SKAction.repeatForever(
        SKAction.animate(with: frame,
                         timePerFrame: 0.6,
                         resize: false,
                         restore: true)),
        withKey:"strawberry")
    }
    func happyStrawberry(){
        
        strawberry.removeAction(forKey: "strawberry")
        animateStrawberry(frame: HappyFrames)
     }
    
    func sadStrawberry(){
        strawberry.removeAction(forKey: "strawberry")
        animateStrawberry(frame: SadFrames)
     }
    func waitingStrawberry(){
        
        strawberry.removeAction(forKey: "strawberry")
        animateStrawberry(frame: WaitingFrames)
     }
  
    
    func stopStrawberry(){
        strawberry.removeAction(forKey: "strawberry")
    }
    func  removeStrawberry(){
        strawberry.removeFromParent()
      
    }
    
 
}


    
