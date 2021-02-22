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
        AddLevels.one()
        AddLevels.two()
        AddLevels.three()
        AddLevels.four()
        
    }
    
    //MARK: -Set up UI Element
    
    //setScens
    func setScene(){
        
        self.challengeScen = gameScen.scene as! GameScene
        self.challengeScen!.viewController = self
        
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
        
        let toppings = order.toppings
        self.challengeScen?.setOrderContent(with: base!, toppings)
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
    
    //MARK: - Calculate Score Functions
    
    //calculateScore
    func calculateScore(for answer:Answer?) -> Int{
        
        //Unwrap current order
        guard getCurrentOrder() != nil else {
            //Fail umwrapping
            return 0
        }
        
        guard let answer = answer else {
            //No answer provided!
            return 0
        }
        
        //check time
        if (answer.atTime == 0){ //May changed
            return 0
        }
        
        //get order score
        let orderScore = calculateOrderScore(for: answer)
        //get payment score
        let paymentScore = calculatePaymentScore(with: answer.cahnge)
        
        //Sum scors
        let totalScore = paymentScore + orderScore
        print("Total order score :", orderScore,"\t Total order score :", paymentScore)
        print("Total score :", totalScore)
        return totalScore
    }
    
    //calculatePaymentScore
    func calculatePaymentScore(with chenge:Float) -> Int{
        
        let totalBill = getTotalBill()
        let expectedChange = getCurrentOrder()!.customerPaid! - totalBill
        print("expected Change \t = ",expectedChange)
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
    
    //calculateOrderScore
    func calculateOrderScore(for answer:Answer) -> Int {
        
        var totalSocre = 0
        
        //Declaration variabels
        let currentOrder = getCurrentOrder()!
        let currentToppings = currentOrder.toppings
        
        let providedToppings = answer.toppings
        //Check Base
        
        //check base if exist
        if answer.base == nil {
            return totalSocre
        }
        
        //check base type
        if answer.base == currentOrder.base{
            totalSocre += 1
        }else if currentToppings == nil {
            //Order doesn't contain toppings and wrong base
            return totalSocre
        }
        
        //Start checking the toppings
        //check if there're toppings - nil means correct type and number
        if providedToppings == nil && currentToppings == nil{
            
            totalSocre += 2
        }else if var toppings = providedToppings {
            
            //check toppings number
            if providedToppings?.count == currentToppings?.count {
                totalSocre += 1 }
            
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
            
        }
        
        return totalSocre
        
    }
    
    
    //MARK:  Calculate Score Helper functions
    
    func getCurrentOrder() ->  Order? {
        return (self.orders?[self.currentOrder])
    }
    
    //getTotalBill
    func getTotalBill()->Float{
        
        //get Order base  and toppings
        let currentOrder = getCurrentOrder()!
        let currentToppings = currentOrder.toppings
        
        var total:Float = (currentOrder.base!.getPrice())
        
        guard let toppings = currentToppings else {
            //No Toppings
            return total
        }
        
        //Calculate Toppings prices
        for t in toppings {
            total += t.getPrice()
        }
        
        return total
        
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
