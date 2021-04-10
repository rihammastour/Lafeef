//
//  CharachtersStore.swift
//  Lafeef
//
//  Created by Mihaf on 05/08/1442 AH.
//

import Foundation

enum CharachtersStore:String, Codable{
    
case blueBoy
case grayBoy
case yellowBoy
case pinkGirl
case blueGirl
case orangeGirl
case blueglassess
case redGlassess
    
    func isGlassess()->Bool{
        switch self {
        case .blueBoy, .grayBoy,.yellowBoy,.pinkGirl,.blueGirl,.orangeGirl:
            return false
        case .blueglassess,.redGlassess:
            return true
        }
    }
    
    func isClothes()->Bool{
        switch self {
        case .blueBoy, .grayBoy,.yellowBoy,.pinkGirl,.blueGirl,.orangeGirl:
            return true
        case .blueglassess,.redGlassess:
            return false
        }
    }

}
