//
//  LocalStorageManager.swift
//  Lafeef
//
//  Created by Renad nasser on 06/02/2021.
//

import Foundation

class LocalStorageManager{

    //MARK: - Setting and Getting child
    
    static func setChild(_ user:Child){
        let defaults = UserDefaults.standard
        let encoder = JSONEncoder()
        do{
            // Encode Child
            let data = try encoder.encode(user)
            //Set child
            defaults.set(data, forKey: "child")
        }catch{
            print("UserDefaults error cannot set for child key", error.localizedDescription)
        }
    }
    
    static func getChild() -> Child?{
        
        let defaults = UserDefaults.standard
        //Get Child
        if let data = defaults.data(forKey: "child") {
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
    
    static func removeChild(){
        UserDefaults.standard.removeObject(forKey: "child")

    }
    
    
}
