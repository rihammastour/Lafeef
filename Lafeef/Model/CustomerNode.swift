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
    let objectDetected = ObjectDetectionViewController()
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

        animateCustomer(frame: HappyFrames, speed: 0.5)
     }
    
    func sadCustomer(){
 
        animateCustomer(frame: SadFrames , speed: 0.5)
     }
    func waitingCustomer(){
        ObjectDetectionViewController.detectionOverlay.isHidden = false
        animateCustomer(frame: WaitingFrames , speed: 0.5)
     }
    func walkingCustomer(){
     
        animateCustomer(frame: WalkingFrames , speed: 0.3)
     }
    func normalCustomer(){
        ObjectDetectionViewController.detectionOverlay.isHidden = false
        print("normalallll111")
        animateCustomer(frame: WalkingFrames , speed: 0.3)
     }
  //
    
    func stopCustomer(){
       customer.removeAction(forKey: "\(customerName)")
   
        
    }
    func  removeCustomer(){
        customer.removeFromParent()
      
    }
    
    func moveOutSadly(customerNode : CustomerNode){
        customerNode.sadCustomer()
        DispatchQueue.main.asyncAfter(deadline: .now() + 4.5) { [self] in

            moveCustomer(customerNode : customerNode,x: -600, y: 0)
          
           }
    }
    
    func movetoCashier(customerNode : CustomerNode, customerSatisfaction : CustmerSatisfaction) {
        // need to hide ca layer
        print(ObjectDetectionViewController.detectionOverlay, "----------------------------------------")
        


        switch customerSatisfaction {
        case .happey:
             customerNode.happyCustomer()
            DispatchQueue.main.asyncAfter(deadline: .now() + 4.5) { [self] in

                moveCustomer(customerNode : customerNode,x: 650, y: 0)
     

               }
            
         
            print(customerNode.customer.position.x * CGFloat.pi / 180,"Customer postion")
//            if customerNode.customer.position.x == 600 {
//                ObjectDetectionViewController.detectionOverlay.isHidden = false
//                // I think its 480 x and -320 y
//                ObjectDetectionViewController.detectionOverlay.position = CGPoint(x:600, y:230)
//            }
//            
            break

        case .sad:
            customerNode.sadCustomer()
            DispatchQueue.main.asyncAfter(deadline: .now() + 4.5) { [self] in
                moveCustomer(customerNode:customerNode,x: 650, y: 0)
              
               }
         
            break
        
    
        case .normal:

            customerNode.normalCustomer()
            DispatchQueue.main.asyncAfter(deadline: .now() + 4.5) { [self] in
                moveCustomer(customerNode:customerNode,x: 650, y: 0)

            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 9.5) { [self] in
//                ObjectDetectionViewController.detectionOverlay.isHidden = false

               }
        
        
        }

    }
    
    func moveOut(customerNode : CustomerNode, customerSatisfaction : CustmerSatisfaction, completion: @escaping ()->()){
        switch customerSatisfaction {
        case .happey:
                customerNode.happyCustomer()
            break
        case .sad:
            customerNode.sadCustomer()
            break
        case .normal:
            customerNode.normalCustomer()
        }
            DispatchQueue.main.asyncAfter(deadline: .now() + 4.5) { [self] in
                moveCustomer(customerNode: customerNode,x: 1000, y: 0)
            }
        completion()
    }
    
    
 func moveCustomer(customerNode : CustomerNode,x: CGFloat , y: CGFloat) {
    
    let moveAction = SKAction.moveBy(x: x , y: y , duration: 4)
    let WalkingAction = SKAction.run({
        customerNode.walkingCustomer()
        })
        let moveActionWithDone = SKAction.sequence([  WalkingAction, moveAction] )

    customerNode.customer.run(moveActionWithDone)




    }

    }
 
