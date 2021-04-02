//
//  TrainingQuestions.swift
//  Lafeef
//
//  Created by Riham Mastour on 20/08/1442 AH.
//

import Foundation

struct TrainingQuestions: Codable {
    var answer: String 
    var type: String
}

struct Questions: Codable {
    var qeustionDetailes: [TrainingQuestions]
    var questionText: String
}
