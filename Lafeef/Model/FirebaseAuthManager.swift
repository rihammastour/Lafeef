//
//  FirebaseAuthManager.swift
//  Lafeef
//
//  Created by Mihaf on 13/06/1442 AH.
//

import UIKit
import Firebase
import FirebaseFirestore
import FirebaseAuth
import CodableFirebase

class FirebaseAuthManager {


    func createUser(email: String, password: String, name:String, sex:String, DOB:String, completionBlock: @escaping (_ success: Bool, _ error :String) -> Void) {
        let db = Firestore.firestore()
        Auth.auth().createUser(withEmail: email, password: password) {(authResult, error) in
                if let user = authResult?.user {
                    print(user)
                    // Add a new document in collection "users"
                    db.collection("users").document(authResult!.user.uid).setData([
                        "name": name,
                        "email": email,
                        "currentLevel": 0,
                        "money":0,
                        "score":0,
                        "sex":sex,
                        "DOB":DOB,
                        "userID":authResult!.user.uid
                    ]) { err in
                        if let err = err {
                            print("Error writing document: \(err)")
                            completionBlock(false,err.localizedDescription)
                        } else {
                            print("Document successfully written!")
                        }
                    }
                    completionBlock(true,"")
                } else {
                    completionBlock(false,error!.localizedDescription)
                }
            }
        }
  
    
    
}
