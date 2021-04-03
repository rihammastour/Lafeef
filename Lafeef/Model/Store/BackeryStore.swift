//
//  BackeryStore.swift
//  Lafeef
//
//  Created by Mihaf on 05/08/1442 AH.
//

import Foundation
enum BackeryStore: String, Codable {
    case cupcakeFrame
    case loliPopFrame
    case lavendarFrame
    case lamp
    
    
    func equalsType(of equipment:BackeryStore)-> Bool{ //Should be called only on Frame type
        if isFrame(){
            switch equipment {
            case .cupcakeFrame,.loliPopFrame,.lavendarFrame:
                return true
            default:
                return false
            }
        }else{
            return false
        }
    }
    
    func isFrame()->Bool{
        if self == .cupcakeFrame ||
            self == .loliPopFrame ||
            self == .lavendarFrame {
            return true
        }
        return false
    }
    
    
}
