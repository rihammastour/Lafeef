//
//  ChallengeViewController.swift
//  Lafeef
//
//  Created by Renad nasser on 07/02/2021.
//

import UIKit
import CodableFirebase
import SpriteKit
import GameplayKit
class ChallengeViewController: UIViewController {
    
    //MARK: - Proprites
    var levelNum:String?
    var orderNum:String?
       
    //MARK: - Lifecycle functions
    override func viewDidLoad() {
        super.viewDidLoad()
        // Additional setup after loading the view.
        setUpElements()
        fetchChallengeLevel()
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
//        let order2 = Order(allTime: 120, base: "cake", size: 1, toppings:["strawberry":1])
//        self.present(order2.showOrder(), animated: true)
        let timer2 = OrderTimer()
        self.present(timer2.timer(time: 18), animated: true)

    }
    //MARK: -Set up UI Element
    func setUpElements(){
        //Set Bekary background
//        setScene()
    }
    
    
    func setScene(){
        if let scene = GKScene(fileNamed: "tryChallenge") {
            
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
    
    
    //MARK: - Functions
    
    @IBAction func TimerTapped(_ sender: Any) {
        //startTheTimer = true
    }
    
    func fetchChallengeLevel(){
       
        
        guard let levelNum = levelNum else {
            print("Return number does't passed")
            //TODO: Alert..
            return
        }
        
        FirebaseRequest.getChallengeLvelData(for: levelNum ) { (data, err) in
            if err != nil{
                print("Challenge View Controller",err!)
                 if err?.localizedDescription == "Failed to get document because the client is offline."{
                    print("تأكد من اتصال الانترنيت")
                    //TODO: Alert and update button and logout
                }

            }else{
                
                do{
                    //Convert data to type Child
                    let level = try FirebaseDecoder().decode(Level.self, from: data!)
                    print("Level information object",level)

                }catch{
                    print("error while decoding ",error.localizedDescription)
                    //TODO:Alert..
                }
                
            }
        }
        
    }
    
 
    
 


}//END CLASS


//MARK

//
//extension TimeInterval {
//    var time: String {
//        return String(format:"%02d:%02d", Int(self/60),  Int(ceil(truncatingRemainder(dividingBy: 60))) )
//    }
//}
//extension Int {
//    var degreesToRadians : CGFloat {
//        return CGFloat(self) * .pi / 180
//    }
//}

