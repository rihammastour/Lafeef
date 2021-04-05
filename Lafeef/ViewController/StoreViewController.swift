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
    var money:Float! = 0
    var sex:String! = "unisex"
    var childEquipments:[ChildEquipment]? = nil
    var bakeryEquipments:[StoreEquipment]? = []
    var characterEquipments:[StoreEquipment]? = []
    
    var tableData:[StoreEquipment]?
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Additional setup after loading the view.
        setUIElements()
        getChildData()
        
        fechStoreEquipment {
            tableView.reloadData()
        }
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
        
        //Style tableView
        tableView.rowHeight = 180
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        
    }
    
    //MARK: - Set Content for UI Elements
    
    func updateMoney(_ money:Float){
        self.money = money
        moneyUILabel.text = String(self.money)
    }
    
    //MARK:- Functions
    
    func fechStoreEquipment(completion:()->Void){
        
        //Get bakery Equibments
        FirebaseRequest.getBakeryEquipment(completion: getBakeryEquipmentHandler(_:_:))
        //Get Character Equibments
        FirebaseRequest.getCharacterEquipment(completion: getCharacterEquipmentHandler(_:_:))
        
    }
    
    
    //Get Child Data
    func getChildData(){
        
        let child = LocalStorageManager.getChild()
        
        if let child = child {
            updateMoney(child.money)
            self.sex = child.sex
            getChildPrefrnces()
        }else{
            //TODO : Alert and back
        }
    }
    
    ///get Child Prefrnces
    func getChildPrefrnces(){
        //Get Child Prefrences
        FirebaseRequest.getChildEquipments { (data, err) in
            if let data = data {
                do{
                    let equipments = try FirebaseDecoder().decode([ChildEquipment].self, from: data)
                    self.childEquipments = equipments
                    print()
                }catch{
                    print("Incorrect Format")
                }
            }else{
                ///No Child Prefrences Found
                print("No child Prefrences Found")
            }
        }
    }
    
    ///Buy Item
    func buyItem(_ aEquipment:StoreEquipment){
        
        let leftMoney = self.money - aEquipment.cost
        
        if leftMoney >= 0{
            FirebaseRequest.addEquipment(aEquipment) { (success, errore) in
                if !success{
                    //Purches won't complated
                    self.showAlert(with: "خطأ حدث اثناء اتمام عملية الشراء ، الرجاء اعادة المحاولة لاحقاً")
                    return
                }
            }
            
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
    
    /// is Equipment purchesed
    func isPurched(_ item:StoreEquipment) -> Bool{
        
        if let equipments = self.childEquipments  {
            for e in equipments{
                if e.name == item.name{
                    return true
                }
            }  }
        return false
    }

    /// is Equipment use
    func isInUse(_ item:StoreEquipment)->Bool{

        if let equipments = self.childEquipments  {
            for e in equipments{
                if e.name == item.name{
                    return e.inUse
                }
            }
        }
        return false
    }
    
   
//    guard let index = equipments.firstIndex(of: item.name) else {
//        return false }
//
//    return equipments[index].inUse
    //MARK: - @IBAcation
    
    @IBAction func backButtonTapped(_ sender: Any) {
        
        self.dismiss(animated: true)
    }
    
    @IBAction func didChangeSegment(_ sender:UISegmentedControl){
        
        if sender.selectedSegmentIndex == 0{
            tableData = self.characterEquipments
            tableView.reloadData()
        } else if sender.selectedSegmentIndex == 1{
            tableData = self.bakeryEquipments
            tableView.reloadData()
        }
    }
    
    //Buy Item button Tapped
    @objc func buyItemTapped(_ sender: UIButton){
      // use the tag of button as index
        if let aEquipment = tableData?[sender.tag]{
            buyItem(aEquipment)}
    }
    
    //Use Item button Tapped
    @objc func useItemTapped(_ sender: UIButton){
      // use the tag of button as index
        let aEquipment = tableData?[sender.tag]
        print("use item tapped")
    }
    
    //MARK: - Dalegate
    
    func showAlert(with message:String){
        let alert = AlertService()
        let alertVC = alert.Alert(body: message)
        
        self.present(alertVC, animated: true)
    }
    
    ///fetch image
        func fetchImage(of name:String) -> NSData?{
            
            var imageData:NSData?
            FirebaseRequest.downloadStoreEquipmentImage(type: name) { (data, error) in
                guard let data = data else{
                    return
                }
                imageData = data
            }
            return imageData
        }
    
    
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
                
                for eq in equipmens.eqippments{
                    if sex == eq.sex || eq.sex == "unisex"{
                        self.characterEquipments?.append(eq)}
                }
                
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
        
        //Set cell background //May be moved to StoreCell
        cell.contentView.backgroundColor =  UIColor(named: "bachgroundApp")
        cell.backgroundColor = .clear
        
        // Configure cell
        if let aEquipment = aEquipment{
            
            cell.label.text = aEquipment.label
            cell.equipmentImage.image = UIImage(named: "imagePlaceholder")

            ///Register Button to handelr
            cell.button.tag = indexPath.row
            
            ///Check Diffrent cases
            if(isPurched(aEquipment)){
                if(isInUse(aEquipment)){
                    cell.button.isEnabled = false
                }else{
                    cell.button.addTarget(self, action: #selector(useItemTapped(_:)), for: .touchUpInside)
                }
            }else{
                cell.button.addTarget(self, action: #selector(buyItemTapped(_:)), for: .touchUpInside)
            }
            
          
            
            // cell.button.imageView?.image = //Depends on 3 casses
            
            ///Get Image
            if let data = fetchImage(of: aEquipment.name){
                let image = UIImage(data: data as Data)
                cell.equipmentImage?.image = image
                cell.setNeedsLayout()
            }
            
        }
        return cell
    }
    
    
    
}
