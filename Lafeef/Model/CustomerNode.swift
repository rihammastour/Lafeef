//
//  AppleNode.swift
//  Lafeef
//
//  Created by Mihaf on 04/07/1442 AH.
//

import Foundation
import SpriteKit
import GameplayKit

class CustomerNode {
    var customer = SKSpriteNode()
    var WalkingFrames: [SKTexture] = []
    var WaitingFrames: [SKTexture] = []
    var HappyFrames: [SKTexture] = []
    var SadFrames: [SKTexture] = []
    var customerName = ""
    
    init(customerName: String) {
        self.customerName = customerName
    }
    
    func buildCustomer() {
        
        let WalkingAppleAtlas = SKTextureAtlas(named: "NW" + customerName)
        var walkingAppleFrames: [SKTexture] = []
        
        
        let WaitingAppleAtlas = SKTextureAtlas(named: "Waiting" + customerName)
        var waitingAppleFrames: [SKTexture] = []
        
        
        let HappyAppleAtlas = SKTextureAtlas(named: "Happy" + customerName)
        var happyAppleFrames: [SKTexture] = []
        
        
        let SadAppleaAtlas = SKTextureAtlas(named: "Sad" + customerName)
        var sadAppleFrames: [SKTexture] = []
        
        
        
        let WaitingImages = WaitingAppleAtlas.textureNames.count
        let WalkingImages = WalkingAppleAtlas.textureNames.count
        let HappyImages = HappyAppleAtlas.textureNames.count
        let SadImages = SadAppleaAtlas.textureNames.count
        
        
      for i in 1...WaitingImages {
        let AppleTextureName = "Waiting\(customerName)\(i)"
        waitingAppleFrames.append(WaitingAppleAtlas.textureNamed(AppleTextureName))
      }
        
        for i in 1...WalkingImages {
          let AppleTextureName = "NW\(customerName)\(i)"
            walkingAppleFrames.append(WalkingAppleAtlas.textureNamed(AppleTextureName))
        }
        
        
        for i in 1...HappyImages {
          let AppleTextureName = "Happy\(customerName)\(i)"
            happyAppleFrames.append(HappyAppleAtlas.textureNamed(AppleTextureName))
        }
        
        
        for i in 1...SadImages {
          let AppleTextureName = "Sad\(customerName)\(i)"
            sadAppleFrames.append(SadAppleaAtlas.textureNamed(AppleTextureName))
        }
        

        
    WaitingFrames = waitingAppleFrames
    HappyFrames = happyAppleFrames
    SadFrames = sadAppleFrames
    WalkingFrames = walkingAppleFrames
        
    let firstFrameTexture = waitingAppleFrames[0]
    customer = SKSpriteNode(texture: firstFrameTexture)
        
     
    }
    func animateCustomer(frame:[SKTexture] ) {
        customer.run(SKAction.repeatForever(
        SKAction.animate(with: frame,
                         timePerFrame: 0.6,
                         resize: false,
                         restore: true)),
        withKey:"\(customerName)")
    }
    func happyApple(){
        
        customer.removeAction(forKey: "\(customerName)")
        animateCustomer(frame: HappyFrames)
     }
    
    func sadCustomer(){
        customer.removeAction(forKey: "\(customerName)")
        animateCustomer(frame: SadFrames)
     }
    func waitingCustomer(){
        
        customer.removeAction(forKey: "\(customerName)")
        animateCustomer(frame: WaitingFrames)
     }
  //
    
    func stopCustomer(){
        customer.removeAction(forKey: "\(customerName)")
    }
    func  removeCustomer(){
        customer.removeFromParent()
      
    }
}
