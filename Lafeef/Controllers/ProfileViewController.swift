//  ProfileViewController.swift
//  Lafeef
//
//  Created by MACBOOKPRO on 1/25/21.
//


import UIKit
import Foundation
import Firebase
import FirebaseAuth
import FirebaseFirestore
class ProfileViewController: UIViewController {
    @IBOutlet weak var logOut: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var ProfileRectangle: UIButton!
    
    @IBOutlet weak var back: UIButton!
    
    @IBOutlet weak var ProfilePic: UIImageView!
    @IBOutlet weak var levelNumLabel: UILabel!
    @IBOutlet weak var moneyLabel: UILabel!
    @IBOutlet weak var AgeLable: UILabel!
    let  sound = SoundManager()
    let alert = AlertService()
    //    let id = Auth.auth().currentUser!.uid
    //    let email = Auth.auth().currentUser!.email
    var db: Firestore!
    let year = Calendar.current.component(.year, from: Date())
    let formatter: NumberFormatter = NumberFormatter()
    var sex = "girl"
    
    //MARK:- Lifecycle functions
   
    override func viewDidLoad() {
        super.viewDidLoad()
        db = Firestore.firestore()
        self.navigationController?.isNavigationBarHidden = true
        logOut.layer.cornerRadius = logOut.frame.size.height/2
        ProfileRectangle.layer.cornerRadius = ProfileRectangle.frame.size.height/8
        //        self.emailLabel.text = email
        
        
        //Get Child Data
        getChildData()
 
        
    }
    

   
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        getChildData()
        // call super
      
        
    }
    
    //MARK:- Functions
    
    //Set child info
    func setUIChildInfo(_ child:Child){
        self.setName(child.name)
        self.setCurrentLevel(child.currentLevel)
        self.setMoney(child.money)
        self.setImage(child.sex)
        self.setEmail(child.email)
        self.setAge(child.DOB)
        setUserPref(name: HomeViewController.userPrfrence, sex: child.sex)
        
    }
    func setSex(sex:String){
        self.sex = sex
    }
    
    //Name
    func setName(_ name:String) {
        nameLabel.text = String(name)
    }
    //Level
    func setCurrentLevel(_ level:Int) {
        levelNumLabel.text = String(level).convertedDigitsToLocale(Locale(identifier: "AR"))
    }
    
    //Money
    func setMoney(_ money:Float) {
        moneyLabel.text = String(money).convertedDigitsToLocale(Locale(identifier: "AR"))
    }
    
    //Email
    func setEmail(_ email:String) {
        emailLabel.text = "البريد الإلكتروني|\(String(email))"
    }
    
    //Image
    func setImage(_ sex:String) {
        if HomeViewController.userPrfrence != ""{
           setUserPref(name: HomeViewController.userPrfrence, sex: sex)
    }else if sex != "girl"{
            ProfilePic.image = UIImage(named: "BoyWithCircle")
        
        }else{
            ProfilePic.image = UIImage(named: "GirlWithCircle")
        }
//        ProfilePic.image = UIImage(named: "GirlwithCircle")
    }
    func setUserPref(name : String, sex:String){
        
           switch sex {
           case "boy":
            if (name == Constants.equipmentNames.blueBoy) {
                ProfilePic.image = UIImage(named:"blueboyb")
            }else if(name == Constants.equipmentNames.grayBoy ){
                ProfilePic.image = UIImage(named:"grayboyb")
            }else if(name == Constants.equipmentNames.yellowBoy ){
                ProfilePic.image = UIImage(named:"yellowboyb")
            }else if(name == Constants.equipmentNames.redGlassessBoyC ){
                ProfilePic.image = UIImage(named:"redglasssesboyb")
            }else if(name == Constants.equipmentNames.BlueGlassessBoyC ){
                ProfilePic.image = UIImage(named:"blueglassessBoyB")
               }else{
                   ProfilePic.image = UIImage(named: "BoyWithCircle")
               }
       
               break
    
           case "girl":
            if (name == Constants.equipmentNames.orangeGirl){
                ProfilePic.image = UIImage(named:"orangegirlB")
            }else if(name == Constants.equipmentNames.pinkGirl){
                ProfilePic.image = UIImage(named:"pinkgirlb")
                
            }else if(name == Constants.equipmentNames.blueGirl){
                ProfilePic.image = UIImage(named:"bluegirlB")
                
            } else if(name == Constants.equipmentNames.redGlassessGirlC){
                ProfilePic.image = UIImage(named:"redglassgirlB")
            }
            else if(name == Constants.equipmentNames.blueGlassessGirlC){
               ProfilePic.image = UIImage(named:"blueglassessgirlb")
               
           }
      
          else{
                   ProfilePic.image = UIImage(named: "GirlWithCircle")
               }
       
               break
           
        default:
            print("xx")
           
       }
    }
    //Email
    func setAge(_ age:String) {
        // Get range based on the string index.
        let ageYearSub = age.index(age.startIndex, offsetBy: 6)..<age.endIndex
        // Access substring from range.
        print(year)
        let ageYear = age[ageYearSub]
        formatter.locale = NSLocale(localeIdentifier: "EN") as Locale?
        let AgeEN = formatter.number(from: String(ageYear))
        let convertAge = Int(AgeEN ?? 0)
        let calculateAge = year-convertAge
        print(calculateAge)
        
        
        AgeLable.text = "العمر | "+"\(String(calculateAge))".convertedDigitsToLocale(Locale(identifier: "AR"))
    }
    
    func removeDataStorage(for key:String){
        if(key == "child"){
            LocalStorageManager.removeChild()}
        
        if(key == "levelTwoCount" ||
            key == "levelFourCount"){
            LocalStorageManager.removeAdvertisments()
        }
    }
    
    //MARK: - IBAction
    
    @IBAction func logOutAction(sender: AnyObject) {
        self.present(alert.logoutAlert(), animated: true)
        
    }
    
    @IBAction func backTapped(_ sender: Any) {
        if let navigationController = self.navigationController {
            navigationController.popViewController(animated: true)
//            UserDefaults.standard.removeObserver(self, forKeyPath: "child", context: nil)

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
    //MARK:- Delegate
    
    // Get child object from local storage
    func getChildData(){
        let child = LocalStorageManager.childValue
        if child != nil {
            setUIChildInfo(child!)
        }
        
    }
    
}
