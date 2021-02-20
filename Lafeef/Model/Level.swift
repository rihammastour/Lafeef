//
//  Level.swift
//  Lafeef
//
//  Created by Renad nasser on 08/02/2021.
//


import Foundation

public struct Level: Codable {
    var duration:Float
    var maxScore: Float
    var minScore:Float
    var orders:[Order]

}
