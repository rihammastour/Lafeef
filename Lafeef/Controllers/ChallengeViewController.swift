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
            GameScene.circleBool=false
            GameScene.circle!.isPaused=true
//            GameScene.circle?.speed=0
//            GameScene.circle?.removeAllActions()
            print(GameScene.timeLeft.time)
//            vc.levelNum = "1"
            
        }
    }
    //setScens
    func setScene(){
        
        self.challengeScen = gameScen.scene as! GameScene
        self.challengeScen?.viewController = self
        
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
        showOrder(at: currentOrder) // must be Moved to be called by character
        print(calculatePaymentScore(with: 0)) //must be Moved to be called after user provid the answer
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
    
    //MARK: - Calculate Score
    
    //calculateScore
    func calculateScore(for providedBase:Base?,_ providedToppings:[Topping]?,_ chenge:Float,on time:Bool){
        
        //get order score
        let orderScore = calculateOrderScore(for: providedBase, providedToppings, on: time)
        //get payment score
        let paymentScore = calculatePaymentScore(with: chenge)
        
        //Sum scors
        let totalScore = paymentScore + orderScore
        print("Total score",totalScore)
    }
    
    func calculatePaymentScore(with chenge:Float) -> Int{
        
        let totalBill = calculateTotalBill()
        print("totalBill = ",totalBill)
        let expectedChange = getCurrentOrder()!.customerPaid - totalBill
        print("expectedChange = ",expectedChange)
        
        //No change and child make a change
        if expectedChange == 0 && chenge != 0 {
            return 0
        }
        
        //There's a change and child did not make one
        if expectedChange != 0 && chenge == 0 {
            return 0
        }
        
        if expectedChange == chenge {
            return 3
        }else if expectedChange < chenge {
            return 2
        }else{
            return 1
        }
        
        
    }
    
    func calculateTotalBill()->Float{
        
        //get Order
        let currentOrder = orders?[self.currentOrder]
        let currentToppings = PrepareOrderController.getToppingsName(from: currentOrder?.toppings)
        
        
        guard currentOrder != nil else {
            return 0
        }
        
        var total:Float = (currentOrder?.base.getPrice())!
        
        guard let toppings = currentToppings else {
            return total
        }
        
        for t in toppings {
            total += t.getPrice()
        }
        
        return total
        
    }
    
    
    //calculateOrderScore
    func calculateOrderScore(for providedBase:Base?,_ providedToppings:[Topping]?,on time:Bool) -> Int {
        
        var totalSocre = 0
        
        //check time
        if !(time){
            return totalSocre
        }
        
        //Declaration variabels
        let currentOrder = orders?[self.currentOrder]
        let currentToppings = PrepareOrderController.getToppingsName(from: currentOrder?.toppings)
        
        guard currentOrder != nil else {
            return totalSocre
        }
        
        //Check Base
        
        //check base if exist
        if providedBase == nil {
            return totalSocre
        }
        
        //check base type
        if providedBase == currentOrder?.base{
            totalSocre += 1
        }else if currentToppings == nil {
            //Order doesn't contain toppings and wrong base
            return totalSocre
        }
        
        print("after ceck base TS",totalSocre)
        //Start checking the toppings
        //check if there're toppings - nil means correct type and number
        if providedToppings == nil && currentToppings == nil{
            
            totalSocre += 2
            print("after check nil if toppings TS",totalSocre)
        }else if var toppings = providedToppings {
            
            //check toppings number
            if providedToppings?.count == currentToppings?.count {
                totalSocre += 1 }
            print("after check topping number TS",totalSocre)
            
            //check toppings type
            var i = 0
            for t in toppings{
                if ((currentToppings?.contains(t)) == true) {
                    toppings.remove(at: i)
                }else{
                    i += 1}
            }
            
            if (toppings.isEmpty){
                totalSocre += 1
            }
            print("after check type TS",totalSocre)
            
        }
        
        print("Total score \t",totalSocre)
        return totalSocre
        
    }
    
    func getCurrentOrder() -> Order? {
        return orders?[self.currentOrder]
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
