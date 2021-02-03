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
    
    static func getUserId() -> String? {
        
//      let userID  Auth.auth().currentUser?.uid
//        return userID
        return "4xZTPYcDPKF3bISQl34g"
    }
    
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
