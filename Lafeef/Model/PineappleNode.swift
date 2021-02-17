//
//  PineappleNode.swift
//  Lafeef
//
//  Created by Mihaf on 04/07/1442 AH.
//

import Foundation

import SpriteKit
import GameplayKit

class PineappleNode {
    let key :String = "Pineapple"
    var pineapple = SKSpriteNode()
    var WalkingFrames: [SKTexture] = []
    var WaitingFrames: [SKTexture] = []
    var HappyFrames: [SKTexture] = []
    var SadFrames: [SKTexture] = []
    
    func buildPineapple() {
        //  //
        
        let WalkingPineappleAtlas = SKTextureAtlas(named: "NWPineapple")
        var walkingPineappleFrames: [SKTexture] = []
        
        
        let WaitingPineappleAtlas = SKTextureAtlas(named: "WaitingPineapple")
        var waitingPineappleFrames: [SKTexture] = []
        
        
        let HappyPineappleAtlas = SKTextureAtlas(named: "HappyPineapple")
        var happyPineappleFrames: [SKTexture] = []
        
        
        let SadPineappleaAtlas = SKTextureAtlas(named: "SadPineapple")
        var sadPineappleFrames: [SKTexture] = []
        
        
        
        let WaitingImages = WaitingPineappleAtlas.textureNames.count
        let WalkingImages = WalkingPineappleAtlas.textureNames.count
        let HappyImages = HappyPineappleAtlas.textureNames.count
        let SadImages = SadPineappleaAtlas.textureNames.count
        
        
      for i in 1...WaitingImages {
        let PineappleTextureName = "WaitingPineapple\(i)"
        waitingPineappleFrames.append(WaitingPineappleAtlas.textureNamed(PineappleTextureName))
      }
        
        for i in 1...WalkingImages {
          let PineappleTextureName = "NWPineapple\(i)"
            walkingPineappleFrames.append(WalkingPineappleAtlas.textureNamed(PineappleTextureName))
        }
        
        
        for i in 1...HappyImages {
          let PineappleTextureName = "HappyPineapple\(i)"
            happyPineappleFrames.append(HappyPineappleAtlas.textureNamed(PineappleTextureName))
        }
        
        
        for i in 1...SadImages {
          let PineappleTextureName = "SadPineapple\(i)"
            sadPineappleFrames.append(SadPineappleaAtlas.textureNamed(PineappleTextureName))
        }
        

        
    WaitingFrames = waitingPineappleFrames
    HappyFrames = happyPineappleFrames
    SadFrames = sadPineappleFrames
    WalkingFrames = walkingPineappleFrames
        
    let firstFrameTexture = waitingPineappleFrames[0]
    pineapple = SKSpriteNode(texture: firstFrameTexture)
        
     
    }
    func animatePineapple(frame:[SKTexture] ) {
        pineapple.run(SKAction.repeatForever(
        SKAction.animate(with: frame,
                         timePerFrame: 0.6,
                         resize: false,
                         restore: true)),
        withKey:"Pineapple")
    }
    func happyPineapple(){
        
        pineapple.removeAction(forKey: "Pineapple")
        animatePineapple(frame: HappyFrames)
     }
    
    func sadPineapple(){
        pineapple.removeAction(forKey: "Pineapple")
        animatePineapple(frame: SadFrames)
     }
    func waitingPineapple(){
        
        pineapple.removeAction(forKey: "Pineapple")
        animatePineapple(frame: WaitingFrames)
     }
  
    
    func stopPineapple(){
        pineapple.removeAction(forKey: "Pineapple")
    }
    func  removePineapple(){
        pineapple.removeFromParent()
      
    }
}
    
