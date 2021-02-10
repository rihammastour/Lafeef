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
        //Variables
    var levelNum:String?
    var currentOrder:Int?
    var duration:Float?
    var orders:[Order]?
    var alert = AlertService()
    
        //Outlet
       
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
        //Start Timer
//        let timer2 = OrderTimer()
//        self.present(timer2.timer(time: 18), animated: true)

    }
    //MARK: -Set up UI Element
    func setUpElements(){
        setScene()
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
    
    func fetchChallengeLevel(){
        
        guard let levelNum = levelNum else {
            //TODO: Alert
//            showAlert(with: "لا يوجد طلبات لهذا اليوم")
//            self.dismiss(animated: true)
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
                    self.setLevelInfo(level)
                    //self.startLevelTimer()
                }catch{
                    print("error while decoding ",error.localizedDescription)
                    //TODO:Alert..
                }
                
            }
        }
        
    }
    
    //setLevelInfo
    func setLevelInfo(_ level:Level) -> Void {
        self.duration = level.duration
        self.orders = level.orders
        self.currentOrder = 0
        showOrder(at: 3) // must be called by character
    }
    
    func showOrder(at number:Int) -> Void {
        let order = orders![number]
        self.present(order.showOrder(), animated: true)
    }
    
 
    //MARK: - Actions
    
    //MARK: - Delegate handeler
    func showAlert(with message:String) {
        alert.Alert(body: message)
    }
 


}
