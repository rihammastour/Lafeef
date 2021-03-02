//
//  ChallengeLevelsViewController.swift
//  Lafeef
//
//  Created by Renad nasser on 28/01/2021.
//

import UIKit
import SpriteKit
import GameplayKit
class ChallengeLevelsViewController: UIViewController {

    //MARK: - Proprites
    
    //Buttons
    @IBOutlet weak var levelOneButton: UIButton!
    
    //MARK: - Life cycle functions
    override func viewDidLoad() {
        super.viewDidLoad()
     
        }
  
 
    @IBAction func goBackTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated:true)

    }
    
    
    @IBAction func lossing(_ sender: Any) {
        if let scene = GKScene(fileNamed: "lossingReport") {
            
            // Get the SKScene from the loaded GKScene
            if let sceneNode = scene.rootNode as! GameScene? {
                
                // Copy gameplay related content over to the scene
                sceneNode.entities = scene.entities
                sceneNode.graphs = scene.graphs
                
                // Set the scale mode to scale to fit the window
                sceneNode.scaleMode = .aspectFill
                
                // Present the scene
                if let view = self.view as! SKView? {
                    view.presentScene(sceneNode)
                    view.ignoresSiblingOrder = true
                    view.showsFPS = true
                    view.showsNodeCount = true
                }
            }
        }
    }

    @IBAction func winning(_ sender: Any) {
        if let scene = GKScene(fileNamed: "WinningReport") {
            
            // Get the SKScene from the loaded GKScene
            if let sceneNode = scene.rootNode as! GameScene? {
                
                // Copy gameplay related content over to the scene
                sceneNode.entities = scene.entities
                sceneNode.graphs = scene.graphs
                
                // Set the scale mode to scale to fit the window
                sceneNode.scaleMode = .aspectFill
                
                // Present the scene
                if let view = self.view as! SKView? {
                    view.presentScene(sceneNode)
                    view.ignoresSiblingOrder = true

                    view.showsFPS = true
                    view.showsNodeCount = true
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.Segue.challengeSegue {
                        print("Segue proformed")
            ChallengeViewController.levelNum = "1"
            GameScene.circleDecrement=true

            
        }
    }
 
    
}
