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
import FirebaseFirestore
class ProfileViewController: UIViewController {
   @IBOutlet weak var logOut: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
//    let id = Auth.auth().currentUser!.uid>>>الطريقه الصحيحه
    let id = Auth.auth().currentUser!.uid
//    let id="fIK2ENltLvgqTR5NODCx4MJz5143"
    let email = Auth.auth().currentUser!.email
//    let email = "rihamtest@gmail.com"
    var db: Firestore!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        db = Firestore.firestore()
        self.navigationController?.isNavigationBarHidden = true
       logOut.layer.cornerRadius = logOut.frame.size.height/2
        
        
        self.emailLabel.text = email
//        let ref = db.collection("users").document(id)
//        ref.getDocument { (snapshot, err) in
//            if let data = snapshot?.data() {
//                print(data["name"])
//            } else {
//                print("Couldn't find the document")
//            }
//        }
        
//        getDocument()
        
//        let docRef = db.collection("users").document(id)
//
//        docRef.getDocument { (document, error) in
//            if let document = document, document.exists {
//                let dataDescription = document.data()
//                print("Document data: \(dataDescription)")
//            } else {
//                print("Document does not exist")
//            }
//        }

    }
    
//    private func getDocument() {
//        print("*******")
//        print(id)
//        // [START get_document]
//        let docRef = db.collection("users").document(id)
//
//        docRef.getDocument { (document, error) in
//            if let document = document, document.exists {
//                let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
//                print("Document data: \(dataDescription)")
//            } else {
//                print("Document does not exist")
//            }
//        }
//        // [END get_document]
//    }
    
    override func viewWillAppear(_ animated: Bool) {

         super.viewWillAppear(animated) // call super
         print("////////////////////////////////////////")

//                let ref = db.collection("users").document(id)
//                ref.getDocument { (snapshot, err) in
//                    if let data = snapshot?.data() {
//                        print(data["name"])
//                    } else {
//                        print("Couldn't find the document")
//                    }
//                }



         getName { (name) in
             if let name = name {
                 self.nameLabel.text = name
                 print("great success")
             }
         }
     }

    func getName(completion: @escaping (_ name: String?) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { // safely unwrap the uid; avoid force unwrapping with !
            completion(nil) // user is not logged in; return nil
            return
        }
        Firestore.firestore().collection("users").document(id).getDocument { (docSnapshot, error) in
            if let doc = docSnapshot {
                if let name = doc.get("name") as? String {
                    completion(name) // success; return name
                } else {
                    print("error getting field")
                    completion(nil) // error getting field; return nil
                }
            } else {
                if let error = error {
                    print(error)
                }
                completion(nil) // error getting document; return nil
            }
        }
    }


    
    
//    @IBAction func displayName(sender: AnyObject){
//
//        nameLabel.text="raghad"
//
//    }
    
    
   
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
