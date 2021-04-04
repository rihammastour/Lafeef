//
//  FirebaseRequests.swift
//  Lafeef
//
//  Created by Renad nasser on 29/01/2021.
//

import Foundation
import Firebase
import CodableFirebase
import FirebaseFirestore
import FirebaseAuth
import FirebaseStorage
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
    
    static func createUser(id:String, email: String, password: String, name:String, sex:String, DOB:String, completionBlock: @escaping (_ success: Bool, _ error :Error?) -> Void) {
          

                  db.collection("users").document(id).setData([
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
                          completionBlock(false,err)
                      } else {
                          print("Document successfully written!")
                      }
                  }
                  completionBlock(true,nil)
           
      }
      static func Register(email: String, password: String, completionBlock: @escaping (_ success: Bool, _ error :Error?) -> Void) {
          
          Auth.auth().createUser(withEmail: email, password: password) {(authResult, error) in
              if let user = authResult?.user {
                  print(user)
                  completionBlock(true, nil)
           
              } else {
                  completionBlock(false,error!)
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
    
    static func passCompletedLevelData(childID:String, reports: CompletedLevel, completion: @escaping (_ success: Bool, _ error :String) -> Void){
        // Add a new document in collection "users"
        
        do {
            try db.collection("levelReport").document(childID).setData(from: reports)
        } catch let err {
            print("error while passing data", err)
        }

  
    }
    static func updateMoney(_ money:Float, completion: @escaping (_ success: Bool, _ error :Error?) -> Void){
            
            let id = getUserId()!
            
            db.collection("users").document(id).updateData([
                "money":money
            ]){ err in
                if let err = err {
                    print("Error writing document: \(err)")
                    completion(false,err)
                } else {
                    print("Document successfully written!")
                }
            }
            completion(true,nil)
        }
    static func updateChildInfo(_ Score:Float,Money:Float,_ currentLevel: Int, completion: @escaping (_ success: Bool, _ error :Error?) -> Void){
            
            let id = getUserId()!
            
            db.collection("users").document(id).updateData([
                "score":Score,
                "money":Money,
                "currentLevel":currentLevel
            ]){ err in
                if let err = err {
                    print("Error writing document: \(err)")
                    completion(false,err)
                } else {
                    print("Document successfully written!")
                }
            }
            completion(true,nil)
        }
    static func updateCurrentLevek(_ CurrentLevek:Int, completion: @escaping (_ success: Bool, _ error :Error?) -> Void){
            
            let id = getUserId()!
            
            db.collection("users").document(id).updateData([
                "currentLevek":CurrentLevek
            ]){ err in
                if let err = err {
                    print("Error writing document: \(err)")
                    completion(false,err)
                } else {
                    print("Document successfully written!")
                }
            }
            completion(true,nil)
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
    static func getChalleangeLevels( completionBlock: @escaping (_ data: Any?, _ err:Error?) -> Void)  {
      
            
        db.collection("challenge").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
                
                completionBlock(nil, err)
            } else {
                for document in querySnapshot!.documents {
                    print("\(document.documentID) => \(document.data())")
                    completionBlock(document.data(), nil)
                }
            }
        }
     

    
    }
    static func getChalleangeLevelesReports( childID:String ,completionBlock: @escaping ( _ data: Any?, _ error :String) -> Void) {
            
        db.collection("levelReport").document(childID)
            .getDocument { (response, error) in
                
                guard let document = response else {
                    completionBlock(nil,error!.localizedDescription)
                    return
                }
                guard let data = document.data() else {
                    print("Document empty")
                    return
                }
                
              
                print("data in fetch user data ",data)
                completionBlock(data,"")
                
            }
        
        }

        

    
    //MARK:- Firebase Storage
    
    func downloadImage(randPath: Int, completion: @escaping (_ data: UIImage?, _ err:Error?)->()){
        let storage = Storage.storage()
        var reference: StorageReference!
        reference = storage.reference(forURL: "gs://lafeef-7ce60.appspot.com/Lafeef-adv\(randPath).png")
        print("gs://lafeef-7ce60.appspot.com/Lafeef-adv\(randPath).png")
       reference.downloadURL { (url, error) in
        guard let data = NSData(contentsOf: url!) else{
                completion(nil,error)
                return
            }
            guard let image = UIImage(data: data as Data) else{
                completion(nil,error)
                return
            }
            //Featch image successfully
            print("image fetched ", image)
            completion(image, nil)
        }

    }
    
}
    
