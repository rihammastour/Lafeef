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
    var challengeScen:GameScene?
    
    //Outlet
    @IBOutlet weak var gameScen: SKView!
    
    //MARK: - Lifecycle functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Additional setup after loading the view.
        setScene()
        fetchChallengeLevel()
        
    }
    
    //MARK: -Set up UI Element
    
    //setScens
    func setScene(){
        
        self.challengeScen = gameScen.scene as! GameScene

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
        showOrder(at: 3) // must be called by character
    }
    
    //showOrder
    func showOrder(at number:Int) -> Void {
        print("show order at challenge vc invoked")
        let order = orders![number]
        let base = Base.vanilaCupcake
            //PrepareOrderViewController.gatBaseName(order.base)
        
        let toppings = [Topping.kiwi]
            //PrepareOrderViewController.getToppingsName(from: order.toppings)
        
        self.challengeScen?.setOrderContent(with: base, toppings)
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
