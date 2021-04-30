//
//  HomeViewController.swift
//  Lafeef
//
//  Created by Renad nasser on 27/01/2021.
//

import UIKit
import CodableFirebase

class HomeViewController: UIViewController {
    
    //MARK:- Proprites
    
    //BarUIView
    @IBOutlet weak var moneyBarUIView: UIView!
    @IBOutlet weak var scoreBarUIView: UIView!
    @IBOutlet weak var profileBarUIView: UIView!
    
    @IBOutlet weak var instructionBarUIView: UIView!
    @IBOutlet weak var characterUIImageView: UIImageView!
    //Labels
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var moneyLabel: UILabel!
    @IBOutlet weak var levelNumLabel: UILabel!
    
    //Buttons
    @IBOutlet weak var storeButton: UIButton!
    @IBOutlet weak var instructionButton: UIButton!
    
    
    let formatter = NumberFormatter()
    let  sound = SoundManager()
    let alertservice = AlertService()
    var childEquipments:[String:ChildEquipment] = [:]
    static var userPrfrence = ""
    var sex : String = ""
    static var isHiddenLamp: Bool = true
    static var isHiddenLavendarFrame: Bool = true
    static var isHiddenCupcakeFrame: Bool = true
    static var isHiddenLoliPopFrame: Bool = true
    
    //MARK: - Lifecycle Functions
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setUserPref()
//        //Register child obj to observe changes
//        RegisterObserver(for:"child")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        formatter.locale = Locale(identifier: "ar")
        sound.playSound(sound: Constants.Sounds.hello)
        getChildPrefrnces()
    //Additional setup after loading the view.

    //Style elemnts
        setUpElements()
        //Get Child Data
        getChildData()
        RegisterObserver(for:"child")
        
    }
    
    
    //MARK: Functions
    
    //MARK: - Setup UI Elements
    func setUpElements() {
        
        //Set Bekary background
        instructionBarUIView.layer.cornerRadius = instructionBarUIView.frame.size.height/2
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "blank-bakery")
        backgroundImage.contentMode = UIView.ContentMode.scaleToFill
        self.view.insertSubview(backgroundImage, at: 0)
        
        view.backgroundColor = UIColor(white: 1, alpha: 0.5)
        
        //Bars style
        Utilities.styleBarView(moneyBarUIView)
        Utilities.styleBarView(scoreBarUIView)
        Utilities.styleBarView(profileBarUIView)
        Utilities.styleBarView(instructionBarUIView)
      
        //Store Button style
        Utilities.styleCircleButton(storeButton)
        //create image
        let image = UIImage(named: "storeIcon") as UIImage?
        storeButton.setImage(image, for: .normal)
        //style image
        storeButton.contentVerticalAlignment = .fill
        storeButton.contentHorizontalAlignment = .fill
        storeButton.imageEdgeInsets = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        
      
        instructionButton.layer.cornerRadius =  instructionButton.frame.size.height/2
       
    }
    
    //Activity Indcator anmation
    //     func startSpinning() {
    //        activityIndicator.startAnimating()
    //    }
    //
    //    func stopSpinning() {
    //        activityIndicator.stopAnimating()
    //    }
    //MARK:- Set content for UI elemnnts
    //Set child info
    func setUIChildInfo(_ child:Child){
        self.setName(child.name)
        self.setCurrentLevel(child.currentLevel)
        self.setMoney(child.money)
        self.setScore(child.score)
        self.setImage(child.sex)
        self.sex = child.sex
    }
    func setUserPref(){
        
        if HomeViewController.userPrfrence != ""{
       characterUIImageView.image = UIImage(named: HomeViewController.userPrfrence)
    }
    }
    //Name
    func setName(_ name:String) {
        nameLabel.text = String(name)
    }
    //Level
    func setCurrentLevel(_ level:Int) {
        
        levelNumLabel.text = formatter.string(from: NSNumber(value: level))!
    }
    
    //Score
    func setScore(_ score:Float) {
        scoreLabel.text = formatter.string(from: NSNumber(value: score))!
    }
    func setChildPrefrence(name:String){
        characterUIImageView.image = UIImage(named: name)
        
    }
    
    //Money
    func setMoney(_ money:Float) {
        moneyLabel.text = formatter.string(from: NSNumber(value: money))!
    }
    
    //Image
    func setImage(_ sex:String) {
        if   HomeViewController.userPrfrence == "" && sex != "girl"{
            characterUIImageView.image = UIImage(named: "boy-icon")
        // }else if LoginViewController.userPrfrence != ""{
        //     characterUIImageView.image = UIImage(named: LoginViewController.userPrfrence)}
        }else if HomeViewController.userPrfrence == ""{
            characterUIImageView.image = UIImage(named: "girl-icon")
        }
    }
    //MARK:- Get User Data
    
    //Fetch Child info from db 
    func feachUserData(){
        
        let userId = FirebaseRequest.getUserId()
        FirebaseRequest.getChildData(for: userId!) { (data, err) in
            if err != nil{
                print("Home View Controller",err!)
                if err?.localizedDescription == "Failed to get document because the client is offline."{
                    print("تأكد من اتصال الانترنيت")
                    self.present(self.alertservice.Alert(body: "تأكد من اتصالك بالإنترنت", isSuccess: false),animated:true)
                    //TODO: Alert and update button and logout
                }
                
            }else{
                let child = data!
                self.setUIChildInfo(child as! Child)
            }
        }
        
    }
    
    // Get child object from local storage
    func getChildData(){
        let child = LocalStorageManager.getChild()
        
        if let child = child {
            setUIChildInfo(child)
        }
        
    }
    //MARK: - Local Storage Notifications
    
    //Register key value to be observed
    func RegisterObserver(for key:String){
        UserDefaults.standard.addObserver(self, forKeyPath: key, options: .new, context: nil)
    }
    
    //Observe Handlere
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        if keyPath == "child" {
            getChildData()
        }
    }
    
    //MARK: - Actions, Elements Tapped
    @IBAction func profileBarViewTapped(_ sender: Any) {
        
        profileBarUIView.showAnimation({
            
            let vc = self.storyboard?.instantiateViewController(withIdentifier: Constants.Storyboard.profileViewController ) as! ProfileViewController
            
            self.navigationController?.pushViewController(vc, animated: true)
            
        })
        
    }
    
    @IBAction func challeange(_ sender: Any) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.performSegue(withIdentifier: Constants.Segue.goToChalleange, sender: self)
        }
        sound.playSound(sound: Constants.Sounds.challeange)
    }
    
    @IBAction func train(_ sender: Any) {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.performSegue(withIdentifier: Constants.Segue.goToTraining, sender: self)
            //
        }
        
        
        sound.playSound(sound: Constants.Sounds.train)
    }
    
    @IBAction func store(_ sender: Any) {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.56) {
            if let viewController = self.storyboard?.instantiateViewController(withIdentifier: Constants.Storyboard.storeViewController) as? StoreViewController {
                if let navigator = self.navigationController {
                    navigator.pushViewController(viewController, animated: true)
                }
            }
        }
        
        sound.playSound(sound: Constants.Sounds.store)
 
      }

    func getChildPrefrnces(){
        //Get Child Prefrences
        FirebaseRequest.getChildEquipments { (data, err) in
            if let data = data {
                do{
                    let equipments = try FirebaseDecoder().decode([String:ChildEquipment].self, from: data)
                    self.childEquipments = equipments
                    self.reflectChildPrefrences()
               
                }catch{
                    print("Incorrect Format")
                }
            }else{
                ///No Child Prefrences Found
                print("No child Prefrences Found")
            }
        }
    }
    
    
    func reflectChildPrefrences(){
        print(childEquipments.values.count,"count")
        if childEquipments.count != 0 {
         
            for item in childEquipments.values{
            print("item",item)
            if item.inUse{
                switch item.name {
                case BackeryStore.cupcakeFrame.rawValue:
//                    GameScene.presentChildPrefrence(name: item.name)
                    HomeViewController.isHiddenCupcakeFrame = false
                    break
                case BackeryStore.lavendarFrame.rawValue:
                    HomeViewController.isHiddenLavendarFrame = false
                    break
                case BackeryStore.lamp.rawValue:
                    HomeViewController.isHiddenLamp = false
                    break
                case BackeryStore.loliPopFrame.rawValue:
                    HomeViewController.isHiddenLoliPopFrame = false
                    break
                case CharachtersStore.blueBoy.rawValue:
                    setChildPrefrence(name: Constants.equipmentNames.blueBoy)
                    HomeViewController.userPrfrence = Constants.equipmentNames.blueBoy
                    break
                case CharachtersStore.blueGirl.rawValue:
                    setChildPrefrence(name: Constants.equipmentNames.blueGirl)
                    HomeViewController.userPrfrence = Constants.equipmentNames.blueGirl
                    break
                case CharachtersStore.orangeGirl.rawValue:
                    setChildPrefrence(name: Constants.equipmentNames.orangeGirl)
                    HomeViewController.userPrfrence = Constants.equipmentNames.orangeGirl
                    break
                case CharachtersStore.pinkGirl.rawValue:
                    setChildPrefrence(name: Constants.equipmentNames.pinkGirl)
                    HomeViewController.userPrfrence = Constants.equipmentNames.pinkGirl
                    break
                case CharachtersStore.yellowBoy.rawValue:
                    setChildPrefrence(name: Constants.equipmentNames.yellowBoy)
                    HomeViewController.userPrfrence = Constants.equipmentNames.yellowBoy
                    break
                case CharachtersStore.grayBoy.rawValue:
                    setChildPrefrence(name: Constants.equipmentNames.grayBoy)
                    HomeViewController.userPrfrence =  Constants.equipmentNames.grayBoy
                    break
                case CharachtersStore.blueglassess.rawValue:
                    if sex == "girl"{
                    
                    setChildPrefrence(name: Constants.equipmentNames.blueGlassessGirlC)
                        HomeViewController.userPrfrence =  Constants.equipmentNames.blueGlassessGirlC
                        
                    }else{
                        setChildPrefrence(name: Constants.equipmentNames.BlueGlassessBoyC)
                            HomeViewController.userPrfrence =  Constants.equipmentNames.BlueGlassessBoyC
                    }
                    
                    break
                    
                case CharachtersStore.redGlassess.rawValue:
                    if sex == "girl"{
                    
                    setChildPrefrence(name: Constants.equipmentNames.redGlassessGirlC)
                        HomeViewController.userPrfrence =  Constants.equipmentNames.redGlassessGirlC
                        
                    }else{
                        setChildPrefrence(name: Constants.equipmentNames.redGlassessBoyC)
                            HomeViewController.userPrfrence =  Constants.equipmentNames.redGlassessBoyC
                    }
                    
            
                    break
                
                default:
                    print("no prefrence")
                }
            }
            }
            
        }
    }
}



//MARK: - Extention
public extension UIView {
    func showAnimation(_ completionBlock: @escaping () -> Void) {
        isUserInteractionEnabled = false
        UIView.animate(withDuration: 0.1,
                       delay: 0,
                       options: .curveLinear,
                       animations: { [weak self] in
                        self?.transform = CGAffineTransform.init(scaleX: 0.95, y: 0.95)
                       }) {  (done) in
            UIView.animate(withDuration: 0.1,
                           delay: 0,
                           options: .curveLinear,
                           animations: { [weak self] in
                            self?.transform = CGAffineTransform.init(scaleX: 1, y: 1)
                           }) { [weak self] (_) in
                self?.isUserInteractionEnabled = true
                completionBlock()
            }
                       }
    }
   
}

