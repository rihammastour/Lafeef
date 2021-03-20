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
        let storeEqipment1 = StoreEquipment(type: Store.backery.rawValue, name: BackeryStore.cupcakeFrame.rawValue, cost: 50, label: "لوحة كب كيك")
        let storeEqipment2 = StoreEquipment(type: Store.backery.rawValue, name: BackeryStore.lavendarFrame.rawValue, cost: 30, label: "لوحة لافندر")
        let storeEqipment3 = StoreEquipment(type: Store.backery.rawValue, name: BackeryStore.loliPopFrame.rawValue, cost: 30, label: "لوحة حلوى")
        let storeEqipment4 = StoreEquipment(type: Store.backery.rawValue, name: BackeryStore.lamp.rawValue, cost: 40, label: "إضاءة")
        let storeEquipment5 = StoreEquipment(type: Store.Characherts.rawValue, name: CharachtersStore.blueBoy.rawValue, cost: 70, label: "ملابس زرقاء اللون ")
        let storeEquipment6 = StoreEquipment(type: Store.Characherts.rawValue, name: CharachtersStore.grayBoy.rawValue, cost: 70, label: " ملابس رمادية اللون ")
        let storeEquipment7 = StoreEquipment(type: Store.Characherts.rawValue, name: CharachtersStore.yellowBoy.rawValue, cost: 70, label: "ملابس صفراء اللون ")
        let storeEquipment8 = StoreEquipment(type: Store.Characherts.rawValue, name: CharachtersStore.pinkGirl.rawValue, cost: 70, label: "ملابس وردية اللون ")
        let storeEquipment9 = StoreEquipment(type: Store.Characherts.rawValue, name: CharachtersStore.orangeGirl.rawValue, cost: 70, label: "ملابس برتقالية اللون")
        let storeEquipment10 = StoreEquipment(type: Store.Characherts.rawValue, name: CharachtersStore.blueGirl.rawValue, cost: 70, label: "ملابس زرقاء اللون ")
        let storeEquipment11 = StoreEquipment(type: Store.Characherts.rawValue, name: CharachtersStore.redGlassess.rawValue, cost: 30, label: "نظارة حمراء")
        let storeEquipment12 = StoreEquipment(type: Store.Characherts.rawValue, name: CharachtersStore.blueglassess.rawValue, cost: 40, label: "نظارة زرقاء")
        
        let array = [storeEqipment1,storeEqipment2,storeEqipment3,storeEqipment4,storeEquipment5,storeEquipment6,storeEquipment7,storeEquipment8,storeEquipment9,storeEquipment10,storeEquipment11,storeEquipment12]
        let store = StoreEquipmens(type: Store.backery.rawValue,eqippments: array)
        
        
        
        
        
        FirebaseRequest.addStoreEquipment(StorType: Store.backery.rawValue, StoreEquipment: store) { (bool, error) in
            if error == ""{
                print(" store eqipment added")
            }else{
                print(" store eqipment error ")
            }
          
        }
    }
    
    

}

