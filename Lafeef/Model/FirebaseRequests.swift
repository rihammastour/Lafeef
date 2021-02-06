//
//  FirebaseRequests.swift
//  Lafeef
//
//  Created by Renad nasser on 29/01/2021.
//

import Foundation
import Firebase
import CodableFirebase
import FirebaseAuth


class FirebaseRequest{
    
    static let db = Firestore.firestore()
    
    //Get user uniqe id
    static func getUserId() -> String? {
        
        let userID = Auth.auth().currentUser?.uid
        return userID
    }
    
    //MARK: - Set Document Firestore
    
    func createUser(email: String, password: String, name:String, sex:String, DOB:String, completionBlock: @escaping (_ success: Bool, _ error :String) -> Void) {
        let db = Firestore.firestore()
        Auth.auth().createUser(withEmail: email, password: password) {(authResult, error) in
                if let user = authResult?.user {
                    print(user)
                    // Add a new document in collection "users"
                    db.collection("users").document(authResult!.user.uid).setData([
                        "name": name,
                        "email": email,
                        "currentLevel": 1,
                        "money":0,
                        "score":0,
                        "sex":sex,
                        "DOB":DOB,
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
    
    //MARK: - Get Document Firestore
    
    // Listen to Real Time update
    static func setDBListener(completion:@escaping(_ data: Any?, _ err:Error?) -> Void)  {
        //Set Listner
        db.collection("users").document(getUserId()!)
            .addSnapshotListener { documentSnapshot, error in
                print("Exceution!!")
                
              guard let document = documentSnapshot else {
                //Error
                print("Error fetching document: \(error!)")
                completion(nil,error)
                return
              }
              guard let data = document.data() else {
                return
              }
                //Featch changers successfully
                print("data in seeting db listener",data)
                completion(data,nil)
            }
    }
    
    
    //Get User Data
    static func getChildData(for userID:String,  completion: @escaping (Child?, Error?)->()){
        
        let db = Firestore.firestore()
        
        db.collection("users").document(userID)
            .getDocument { (response, error) in
                
                guard let document = response else {
                    completion(nil,error)
                    return
                }
                guard let data = document.data() else {
                    completion(nil,nil)
                    return
                }
                do{
                    let child = try FirebaseDecoder().decode(Child.self, from: data)
                    completion(child,nil)
                    print("Current data: \(data)")
                    
                }catch{
                    print("error thrown",error)
                    completion(nil,error)
                    
                }
            }
        
        
    }
    
    
    
    
    
}
