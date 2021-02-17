//
//  PearNode.swift
//  Lafeef
//
//  Created by Mihaf on 04/07/1442 AH.
//

import Foundation

import SpriteKit
import GameplayKit

class PearNode {
    var pear = SKSpriteNode()
    var WalkingFrames: [SKTexture] = []
    var WaitingFrames: [SKTexture] = []
    var HappyFrames: [SKTexture] = []
    var SadFrames: [SKTexture] = []
    
    func buildPear() {
        //
        
        let WalkingPearAtlas = SKTextureAtlas(named: "NWPear")
        var walkingPearFrames: [SKTexture] = []
        
        
        let WaitingPearAtlas = SKTextureAtlas(named: "WaitingPear")
        var waitingPearFrames: [SKTexture] = []
        
        
        let HappyPearAtlas = SKTextureAtlas(named: "HappyPear")
        var happyPearFrames: [SKTexture] = []
        
        
        let SadPearaAtlas = SKTextureAtlas(named: "SadPear")
        var sadPearFrames: [SKTexture] = []
        
        
        
        let WaitingImages = WaitingPearAtlas.textureNames.count
        let WalkingImages = WalkingPearAtlas.textureNames.count
        let HappyImages = HappyPearAtlas.textureNames.count
        let SadImages = SadPearaAtlas.textureNames.count
        
        
      for i in 1...WaitingImages {
        let PearTextureName = "WaitingPear\(i)"
        waitingPearFrames.append(WaitingPearAtlas.textureNamed(PearTextureName))
      }
        
        for i in 1...WalkingImages {
          let PearTextureName = "NWPear\(i)"
            walkingPearFrames.append(WalkingPearAtlas.textureNamed(PearTextureName))
        }
        
        
        for i in 1...HappyImages {
          let PearTextureName = "HappyPear\(i)"
            happyPearFrames.append(HappyPearAtlas.textureNamed(PearTextureName))
        }
        
        
        for i in 1...SadImages {
          let PearTextureName = "SadPear\(i)"
            sadPearFrames.append(SadPearaAtlas.textureNamed(PearTextureName))
        }
        

        
    WaitingFrames = waitingPearFrames
    HappyFrames = happyPearFrames
    SadFrames = sadPearFrames
    WalkingFrames = walkingPearFrames
        
    let firstFrameTexture = waitingPearFrames[0]
    pear = SKSpriteNode(texture: firstFrameTexture)
        
     
    }
    func animatePear(frame:[SKTexture] ) {
        pear.run(SKAction.repeatForever(
        SKAction.animate(with: frame,
                         timePerFrame: 0.6,
                         resize: false,
                         restore: true)),
        withKey:"Pear")
    }
    func happyPear(){
        
        pear.removeAction(forKey: "Pear")
        animatePear(frame: HappyFrames)
     }
    
    func sadPear(){
        pear.removeAction(forKey: "Pear")
        animatePear(frame: SadFrames)
     }
    func waitingPear(){
        
        pear.removeAction(forKey: "Pear")
        animatePear(frame: WaitingFrames)
     }
  
    
    func stopPear(){
        pear.removeAction(forKey: "Pear")
    }
    func  removePear(){
        pear.removeFromParent()
      
    }
}
    
