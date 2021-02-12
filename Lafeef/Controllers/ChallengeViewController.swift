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
    var levelNum:String? = "1"
    var currentOrder = 0
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
        
    }
    //MARK: -Set up UI Element
    
    //setUpElements
    func setUpElements(){
        setScene()
    }
    
    
    //setScens
    func setScene(){
        if let scene = GKScene(fileNamed: "tryChallenge") {
            
            // Get the SKScene from the loaded GKScene
            if let sceneNode = scene.rootNode as! GameScene? {
                
                // Copy gameplay related content over to the scene
                sceneNode.entities = scene.entities
                sceneNode.graphs = scene.graphs
                
                // Set the scale mode to scale to fit the window
                sceneNode.scaleMode = SKSceneScaleMode.resizeFill
                
              //  sceneNode.scaleMode = .aspectFill

                
            }
            
        }
        
    }
    
    
    //MARK: - Functions
    
    //fethChallengeLevel
    func fetchChallengeLevel(){
        
        guard let levelNum = levelNum else {
            //TODO: Alert
            showAlert(with: "لا يوجد طلبات لهذا اليوم")//Not working
            return
        }
        
        FirebaseRequest.getChallengeLvelData(for: levelNum, completion:feachChallengeLevelHandler(_:_:))
        
    }
    
    //setLevelInfo
    func setLevelInfo(_ level:Level) -> Void {
        self.duration = level.duration
        self.orders = level.orders
    //showOrder(at: 2) // must be called by character
    }
    
    //showOrder
    func showOrder(at number:Int) -> Void {
        let order = orders![number]
        self.present(order.showOrder(), animated: true)
    }
    
    //nextOrder
    func nextOrder(){
        if currentOrder <= 3{
            currentOrder = currentOrder + 1
            showOrder(at: currentOrder)
        }else{
            //TODO:End Level
        }
    }
    
    
    //MARK: - Actions
    
    //MARK: - Delegate handeler
    
    //showAlert
    func showAlert(with message:String) {
        print("Invoked")
        alert.Alert(body: message)
    }
    
    //feachChalengeLevelHandeler
    func feachChallengeLevelHandler(_ data:Any?,_ err:Error?) -> Void {
        
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
