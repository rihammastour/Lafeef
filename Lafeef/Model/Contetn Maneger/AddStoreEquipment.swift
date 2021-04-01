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
        //Store Equipment
        let storeEqipment1 = StoreEquipment(sex: "unisex", name: BackeryStore.cupcakeFrame.rawValue, cost: 50, label: "لوحة كب كيك")
        let storeEqipment2 = StoreEquipment(sex: "unisex", name: BackeryStore.lavendarFrame.rawValue, cost: 30, label: "لوحة لافندر")
        let storeEqipment3 = StoreEquipment(sex: "unisex", name: BackeryStore.loliPopFrame.rawValue, cost: 30, label: "لوحة حلوى")
        let storeEqipment4 = StoreEquipment(sex: "unisex", name: BackeryStore.lamp.rawValue, cost: 40, label: "إضاءة")
        
        
        let storeEquipment5 = StoreEquipment(sex: "boy", name: CharachtersStore.blueBoy.rawValue, cost: 70, label: "ملابس زرقاء اللون ")
        let storeEquipment6 = StoreEquipment(sex: "boy", name: CharachtersStore.grayBoy.rawValue, cost: 70, label: " ملابس رمادية اللون ")
        let storeEquipment7 = StoreEquipment(sex: "boy", name: CharachtersStore.yellowBoy.rawValue, cost: 70, label: "ملابس صفراء اللون ")
        let storeEquipment8 = StoreEquipment(sex: "girl", name: CharachtersStore.pinkGirl.rawValue, cost: 70, label: "ملابس وردية اللون ")
        let storeEquipment9 = StoreEquipment(sex: "girl", name: CharachtersStore.orangeGirl.rawValue, cost: 70, label: "ملابس برتقالية اللون")
        let storeEquipment10 = StoreEquipment(sex: "girl", name: CharachtersStore.blueGirl.rawValue, cost: 70, label: "ملابس زرقاء اللون ")
        
        let storeEquipment11 = StoreEquipment(sex: "unisex", name: CharachtersStore.redGlassess.rawValue, cost: 30, label: "نظارة حمراء")
        let storeEquipment12 = StoreEquipment(sex: "unisex", name: CharachtersStore.blueglassess.rawValue, cost: 40, label: "نظارة زرقاء")
        
        let backeryarray = [storeEqipment1,storeEqipment2,storeEqipment3,storeEqipment4]
        let charachterarray = [storeEquipment5,storeEquipment6,storeEquipment7,storeEquipment8,storeEquipment9,storeEquipment10,storeEquipment11,storeEquipment12]
        let backerystore = StoreEquipmens(type: Store.backery.rawValue,eqippments: backeryarray)
        let charachterstore = StoreEquipmens(type: Store.Characherts.rawValue,eqippments: charachterarray)
        
        
        
        
        
        FirebaseRequest.addStoreEquipment(StorType: Store.backery.rawValue, StoreEquipment: backerystore) { (bool, error) in
            if error == ""{
                print(" store eqipment added")
            }else{
                print(" store eqipment error ")
            }
          
        }
        FirebaseRequest.addStoreEquipment(StorType: Store.Characherts.rawValue, StoreEquipment: charachterstore) { (bool, error) in
            if error == ""{
                print(" store eqipment added")
            }else{
                print(" store eqipment error ")
            }
          
        }
    }
    
    

}

