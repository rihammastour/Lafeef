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
    @IBOutlet weak var waveUIView: UIImageView!
    @IBOutlet weak var moneyBarUIView: UIView!
    @IBOutlet weak var moneyUILabel: UILabel!
    @IBOutlet weak var segmentedControlUI: UISegmentedControl!
    
    
    
    @IBOutlet weak var tableView: UITableView!
    
    //Variables
    var money:Float! = 0
    var sex:String! = "unisex"
    var childEquipments:[String:ChildEquipment]? = nil
    var bakeryEquipments:[StoreEquipment]? = []
    var characterEquipments:[StoreEquipment]? = []
    var showlamp = false
    var framename = ""
    var charachterImage = ""
    var isStore = false
    var isGirl = false
    
    var tableData:[StoreEquipment]?
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        
        // Additional setup after loading the view.
        setUIElements()
        getChildData()
        
      updateMoney(200)
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
        
        //Style Wave image
        Utilities.styleWaveView(waveUIView)
        
    }
    
    //MARK: - Set Content for UI Elements
    
    func updateMoney(_ money:Float){
        self.money = money
        moneyUILabel.text = String(self.money).convertedDigitsToLocale(Locale(identifier: "AR"))
    }
    
    //MARK:- Get Data Functions
    
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
                    let equipments = try FirebaseDecoder().decode([String:ChildEquipment].self, from: data)
                    self.childEquipments = equipments
                    self.tableView.reloadData()
                }catch{
                    print("Incorrect Format")
                }
            }else{
                ///No Child Prefrences Found
                print("No child Prefrences Found")
            }
        }
    }
    
    
    
    //MARK:- Set Data Functions
    
    ///Buy Item
    func buyItem(_ aEquipment:StoreEquipment) -> Bool{
        let leftMoney = self.money - aEquipment.cost
        
        if leftMoney >= 0{
            FirebaseRequest.addEquipment(aEquipment) { (success, errore) in
                if !success{
                    //Purches won't complated
                    self.showAlert(with: "خطأ حدث اثناء اتمام عملية الشراء ، الرجاء اعادة المحاولة لاحقاً", isSuccess: false)
               
                }
            }
            
            FirebaseRequest.updateMoney(leftMoney) { (success, errore) in
                if !success{
                    //Purches won't complated
                    self.showAlert(with: "خطأ حدث اثناء اتمام عملية الشراء ، الرجاء اعادة المحاولة لاحقاً", isSuccess: false)
    
                }else{
                    
                    self.updateMoney(leftMoney)
                    self.getChildPrefrnces()
                }
                
            }
            
            return true
        }else{
            //No enughe money to buy
            self.showAlert(with:"ليس لديك مال كافِ لإتمام عملية الشراء", isSuccess: false)
            return false
        }

    }
    
    func useItem(_ aEquipment:StoreEquipment){

        if let id = getId(for: aEquipment.name) {
            
            if let eq = BackeryStore.init(rawValue: aEquipment.name){
                if((eq.isFrame())){
                    // False for Frames
                    turnOff(bakery: aEquipment)
                    
                }
            }else if let eq = CharachtersStore.init(rawValue: aEquipment.name){
                if(eq.isGlassess()){
                    // False for Sunglasses
                    turnOff(sunGlasses: aEquipment)
                }
                if(eq.isClothes()){
                    // False for Clothes
                    turnOff(clothes: aEquipment)
                }
                
            }
            FirebaseRequest.updateUseEquipment(for: id, isUsing: true) { (succes, error) in
                if (succes){
                    
                    self.getChildPrefrnces()
                    self.reflectuserPrefrence(name: aEquipment.name)
                    self.performSegue(withIdentifier: "preview", sender:self)
//                    self.showAlert(with: "تم تغيير بنجاح")
                    
                }
            }
        }
    }
    
    func turnOff(bakery aEquipment:StoreEquipment){
        
        guard let values = self.childEquipments?.values else {
            return
        }
            for v in values{
                
                if let value = BackeryStore.init(rawValue: v.name){
                    if(value.isFrame() && v.inUse){
                        let id = self.getId(for: v.name)!
                        FirebaseRequest.updateUseEquipment(for: id, isUsing: false) { (succes, error) in
                            if (succes){
                            }
                    }
                }
                
            }
        }
    }
    
    
    func turnOff(sunGlasses aEquipment:StoreEquipment){

        guard let values = self.childEquipments?.values else {
            return
        }
            for v in values{
                
                if let value = CharachtersStore.init(rawValue: v.name){
                    if(value.isGlassess() && v.inUse){
                        let id = self.getId(for: v.name)!
                        FirebaseRequest.updateUseEquipment(for: id, isUsing: false) { (succes, error) in
                            if (succes){
                            }
                    }
                }
                
            }
        }
    }
    
    func turnOff(clothes aEquipment:StoreEquipment){

        guard let values = self.childEquipments?.values else {
            return
        }
            for v in values{
                
                if let value = CharachtersStore.init(rawValue: v.name){
                    if(value.isClothes() && v.inUse){
                        let id = self.getId(for: v.name)!
                        FirebaseRequest.updateUseEquipment(for: id, isUsing: false) { (succes, error) in
                            if (succes){
                            }
                    }
                }
                
            }
        }
    }
    
    //MARK: - Processing childEquipments array Functions
    
    
    func getId(for itemName:String) -> String?{
        
        guard let keys = childEquipments?.keys else {
            return nil
        }
        
        for k in keys {
            
            if let name = childEquipments?[k]?.name {
            if (name == itemName){
                return k
            }
            }
        }
        return nil
    }
    
    /// is Equipment purchesed
    func isPurched(_ item:StoreEquipment) -> Bool{
        
        if let equipments = self.childEquipments?.values  {
            for e in equipments{
                if e.name == item.name{
                    return true
                }
            }  }
        return false
    }

    /// is Equipment use
    func isInUse(_ item:StoreEquipment)->Bool{

        if let equipments = self.childEquipments?.values  {
            for e in equipments{
                if e.name == item.name{
                    return e.inUse
                }
            }
        }
        return false
    }
    
   
    //MARK: - @IBAcation
    
    @IBAction func backButtonTapped(_ sender: Any) {
        
        if let navigationController = self.navigationController {
            navigationController.popViewController(animated: true)
        }
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
            buyItem(aEquipment)
    
            let indexPath = IndexPath(item: sender.tag, section: 0)
            tableView.reloadRows(at: [indexPath], with: .automatic)
        }
    }
    
    //Use Item button Tapped
    @objc func useItemTapped(_ sender: UIButton){
      // use the tag of button as index
        if let aEquipment = tableData?[sender.tag]{
            useItem(aEquipment)
            let indexPath = IndexPath(item: sender.tag, section: 0)
            self.tableView.reloadRows(at: [indexPath], with: .automatic)
   
        }
    }
    
    //MARK: - Dalegate
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let destinationVC = segue.destination as! PreviewPrefrenceViewController
        destinationVC.showLamp = showlamp
        destinationVC.framename = framename
        destinationVC.charachterImageName = charachterImage
        destinationVC.isStore = isStore
        destinationVC.isGirl = isGirl
        
        
        
    }
    
    
    func showAlert(with message:String, isSuccess: Bool){
        let alert = AlertService()
        let alertVC = alert.Alert(body: message, isSuccess: isSuccess)
        
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
    func reflectuserPrefrence(name:String){
        switch name {
        case  BackeryStore.lamp.rawValue:
            updatePreviewVariables(isGirl: false, isStore: true, isLamp: true)
            HomeViewController.isHiddenLamp = false
            
        break
        case BackeryStore.cupcakeFrame.rawValue:
            framename = BackeryStore.cupcakeFrame.rawValue
            updatePreviewVariables(isGirl: false, isStore: true, isLamp: false)
            HomeViewController.isHiddenCupcakeFrame = false
        break
        case  BackeryStore.lavendarFrame.rawValue:
            framename = BackeryStore.lavendarFrame.rawValue
            updatePreviewVariables(isGirl: false, isStore: true, isLamp: false)
            HomeViewController.isHiddenLavendarFrame = false
        break
            
        case  BackeryStore.loliPopFrame.rawValue:
            framename = BackeryStore.loliPopFrame.rawValue
            updatePreviewVariables(isGirl: false, isStore: true, isLamp: false)
            HomeViewController.isHiddenLoliPopFrame = false
        break
        case CharachtersStore.blueBoy.rawValue:
            charachterImage = "FullBlueBoy"
            updatePreviewVariables(isGirl: false, isStore: false, isLamp: false)
            HomeViewController.userPrfrence = Constants.equipmentNames.blueBoy
        case CharachtersStore.grayBoy.rawValue:
            charachterImage = "fullGrayBoy"
            updatePreviewVariables(isGirl: false, isStore: false, isLamp: false)
            HomeViewController.userPrfrence = Constants.equipmentNames.grayBoy
        case CharachtersStore.yellowBoy.rawValue:
            charachterImage = "fullYellowBoy"
            updatePreviewVariables(isGirl: false, isStore: false, isLamp: false)
            HomeViewController.userPrfrence = Constants.equipmentNames.yellowBoy
        case CharachtersStore.redGlassess.rawValue:
            if sex == "girl"{
            charachterImage = "redGlassessGirl"
                updatePreviewVariables(isGirl: true, isStore: false, isLamp: false)
                HomeViewController.userPrfrence = Constants.equipmentNames.redGlassessGirlC
            }else{
                charachterImage = "redGlasssessBoy"
                updatePreviewVariables(isGirl: false, isStore: false, isLamp: false)
                HomeViewController.userPrfrence = Constants.equipmentNames.redGlassessBoyC
            }
            
        break
        case CharachtersStore.blueglassess.rawValue:
            if sex == "girl"{
            charachterImage = "blueGlassessGirl"
            updatePreviewVariables(isGirl: true, isStore: false, isLamp: false)
                HomeViewController.userPrfrence = Constants.equipmentNames.blueGlassessGirlC
            }else{
                charachterImage = "blueGlassessBoy"
                updatePreviewVariables(isGirl: false, isStore: false, isLamp: false)
                HomeViewController.userPrfrence = Constants.equipmentNames.BlueGlassessBoyC
            }
            
        break
        case CharachtersStore.pinkGirl.rawValue:
            charachterImage = "fullPinkGirl"
            updatePreviewVariables(isGirl: true, isStore: false, isLamp: false)
            HomeViewController.userPrfrence = Constants.equipmentNames.pinkGirl
            break
        case CharachtersStore.blueGirl.rawValue:
            charachterImage = "FullBlueGirl"
            updatePreviewVariables(isGirl: true, isStore: false, isLamp: false)
            HomeViewController.userPrfrence = Constants.equipmentNames.blueGirl
            break
        case CharachtersStore.orangeGirl.rawValue:
            charachterImage = "fullOrangeGirl"
            updatePreviewVariables(isGirl: true, isStore: false, isLamp: false)
            HomeViewController.userPrfrence = Constants.equipmentNames.orangeGirl
            break
        default:
            print("nothing ")
        }
        
        
        
    }
    func updatePreviewVariables(isGirl:Bool,isStore:Bool, isLamp:Bool){
        self.showlamp = isLamp
        self.isGirl = isGirl
        self.isStore = isStore
        
        
    }
}


// MARK: - Extension Table view data source

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
            
            cell.label.text = "\(aEquipment.label) | "
            cell.costLabel.text = " \(aEquipment.cost)".convertedDigitsToLocale(Locale(identifier: "AR")) +  "ريال"
            cell.equipmentImage.image = UIImage(named: "imagePlaceholder")

            ///Register Button to be handele
            cell.button.tag = indexPath.row
            cell.button.isEnabled = true
            
            ///Check Different cases of Item
            if(isPurched(aEquipment)){
                if(isInUse(aEquipment)){
                    cell.button.isEnabled = false
                    cell.button.setBackgroundImage(UIImage(named: "item-used-icon"), for: UIControl.State.normal)
                }else{
                    cell.button.setBackgroundImage(UIImage(named: "use-item-icon"), for: UIControl.State.normal)
                    cell.button.removeTarget(nil, action: nil, for: .allEvents)
                    cell.button.addTarget(self, action: #selector(useItemTapped(_:)), for: .touchUpInside)
                  
                    
                }
            }else{
                cell.button.addTarget(self, action: #selector(buyItemTapped(_:)), for: .touchUpInside)
                cell.button.setBackgroundImage(UIImage(named: "buy-item"), for: UIControl.State.normal)
            }
            
            
            ///Get Item Image
            let downloadQueue = DispatchQueue(label: "download", attributes: [])
            
                // call dispatch async to send a closure to the downloads queue
            downloadQueue.async { () -> Void in
            
                    // download Data
                    FirebaseRequest.downloadStoreEquipmentImage(type: aEquipment.name) { (data, error) in
                        guard let data = data else{
                            return
                        }
            
                    // Turn it into a UIImage
                    let image = UIImage(data: data as Data)
            
                    // display it
                    DispatchQueue.main.async(execute: { () -> Void in
                        cell.equipmentImage?.image = image
                        cell.setNeedsLayout()
                    })
                }
                }
            
        }
        return cell
    }

    
}
