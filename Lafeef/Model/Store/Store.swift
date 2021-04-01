//
//  Store.swift
//  Lafeef
//
//  Created by Mihaf on 05/08/1442 AH.
//



import Foundation

enum Store : String,Codable {
    
    //cases
    case backery
    case Characherts 
    
}
struct StoreEquipmens:Codable{
    var type: String
    var eqippments:[StoreEquipment]
    
}
