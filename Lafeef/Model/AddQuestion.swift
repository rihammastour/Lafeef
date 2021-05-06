//
//  AddQuestion.swift
//  Lafeef
//
//  Created by Riham Mastour on 20/08/1442 AH.
//

import Foundation

class AddQuestion {
    static func shapes(){
        let section = TrainingSections.shapes
        
        let questionOne = TrainingQuestions(answer: section.getObject(for: "circle"), type: "circle")
        let questionTwo = TrainingQuestions(answer: section.getObject(for: "square"), type: "square")
        let questions = Questions(qeustionDetailes: [questionOne, questionTwo], questionText: "أحضر شكلًا يشبه:")
        
        FirebaseRequest.addQuestion(section: section, questions: questions) { (success, err) in
            if success {
                print("inserted successfully")
            } else {
                print("error:",err)

            }
        }
    }
    
    static func colors(){
        let section = TrainingSections.colors
        
        let questionOne = TrainingQuestions(answer: section.getObject(for: "brown"), type: "brown")
        let questionTwo = TrainingQuestions(answer: section.getObject(for: "white"), type: "white")
        let questions = Questions(qeustionDetailes: [questionOne, questionTwo], questionText: "أرني القطع ذات اللون:")
        
        FirebaseRequest.addQuestion(section: section, questions: questions) { (success, err) in
            if success {
                print("inserted successfully")
            } else {
                print("error:",err)

            }
        }
    }
    
    static func calculations(){
        let section = TrainingSections.calculations
        
        let questionOne = TrainingQuestions(answer: section.getObject(for: "addition"), type: "addition")
        let questionTwo = TrainingQuestions(answer: section.getObject(for: "subtraction"), type: "subtraction")
        let questionThree = TrainingQuestions(answer: section.getObject(for: "multiplication"), type: "multiplication")
        let questions = Questions(qeustionDetailes: [questionOne, questionTwo, questionThree], questionText: "كم ناتج:")
        
        FirebaseRequest.addQuestion(section: section, questions: questions) { (success, err) in
            if success {
                print("inserted successfully")
            } else {
                print("error:",err)

            }
        }
    }  
}

