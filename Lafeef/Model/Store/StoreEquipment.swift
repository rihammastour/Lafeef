//
//  StoreEquipment.swift
//  Lafeef
//
//  Created by Mihaf on 05/08/1442 AH.
//

import Foundation
import UIKit
struct StoreEquipment: Codable,Equatable{
    var sex : String
    var name:String
    var cost: Float
    var label:String
    var inUse:Bool = false
} 
