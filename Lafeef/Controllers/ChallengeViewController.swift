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
    
    @IBOutlet weak var stopGame: UIButton!
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
    
//    @IBAction func pauseGame(_ sender: Any) {
//        GameScene.timeLeft = GameScene.timeLeft
//        
//GameScene.timer.invalidate()
//    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.Segue.menuSegue {
            let vc = segue.destination as! PauseGameViewController
                        print("Segue proformed")
            
            GameScene.timeLeft = GameScene.timeLeft
            GameScene.timer.invalidate()
            print(GameScene.timeLeft.time)
//            vc.levelNum = "1"
            
        }
    }
    //setScens
    func setScene(){
        
        self.challengeScen = gameScen.scene as! GameScene
        
    }
    
    
    //MARK: - Functions
    
    //fethChallengeLevel
    func fetchChallengeLevel(){
        
        guard let levelNum = levelNum else {
            //TODO: Alert and go back
            showAlert(with: "لا يوجد طلبات لهذا اليوم")//Not working
            return
        }
        
        FirebaseRequest.getChallengeLvelData(for: levelNum, completion:feachChallengeLevelHandler(_:_:))
        
    }
    
    //setLevelInfo
    func setLevelInfo(_ level:Level) -> Void {
        self.duration = level.duration
        self.orders = level.orders
        showOrder(at: currentOrder) // must be called by character
    }
    
    //showOrder
    func showOrder(at number:Int) -> Void {
        
        let order = orders![number]
        let base = order.base
        
        let toppings = PrepareOrderController.getToppingsName(from: order.toppings)
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
    
    
    //MARK: - Delegate handeler
    
    //showAlert
    func showAlert(with message:String) {
        alert.Alert(body: message)
    }
    
    //feachChalengeLevelHandeler
    func feachChallengeLevelHandler(_ data:Any?,_ err:Error?) -> Void {
        
        if err != nil{
            print("Challenge View Controller",err!)
            
            if err?.localizedDescription == "Failed to get document because the client is offline."{
                print("تأكد من اتصال الانترنيت")
                //TODO: Alert and update button and go back
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
