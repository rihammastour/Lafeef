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
import FirebaseFirestoreSwift


class FirebaseRequest{
    
    //Firestore Database
    static let db = Firestore.firestore()
    
    //Get user uniqe id
    static func getUserId() -> String? {
        
        let userID = Auth.auth().currentUser?.uid
        return userID
    }
    
    //MARK: - Set Document Firestore
    
    static func createUser(email: String, password: String, name:String, sex:String, DOB:String, completionBlock: @escaping (_ success: Bool, _ error :String) -> Void) {
        
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
    
    
    //Set Challenge level
    static func addLevel(levelNum: String,level:Level, completion: @escaping (_ success: Bool, _ error :String) -> Void) {
        
        // Add a new document in collection "users"
        do {
            try db.collection("challenge").document(levelNum).setData(from: level)
        } catch let error {
            print("Error writing city to Firestore: \(error)")
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
    static func getChildData(for userID:String,  completion: @escaping (_ data: Any?, _ err:Error?)->()){
        
        db.collection("users").document(userID)
            .getDocument { (response, error) in
                
                guard let document = response else {
                    completion(nil,error)
                    return
                }
                guard let data = document.data() else {
                    return
                }
                
                //Featch changers successfully
                print("data in fetch user data ",data)
                completion(data,nil)
                
            }
        
        
    }
    
    
    //Get Challenge Level Data
    static func getChallengeLvelData(for levelNum:String,  completion: @escaping (_ data: Any?, _ err:Error?)->()){
        
        db.collection("challenge").document(levelNum)
            .getDocument { (response, error) in
                
                guard let document = response else {
                    completion(nil,error)
                    return
                }
                guard let data = document.data() else {
                    print("Document empty")
                    return
                }
                
                //Featch changers successfully
                print("data in fetch user data ",data)
                completion(data,nil)
                
            }
    }
    static func getChalleangeLevels( completionBlock: @escaping ( _ data: Level?, _ error :String) -> Void) {
            
            db.collection("challenge").getDocuments()
            { (querySnapshot, err) in
                      if let err = err {
                          print("Error getting documents: \(err)")
                        
                        completionBlock(nil,err.localizedDescription)
                        return
                      } else {
                          for document in querySnapshot!.documents {
                   
                            let model = try! FirestoreDecoder().decode(Level.self, from: document.data())
//                            array?.append(model)
                           
//                             print("\(document.documentID) => \(document.data())")
                            
                            completionBlock(model, "")
                          }
                      }
                  }
        
        
        }

    static func getChalleangeLevelesReports( childID:String ,completionBlock: @escaping ( _ data: LevelReportData?, _ error :String) -> Void) {
            
        db.collection("levelReport").whereField(childID, isEqualTo: childID).getDocuments()
            { (querySnapshot, err) in
                      if let err = err {
                          print("Error getting documents: \(err)")
                        completionBlock(nil,err.localizedDescription)
                      } else {
                      
                          for document in querySnapshot!.documents {
                          
                            let model = try! FirestoreDecoder().decode(LevelReportData.self, from: document.data())
                       
                           
                           print("\(document.documentID) => \(document.data())")
                            
                            completionBlock(model, "")
                          }
                      }
                  }
        
        
        }

        
    }
    
    
    
    
