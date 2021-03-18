//
//  AddStoreEquipment.swift
//  Lafeef
//
//  Created by Mihaf on 05/08/1442 AH.
//

import Foundation
import UIKit
class AddStoreEquipment {
    static func addEquipment(){
        var storeEqipment = StoreEquipment(type: Store.backery.rawValue, name: BackeryStore.cupcakeFrame.rawValue, cost: 50)
        FirebaseRequest.addStoreEquipment(StorType: Store.backery.rawValue, StoreEquipment: storeEqipment) { (bool, error) in
            if error == ""{
                print(" store eqipment added")
            }else{
                print(" store eqipment error ")
            }
          
        }
    }
    
    

}

