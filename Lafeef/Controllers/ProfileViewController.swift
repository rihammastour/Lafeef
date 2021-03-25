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
            ProfilePic.image = UIImage(named: "BoyWithCircle")
        }else{
            ProfilePic.image = UIImage(named: "GirlWithCircle")
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
        let convertAge = Int(AgeEN!)
        let calculateAge = year-convertAge
        print(calculateAge)
        
        
        AgeLable.text = "العمر |\(String(calculateAge))"
    }
    
    @IBAction func logOutAction(sender: AnyObject) {
        let alert = UIAlertController(title: "تنبيه", message: "هل أنت متأكد من تسجيل الخروج؟", preferredStyle: .alert)
        let ok = UIAlertAction(title: "نعم", style: .destructive) { (alertAction) in
            
            if Auth.auth().currentUser != nil {
                do {
                    
                    try Auth.auth().signOut()
                    LocalStorageManager.removeChild()
                    let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: Constants.Storyboard.signUpOrLoginViewController)
                    self.present(vc, animated: true, completion: nil)
                    
                } catch let error as NSError {
                    print(error.localizedDescription)
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
}
