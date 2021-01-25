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
        if Auth.auth().currentUser != nil {
            do {
                try Auth.auth().signOut()
                let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginScreen")
                present(vc, animated: true, completion: nil)
                
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }
    }
}
