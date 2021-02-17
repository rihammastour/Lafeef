//
//  OrangeNode.swift
//  Lafeef
//
//  Created by Mihaf on 04/07/1442 AH.
//

import Foundation

import SpriteKit
import GameplayKit

class OrangeNode {
    var orange = SKSpriteNode()
    var WalkingFrames: [SKTexture] = []
    var WaitingFrames: [SKTexture] = []
    var HappyFrames: [SKTexture] = []
    var SadFrames: [SKTexture] = []
    
    func buildOrange() {
        //
        
        let WalkingOrangeAtlas = SKTextureAtlas(named: "NWOrange")
        var walkingOrangeFrames: [SKTexture] = []
        
        let WaitingOrangeAtlas = SKTextureAtlas(named: "WaitingOrange")
        var waitingOrangeFrames: [SKTexture] = []
        
        let HappyOrangeAtlas = SKTextureAtlas(named: "HappyOrange")
        var happyOrangeFrames: [SKTexture] = []
        
        let SadOrangeaAtlas = SKTextureAtlas(named: "SadOrange")
        var sadOrangeFrames: [SKTexture] = []
        
        
        
        let WaitingImages = WaitingOrangeAtlas.textureNames.count
        let WalkingImages = WalkingOrangeAtlas.textureNames.count
        let HappyImages = HappyOrangeAtlas.textureNames.count
        let SadImages = SadOrangeaAtlas.textureNames.count
        
        
      for i in 1...WaitingImages {
        let orangeTextureName = "WaitingOrange\(i)"
        waitingOrangeFrames.append(WaitingOrangeAtlas.textureNamed(orangeTextureName))
      }
        
        for i in 1...WalkingImages {
          let orangeTextureName = "NWOrange\(i)"
            walkingOrangeFrames.append(WalkingOrangeAtlas.textureNamed(orangeTextureName))
        }
        
        
        for i in 1...HappyImages {
          let orangeTextureName = "HappyOrange\(i)"
            happyOrangeFrames.append(HappyOrangeAtlas.textureNamed(orangeTextureName))
        }
        
        
        for i in 1...SadImages {
          let orangeTextureName = "SadOrange\(i)"
            sadOrangeFrames.append(SadOrangeaAtlas.textureNamed(orangeTextureName))
        }
        

        
    WaitingFrames = waitingOrangeFrames
    HappyFrames = happyOrangeFrames
    SadFrames = sadOrangeFrames
    WalkingFrames = walkingOrangeFrames
        
    let firstFrameTexture = waitingOrangeFrames[0]
    orange = SKSpriteNode(texture: firstFrameTexture)
        
     
    }
    func animateOrange(frame:[SKTexture] ) {
        orange.run(SKAction.repeatForever(
        SKAction.animate(with: frame,
                         timePerFrame: 0.6,
                         resize: false,
                         restore: true)),
        withKey:"Orange")
    }
    func happyOrange(){
        
        orange.removeAction(forKey: "Orange")
        animateOrange(frame: HappyFrames)
     }
    
    func sadOrange(){
        orange.removeAction(forKey: "Orange")
        animateOrange(frame: SadFrames)
     }
    func waitingOrange(){
        
        orange.removeAction(forKey: "Orange")
        animateOrange(frame: WaitingFrames)
     }
  
    
    func stopOrange(){
        orange.removeAction(forKey: "Orange")
    }
    func  removeOrange(){
        orange.removeFromParent()
      
    }
 
    
}

