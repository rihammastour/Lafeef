//
//  ProfileViewController.swift
//  Lafeef
//
//  Created by MACBOOKPRO on 1/25/21.
//


import UIKit
import Foundation
import Firebase
import FirebaseAuth
class ProfileViewController: UIViewController {
   @IBOutlet weak var logOut: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var ProfileRectangle: UIButton!

    
    @IBOutlet weak var characterUIImageView: UIImageView!
    @IBOutlet weak var levelNumLabel: UILabel!
    @IBOutlet weak var moneyLabel: UILabel!
//    let id = Auth.auth().currentUser!.uid
//    let email = Auth.auth().currentUser!.email
    var db: Firestore!
    
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

//         getName { (name) in
//             if let name = name {
//                 self.nameLabel.text = name
//                 print("great success")
//             }
//         }
     }

//    func getName(completion: @escaping (_ name: String?) -> Void) {
//        guard let uid = Auth.auth().currentUser?.uid else { // safely unwrap the uid; avoid force unwrapping with !
//            completion(nil) // user is not logged in; return nil
//            return
//        }
//        Firestore.firestore().collection("users").document(id).getDocument { (docSnapshot, error) in
//            if let doc = docSnapshot {
//                if let name = doc.get("name") as? String {
//                    completion(name) // success; return name
//                } else {
//                    print("error getting field")
//                    completion(nil) // error getting field; return nil
//                }
//            } else {
//                if let error = error {
//                    print(error)
//                }
//                completion(nil) // error getting document; return nil
//            }
//        }
//    }

    
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
       // self.setAge(child.DOB)

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
        emailLabel.text = String(email)
    }
    
    //Image
    func setImage(_ sex:String) {
        if sex != "girl"{
            characterUIImageView.image = UIImage(named: "boy-icon")
        }else{
            characterUIImageView.image = UIImage(named: "Girl-Profile")
        }
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
