//
//  StoreViewController.swift
//  Lafeef
//
//  Created by Renad nasser on 28/01/2021.
//

import UIKit
import CodableFirebase


class StoreViewController: UIViewController {
    
    //MARK:- Variabels
    
    //@IBOustlet
    @IBOutlet weak var moneyBarUIView: UIView!
    @IBOutlet weak var moneyUILabel: UILabel!
    @IBOutlet weak var segmentedControlUI: UISegmentedControl!
    
    @IBOutlet weak var tableView: UITableView!
    
    //Variables
    var money:Float!
    var bakeryEquipments:[StoreEquipment]?
    var characterEquipments:[StoreEquipment]?
    
    var tableData:[StoreEquipment]?
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Additional setup after loading the view.
        setUIElements()
        getChildMoney()
        fechStoreEquipment()

        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        if let indexPath = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: indexPath, animated: false)
            tableView.reloadRows(at: [indexPath], with: .fade)
        }
        tableView.reloadData()
    }
    
    //MARK: - Set UI Elements
    func setUIElements(){
        
        //Style money bar
        Utilities.styleBarView(moneyBarUIView)
        
        //Style segmented control
        Utilities.styleSegmentedControl(segmentedControlUI)
        
        tableView.rowHeight = 100
        
    }
    
    //MARK: - Set Content for UI Elements
    
    func updateMoney(_ money:Float){
        self.money = money
        moneyUILabel.text = String(self.money)
    }
    
    //MARK:- Functions
    
    func fechStoreEquipment(){
        
        //Get bakery Equibments
        FirebaseRequest.getBakeryEquipment(completion: getBakeryEquipmentHandler(_:_:))
        //Get Character Equibments
        FirebaseRequest.getCharacterEquipment(completion: getCharacterEquipmentHandler(_:_:))
        
    }
    
    
    //get child money
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
    @IBAction func didChangeSegment(_ sender:UISegmentedControl){
        
        if sender.selectedSegmentIndex == 0{
            tableData = self.characterEquipments
            tableView.reloadData()
        } else if sender.selectedSegmentIndex == 1{
            tableData = self.bakeryEquipments
            tableView.reloadData()
        }
    }
    
    //MARK: - Dalegate
    
    func showAlert(with message:String){
        let alert = AlertService()
        let alertVC = alert.Alert(body: message)
        
        self.present(alertVC, animated: true)
    }
    
    ///fetch image
//    func fetchImage(of name:String) -> NSData?{
//        var data =
//        FirebaseRequest.downloadStoreEquipmentImage(type: name, completion: {(data, err)  in
//            if err == nil{
//                return nil
//            }else{
//                return data
//            }
//        })
//    }
    
    
    //Get Bakery Handeler
    func getBakeryEquipmentHandler(_ data: Any?, _ error :Error?){
        
        if let data = data{
            do{
                //Convert data to type StoreEquipmens
                let equipmens = try FirebaseDecoder().decode(StoreEquipmens.self, from: data)
                
                self.bakeryEquipments = equipmens.eqippments
                self.tableData = equipmens.eqippments
                tableView.reloadData()
            }catch{
                print("error while decoding ",error.localizedDescription)
                //TODO:Alert..
            }
        }else{
            print("error!! App delagate - No data passed",error?.localizedDescription ?? "error localized Description" )
            //TODO:Alert..
        }
    }
    
    //Get Character Handeler
    func getCharacterEquipmentHandler(_ data: Any?, _ error :Error?){
        
        if let data = data{
            do{
                //Convert data to type StoreEquipmens
                let equipmens = try FirebaseDecoder().decode(StoreEquipmens.self, from: data)
                self.characterEquipments = equipmens.eqippments
                tableView.reloadData()
            }catch{
                print("error while decoding ",error.localizedDescription)
                //TODO:Alert..
            }
        }else{
            print("error!! App delagate - No data passed",error?.localizedDescription ?? "error localized Description" )
            //TODO:Alert..
        }
    }
    
}


// MARK: - Table view data source

extension StoreViewController : UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return  1
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let aEquipment = tableData?[(indexPath as NSIndexPath).row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "StoreCell", for: indexPath) as! StoreCell
        
        // Configure cell
        if let aEquipment = aEquipment{
            cell.label.text = aEquipment.label
            cell.equipmentImage.image = UIImage(named: "imagePlaceholder")

            FirebaseRequest.downloadStoreEquipmentImage(type: aEquipment.name) { (data, error) in
                guard let data = data else{
                    return
                }
                
                let image = UIImage(data: data as Data)
                cell.equipmentImage?.image = image
                cell.setNeedsLayout()
            }
            
        }
        return cell
        
        
    }
    
}
