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
    
    @IBOutlet weak var characterUIImageView: UIImageView!
    @IBOutlet weak var levelNumLabel: UILabel!
    @IBOutlet weak var moneyLabel: UILabel!
    @IBOutlet weak var AgeLable: UILabel!
    let  sound = SoundManager()
    //    let id = Auth.auth().currentUser!.uid
//    let email = Auth.auth().currentUser!.email
    var db: Firestore!
    let year = Calendar.current.component(.year, from: Date())
    let formatter: NumberFormatter = NumberFormatter()
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

         super.viewWillAppear(animated) // call super
         print("////////////////////////////////////////")

     }



    
    // Get child object from local storage
    func getChildData(){
        let child = LocalStorageManager.getChild()
        if child != nil {
            setUIChildInfo(child!)
        }
      
    }
    
    //Set child info
    func setUIChildInfo(_ child:Child){
        self.setName(child.name)
        self.setCurrentLevel(child.currentLevel)
        self.setMoney(child.money)
        self.setImage(child.sex)
        self.setEmail(child.email)
        self.setAge(child.DOB)

    }
    
    //Name
    func setName(_ name:String) {
        nameLabel.text = String(name)
    }
    //Level
    func setCurrentLevel(_ level:Int) {
        levelNumLabel.text = String(level)
    }
    
    //Money
    func setMoney(_ money:Float) {
        moneyLabel.text = String(money)
    }
    
    //Email
    func setEmail(_ email:String) {
        emailLabel.text = "البريد الإلكتروني|\(String(email))"
    }
    
    //Image
    func setImage(_ sex:String) {
        if sex != "girl"{
            characterUIImageView.image = UIImage(named: "boy-icon")
        }else if LoginViewController.userPrfrence != ""{
            characterUIImageView.image = UIImage(named:LoginViewController.userPrfrence)
        }
        else{
            characterUIImageView.image = UIImage(named: "Girl-Profile")
        }
    }
    
    //Email
    func setAge(_ age:String) {
        // Get range based on the string index.
        let ageYearSub = age.index(age.startIndex, offsetBy: 4)..<age.endIndex
        // Access substring from range.
        print(year)
        let ageYear = age[ageYearSub]
        formatter.locale = NSLocale(localeIdentifier: "EN") as Locale?
        let AgeEN = formatter.number(from: String(ageYear))
        let convertAge = Int(AgeEN ?? 0)
        let calculateAge = year-convertAge
        print(calculateAge)
        
        
        AgeLable.text = "العمر |\(String(calculateAge))"
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
        let alert = UIAlertController(title: "تنبيه", message: "هل أنت متأكد من تسجيل الخروج؟", preferredStyle: .alert)
        let ok = UIAlertAction(title: "نعم", style: .destructive) { [self] (alertAction) in
            
                sound.playSound(sound: Constants.Sounds.bye)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {

            if Auth.auth().currentUser != nil {
                do {
                    
                    if let vc = navigationController?.viewControllers.first{
                        UserDefaults.standard.removeObserver(vc.self, forKeyPath: "child", context: nil)}
                    
                    removeDataStorage(for: "child")
                    removeDataStorage(for: "levelTwoCount")
                    removeDataStorage(for: "levelFourCount")
                    
                    try Auth.auth().signOut()
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let controller = storyboard.instantiateViewController(withIdentifier: Constants.Storyboard.signUpOrLoginViewController) as! SignUpOrLoginViewController
                    view.window?.rootViewController = controller
                    view.window?.makeKeyAndVisible()
                    
                } catch let error as NSError {
                    print(error.localizedDescription)
                }
            }
            }
        }
        let cancel = UIAlertAction(title: "إلغاء", style: .default) { (alertAction) in
            //Do nothing?
        }
        alert.addAction(ok)
        alert.addAction(cancel)
        present(alert, animated: true, completion: nil)
        
    }
    
    @IBAction func backTapped(_ sender: Any) {
        if let navigationController = self.navigationController {
            navigationController.popViewController(animated: true)
        }
    }
    
}
