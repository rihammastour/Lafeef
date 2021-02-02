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
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
       logOut.layer.cornerRadius = logOut.frame.size.height/2

    }
    
   
    @IBAction func logOutAction(sender: AnyObject) {
        let alert = UIAlertController(title: "تنبيه", message: "هل أنت متأكد من تسجيل الخروج؟", preferredStyle: .alert)
        let ok = UIAlertAction(title: "نعم", style: .default) { (alertAction) in
            
            if Auth.auth().currentUser != nil {
                do {
                    
                    try Auth.auth().signOut()
                    let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginScreen")
                    self.present(vc, animated: true, completion: nil)
                    
                } catch let error as NSError {
                    print(error.localizedDescription)
                }
            }
        }
        let cancel = UIAlertAction(title: "إلغاء", style: .destructive) { (alertAction) in
            //Do nothing?
        }
        alert.addAction(ok)
        alert.addAction(cancel)
        present(alert, animated: true, completion: nil)
        
    }
}
