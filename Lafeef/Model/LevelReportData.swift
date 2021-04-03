//
//  LevelReportData.swift
//  Lafeef
//
//  Created by Riham Mastour on 04/07/1442 AH.
//
import Foundation

struct LevelReportData: Codable {
    var levelNum: String
    var collectedMoney: Float
    var collectedScore: Float
    var isPassed: Bool
}
