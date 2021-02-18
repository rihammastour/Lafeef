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
    func animateCustomer(frame:[SKTexture], speed: Double ) {
        customer.run(SKAction.repeatForever(
        SKAction.animate(with: frame,
                         timePerFrame: speed,
                         resize: false,
                         restore: true)),
        withKey:"\(customerName)")
    }
    func happyCustomer(){
        
       // customer.removeAction(forKey: "\(customerName)")
        animateCustomer(frame: HappyFrames, speed: 0.5)
     }
    
    func sadCustomer(){
       // customer.removeAction(forKey: "\(customerName)")
        animateCustomer(frame: SadFrames , speed: 0.5)
     }
    func waitingCustomer(){
        
       // customer.removeAction(forKey: "\(customerName)")
        animateCustomer(frame: WaitingFrames , speed: 0.5)
     }
    func walkingCustomer(){
        
       // customer.removeAction(forKey: "\(customerName)")
        animateCustomer(frame: WalkingFrames , speed: 0.3)
     }
    func normalCustomer(){
        
       // customer.removeAction(forKey: "\(customerName)")
        animateCustomer(frame: WalkingFrames , speed: 0.3)
     }
  //
    
    func stopCustomer(){
       customer.removeAction(forKey: "\(customerName)")
      //  customer.removeAllActions()
        
    }
    func  removeCustomer(){
        customer.removeFromParent()
      
    }
    
    func GoTOCachier(customerNode : CustomerNode, customerSatisfaction : String) {
       
        var ActuallAction = SKAction()
        
        switch customerSatisfaction {
        case "happy":
                customerNode.happyCustomer()
            Timer.scheduledTimer(timeInterval: 4.5, target: self, selector: #selector(moveToChashier2), userInfo: nil, repeats: false)
            break

        case "sad":
                customerNode.sadCustomer()
            Timer.scheduledTimer(timeInterval: 4.5, target: self, selector: #selector(moveSad), userInfo: nil, repeats: false)
            break
        
    
        default:
                customerNode.normalCustomer()
            Timer.scheduledTimer(timeInterval: 4.5, target: self, selector: #selector(moveToChashier2), userInfo: nil, repeats: false)
            

        }
        
    
        
        
        
    }
    
    @objc func moveToChashier2() {
        let moveAction = SKAction.moveBy(x: 750 , y: 0 , duration: 3)
        let WalkingAction = SKAction.run({ [weak self] in
            self?.walkingCustomer()
        })
        let moveActionWithDone = SKAction.sequence([  WalkingAction, moveAction] )
        self.customer.run(moveActionWithDone)
        
    }
    
    @objc func moveSad() {
        let moveAction = SKAction.moveBy(x: -600 , y: 0 , duration: 3)
        let WalkingAction = SKAction.run({ [weak self] in
            self?.walkingCustomer()
        })
        let moveActionWithDone = SKAction.sequence([  WalkingAction, moveAction] )
        self.customer.run(moveActionWithDone)
        
    }
}
