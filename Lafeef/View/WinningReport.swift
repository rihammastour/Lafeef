//
//  WinningReports.swift
//  Lafeef
//
//  Created by Mihaf on 25/06/1442 AH.
//
import UIKit
import SpriteKit
import GameplayKit

class WinningReport: SKScene {
    var background = SKSpriteNode(imageNamed: "blank-bakery")
    let reports = Reports()
    

    override func didMove(to view: SKView) {
        view.window?.rootViewController?.present(reports.displayWinningReport(), animated: true)
        background.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        background.size = CGSize(width: self.frame.width, height: self.frame.height)
        background.position =  CGPoint(x: 0, y: 0)
        addChild(background)
        
    }
    
    override func sceneDidLoad() {
       

      
    }
    
    
   
  
  
}
