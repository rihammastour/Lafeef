//
//  WatermelonNode.swift
//  Lafeef
//
//  Created by Mihaf on 04/07/1442 AH.
//

import Foundation
import Foundation
import SpriteKit
import GameplayKit

class WatermelonNode {
    var watermelon = SKSpriteNode()
    var WalkingFrames: [SKTexture] = []
    var WaitingFrames: [SKTexture] = []
    var HappyFrames: [SKTexture] = []
    var SadFrames: [SKTexture] = []
    
    func buildWatermelon() {
        
        let WalkingWatermelonAtlas = SKTextureAtlas(named: "NWWatermelon")
        var walkingWatermelonFrames: [SKTexture] = []
        
        
        let WaitingWatermelonAtlas = SKTextureAtlas(named: "WaitingWatermelon")
        var waitingWatermelonFrames: [SKTexture] = []
        
        
        let HappyWatermelonAtlas = SKTextureAtlas(named: "HappyWatermelon")
        var happyWatermelonFrames: [SKTexture] = []
        
        
        let SadWatermelonaAtlas = SKTextureAtlas(named: "SadWatermelon")
        var sadWatermelonFrames: [SKTexture] = []
        
        
        
        let WaitingImages = WaitingWatermelonAtlas.textureNames.count
        let WalkingImages = WalkingWatermelonAtlas.textureNames.count
        let HappyImages = HappyWatermelonAtlas.textureNames.count
        let SadImages = SadWatermelonaAtlas.textureNames.count
        
        
      for i in 1...WaitingImages {
        let WatermelonTextureName = "WaitingWatermelon\(i)"
        waitingWatermelonFrames.append(WaitingWatermelonAtlas.textureNamed(WatermelonTextureName))
      }
        
        for i in 1...WalkingImages {
          let WatermelonTextureName = "NWWatermelon\(i)"
            walkingWatermelonFrames.append(WalkingWatermelonAtlas.textureNamed(WatermelonTextureName))
        }
        
        
        for i in 1...HappyImages {
          let WatermelonTextureName = "HappyWatermelon\(i)"
            happyWatermelonFrames.append(HappyWatermelonAtlas.textureNamed(WatermelonTextureName))
        }
        
        
        for i in 1...SadImages {
          let WatermelonTextureName = "SadWatermelon\(i)"
            sadWatermelonFrames.append(SadWatermelonaAtlas.textureNamed(WatermelonTextureName))
        }
        

        
    WaitingFrames = waitingWatermelonFrames
    HappyFrames = happyWatermelonFrames
    SadFrames = sadWatermelonFrames
    WalkingFrames = walkingWatermelonFrames
        
    let firstFrameTexture = waitingWatermelonFrames[0]
    watermelon = SKSpriteNode(texture: firstFrameTexture)
        
     
    }
    func animateWatermelon(frame:[SKTexture] ) {
        watermelon.run(SKAction.repeatForever(
        SKAction.animate(with: frame,
                         timePerFrame: 0.6,
                         resize: false,
                         restore: true)),
        withKey:"Watermelon")
    }
    func happyWatermelon(){
        
        watermelon.removeAction(forKey: "Watermelon")
        animateWatermelon(frame: HappyFrames)
     }
    
    func sadWatermelon(){
        watermelon.removeAction(forKey: "Watermelon")
        animateWatermelon(frame: SadFrames)
     }
    func waitingWatermelon(){
        
        watermelon.removeAction(forKey: "Watermelon")
        animateWatermelon(frame: WaitingFrames)
     }
  
    
    func stopWatermelon(){
        watermelon.removeAction(forKey: "Watermelon")
    }
    func  removeWatermelon(){
        watermelon.removeFromParent()
      
    }
}
    
