//
//  ProgressBarViewController.swift
//  Lafeef
//
//  Created by Renad nasser on 17/02/2021.
//

import SpriteKit
import UIKit

class PrograssBar: SKNode{
    
    var prograssNode: SKSpriteNode!
    
    func configure(at position: CGPoint) {
        self.position = position
        
        //Create the mask node
        let node = SKSpriteNode()
        node.texture = SKTexture.init(imageNamed: "progressbar-mask")
        node.alpha = 0.8
        
        //Create the crop node
        let cropNode = SKCropNode()
        cropNode.position = position
        cropNode.zPosition = 1
        //adding mask to hide the prograss bar
        cropNode.maskNode = node
        
        //Intilise the real prograss node
        prograssNode = SKSpriteNode(imageNamed: "progress-bar")
        prograssNode.position = position
        prograssNode.name = "progressBar"
        
        //add real prograss node as child of crop node
        cropNode.addChild(prograssNode)
        addChild(cropNode)
        
    }
    
    
}
