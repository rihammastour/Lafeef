//
//  StoreViewController.swift
//  Lafeef
//
//  Created by Renad nasser on 28/01/2021.
//

import UIKit

class StoreViewController: UIViewController {
    
    @IBOutlet weak var moneyBarUIView: UIView!
    
    @IBOutlet weak var testLabel: UILabel!
    var money:Float!
    
    @IBOutlet weak var moneyUILabel: UILabel!
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setUIElements()
        getChildMoney()
        
    }
    
    
    //MARK: - Set UI Elements
    func setUIElements(){
        Utilities.styleBarView(moneyBarUIView)
    }
    
    //MARK: - Set Content for UI Elements
    
    func updateMoney(_ money:Float){
        self.money = money
        moneyUILabel.text = String(self.money)
    }
    
    //MARK:- Functions
    
    func getChildMoney(){
        
        let child = LocalStorageManager.getChild()
        if let child = child {
            updateMoney(child.money)
        }else{
            self.money = 0
            print("No Child Found")
            //TODO: Alert and back button..
        }
        
    }
    
    //Buy Item
    func buyItem(_ cost:Float){
        
        let leftMoney = self.money - cost
        
        if leftMoney >= 0 {
            FirebaseRequest.updateMoney(leftMoney) { (success, errore) in
                if !success{
                    //Purches won't complated
                    self.showAlert(with: "خطأ حدث اثناء اتمام عملية الشراء ، الرجاء اعادة المحاولة لاحقاً")
                    
                }else{
                    self.updateMoney(leftMoney)
                }
            }
        }else{
            //Not enughe money to buy
            self.showAlert(with:"ليس لديك مال كافِ لإتمام عملية الشراء")
        }
        
    }
    
    
    //MARK: - @IBAcation
    @IBAction func goBackTapped(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func buyWithMoney(_ sender: Any) {
        buyItem(40)
    }
    @IBAction func didChangeSegment(_ sender:UISegmentedControl){
        
        if sender.selectedSegmentIndex == 0{
            testLabel.text = "Store Screen"
        } else if sender.selectedSegmentIndex == 1{
            testLabel.text = "Store Screen - Store"
        }
    }
    
    //MARK: - Dalegate
    
    func showAlert(with message:String){
        let alert = AlertService()
        let alertVC = alert.Alert(body: message)
        
        self.present(alertVC, animated: true)
    }
    
}



