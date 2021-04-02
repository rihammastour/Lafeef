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
            print("Error writing level to Firestore: \(error)")
        }
    }
    
    static func passCompletedLevelData(levelNum: String, completedLevel: CompletedLevel, completion: @escaping (_ success: Bool, _ error :String) -> Void){
        // Add a new document in collection "users"
        
        do {
            try db.collection("levelReport").document(levelNum).setData(from: completedLevel)
        } catch var err {
            print("error while passing data", err)
        }
    }
    
    
    //Set Challenge level
    static func addQuestion(section: TrainingSections, questions:Questions, completion: @escaping (_ success: Bool, _ error :String) -> Void) {
        
        // Add a new document in collection "training"
        do {
            try db.collection("training").document(section.rawValue).setData(from: questions)
        } catch let error {
            print("Error writing training question to Firestore: \(error)")
        }
    }
    
    //Update name 
    static func updateName(_ name:String, completion: @escaping (_ success: Bool, _ error :Error?) -> Void){
        
        let id = getUserId()!
        
        db.collection("users").document(id).updateData([
            "name":name
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

    //Update DOB
    static func updateDOB(_ DOB:String, completion: @escaping (_ success: Bool, _ error :Error?) -> Void){
        
        let id = getUserId()!
        
        db.collection("users").document(id).updateData([
            "DOB":DOB
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
    
    //Update sex
    static func updateSex(_ Sex:String, completion: @escaping (_ success: Bool, _ error :Error?) -> Void){
        
        let id = getUserId()!
        
        db.collection("users").document(id).updateData([
            "sex":Sex
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
            
        db.collection("levelReport").whereField("childID", isEqualTo: childID).getDocuments()
            { (querySnapshot, err) in
                      if let err = err {
                        completionBlock(nil,err.localizedDescription)
                      } else {
                      
                          for document in querySnapshot!.documents {

                       
                           
                           print("\(document.documentID) => \(document.data())")
                            
                            completionBlock(document.data(), "")
                          }
                      }
                  }
        }
    
    
    //Get Training Questions Data
    static func getTrainingQuestionsData(for section:String,  completion: @escaping (_ data: Any?, _ err:Error?)->()){
        
        db.collection("training").document(section)
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

    //MARK: -Firebase Update
    
    static func updatePassword(oldPassword: String, newPassword: String,completion: @escaping (_ success: Bool, _ error :String) -> Void){
        let user = Auth.auth().currentUser
        var credential: AuthCredential

        // Prompt the user to re-provide their sign-in credentials
        credential = EmailAuthProvider.credential(withEmail: (user?.email)!, password: oldPassword)
        
        if user != nil {
            user?.reauthenticate(with: credential) { success ,error in
              if let error = error {
                //error happend
                completion(false, "لم أنجح بتغيير كلمة مرورك، هل تستطيع المحاولة مرة أخرى؟")
              } else {
                // User re-authenticated.
                Auth.auth().currentUser?.updatePassword(to: newPassword) { (error) in
                  completion(true, "تم تغيير كلمة مرورك بنجاح!🧁")
                }
              }
            }
        } else {
          // No user is signed in.
            completion(false, "تحقق من تسجيل دخولك!")
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
    
