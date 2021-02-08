//
//  Level.swift
//  Lafeef
//
//  Created by Renad nasser on 08/02/2021.
//

import Foundation

struct Level: Codable {
    var orders:[Order]?
    var bestTime:String?
    var levelDuration:Int?
}
