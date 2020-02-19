//
//  Questions.swift
//  Millionaire
//
//  Created by Андрей Закусов on 15.02.2020.
//  Copyright © 2020 Андрей Закусов. All rights reserved.
//

import Foundation

class Questions {
    
    static let shared = Questions()
    
    private init() {
        
    }
    
    func getQuestions() -> ([Question]) {
        if let path = Bundle.main.path(forResource: "QusetionsText", ofType: "json") {
            
            let dataJson = try! Data(contentsOf: URL(fileURLWithPath: path))
           
            let json = try? JSONSerialization.jsonObject(with: dataJson, options: JSONSerialization.ReadingOptions.allowFragments)
            let array = json as! [[String: Any]]
            let questions =  array.map { Question(json: $0) }
            return questions
        }
       //
      return []
    }
    
}

class Question {
    let questionText: String
    let answer1: String
    let answer2: String
    let answer3: String
    let answer4: String
    
    let correctAnswer: Int
    
    init() {
        self.questionText = ""
        self.answer1 = ""
        self.answer2 = ""
        self.answer3 = ""
        self.answer4 = ""
        self.correctAnswer = 0
    }
    
    init(json: [String: Any]) {
        self.questionText = json["questionText"] as! String
        self.answer1 = json["answer1"] as! String
        self.answer2 = json["answer2"] as! String
        self.answer3 = json["answer3"] as! String
        self.answer4 = json["answer4"] as! String
        self.correctAnswer = json["correctAnswer"] as! Int
    }
    
    
}
