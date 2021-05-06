//
//  LocalStorageManager.swift
//  Lafeef
//
//  Created by Renad nasser on 06/02/2021.
//
import Foundation

class LocalStorageManager{
    
    //MARK: - Setting and Getting child
    
    private static var childKey: String = "child"
    
    public static var childValue: Child? {
        set {
            
            let encoder = JSONEncoder()
            do{
                // Encode Child
                let data = try encoder.encode(newValue)
                //Set child
                UserDefaults.standard.set(data, forKey: childKey)
            }catch{
                print("UserDefaults error cannot set for child key", error.localizedDescription)
            }
            
        }
        
        get{
           if let data = UserDefaults.standard.data(forKey: "child") {
                do{
                    //Decode Child
                    let decoder = JSONDecoder()
                    let child = try decoder.decode(Child.self, from: data)
                    return child
                }catch{
                    print("err get user")
                }
        }
            return nil
    }
        
    }
    
//    static func setChild(_ child:Child){
//        let defaults = UserDefaults.standard
//        let encoder = JSONEncoder()
//        do{
//            // Encode Child
//            let data = try encoder.encode(child)
//
//            print("local storage manager",child)
//            //Set child
//            defaults.set(data, forKey: "child")
//        }catch{
//            print("UserDefaults error cannot set for child key", error.localizedDescription)
//        }
//    }
//
//    static func getChild() -> Child?{
//
//        let defaults = UserDefaults.standard
//        //Get Child
//        if let data = defaults.data(forKey: "child") {
//            do{
//                //Decode Child
//                let decoder = JSONDecoder()
//                let child = try decoder.decode(Child.self, from: data)
//                return child
//            }catch{
//                print("err get user")
//            }
//
//        }
//
//        return nil
//    }
    
    static func removeChild(){
        if checkExistChild() {
            UserDefaults.standard.removeObject(forKey: "child")
        }
        
    }
    
    static func checkExistChild() -> Bool{
        if (UserDefaults.standard.object(forKey: "child") != nil) {
            return true
        }
        return false
        
    }

    static func removeAdvertisments(){
        if checkExistAdv(for: "levelTwoCount") {
            UserDefaults.standard.removeObject(forKey: "levelTwoCount")
        }
        if checkExistAdv(for: "levelFourCount") {
            UserDefaults.standard.removeObject(forKey: "levelFourCount")
        }
        
    }
    
    static func checkExistAdv(for name:String) -> Bool{
        if (UserDefaults.standard.object(forKey: name) != nil) {
            return true
        }
        return false
        
    }
    
    
}
