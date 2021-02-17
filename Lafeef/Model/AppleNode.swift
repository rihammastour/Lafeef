//
//  AppleNode.swift
//  Lafeef
//
//  Created by Mihaf on 04/07/1442 AH.
//

import Foundation
import SpriteKit
import GameplayKit

class AppleNode {
    var apple = SKSpriteNode()
    var WalkingFrames: [SKTexture] = []
    var WaitingFrames: [SKTexture] = []
    var HappyFrames: [SKTexture] = []
    var SadFrames: [SKTexture] = []
    
    func buildApple() {
        
        let WalkingAppleAtlas = SKTextureAtlas(named: "NWApple")
        var walkingAppleFrames: [SKTexture] = []
        
        
        let WaitingAppleAtlas = SKTextureAtlas(named: "WaitingApple")
        var waitingAppleFrames: [SKTexture] = []
        
        
        let HappyAppleAtlas = SKTextureAtlas(named: "HappyApple")
        var happyAppleFrames: [SKTexture] = []
        
        
        let SadAppleaAtlas = SKTextureAtlas(named: "SadApple")
        var sadAppleFrames: [SKTexture] = []
        
        
        
        let WaitingImages = WaitingAppleAtlas.textureNames.count
        let WalkingImages = WalkingAppleAtlas.textureNames.count
        let HappyImages = HappyAppleAtlas.textureNames.count
        let SadImages = SadAppleaAtlas.textureNames.count
        
        
      for i in 1...WaitingImages {
        let AppleTextureName = "WaitingApple\(i)"
        waitingAppleFrames.append(WaitingAppleAtlas.textureNamed(AppleTextureName))
      }
        
        for i in 1...WalkingImages {
          let AppleTextureName = "NWApple\(i)"
            walkingAppleFrames.append(WalkingAppleAtlas.textureNamed(AppleTextureName))
        }
        
        
        for i in 1...HappyImages {
          let AppleTextureName = "HappyApple\(i)"
            happyAppleFrames.append(HappyAppleAtlas.textureNamed(AppleTextureName))
        }
        
        
        for i in 1...SadImages {
          let AppleTextureName = "SadApple\(i)"
            sadAppleFrames.append(SadAppleaAtlas.textureNamed(AppleTextureName))
        }
        

        
    WaitingFrames = waitingAppleFrames
    HappyFrames = happyAppleFrames
    SadFrames = sadAppleFrames
    WalkingFrames = walkingAppleFrames
        
    let firstFrameTexture = waitingAppleFrames[0]
    apple = SKSpriteNode(texture: firstFrameTexture)
        
     
    }
    func animateApple(frame:[SKTexture] ) {
        apple.run(SKAction.repeatForever(
        SKAction.animate(with: frame,
                         timePerFrame: 0.6,
                         resize: false,
                         restore: true)),
        withKey:"Apple")
    }
    func happyApple(){
        
        apple.removeAction(forKey: "Apple")
        animateApple(frame: HappyFrames)
     }
    
    func sadApple(){
        apple.removeAction(forKey: "Apple")
        animateApple(frame: SadFrames)
     }
    func waitingApple(){
        
        apple.removeAction(forKey: "Apple")
        animateApple(frame: WaitingFrames)
     }
  //
    
    func stopApple(){
        apple.removeAction(forKey: "Apple")
    }
    func  removeApple(){
        apple.removeFromParent()
      
    }
}
    
