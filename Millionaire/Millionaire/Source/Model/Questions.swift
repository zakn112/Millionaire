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
            var questions =  array.map { Question(json: $0) }
            
            let questionsCaretaker = QuestionsCaretaker()
            let usersQuestions = questionsCaretaker.retrieve()
            questions += usersQuestions
            
            return questions
        }
        //
        return []
    }
    
}

class QuestionsBuilder {
    private var questions = [Int: (questionText: String, answer1: String, answer2: String, answer3: String, answer4: String, correctAnswer: Int)]()
    
    func build() -> [Question] {
        var newQuestions = [Question]()
        for question in questions {
            
            guard question.value.questionText != "",
                question.value.answer1 != "",
                question.value.answer2 != "",
                question.value.answer3 != "",
                question.value.answer4 != "" else { continue }
            
            
            newQuestions.append(Question(questionText: question.value.questionText,
                                         answer1: question.value.answer1,
                                         answer2: question.value.answer2,
                                         answer3: question.value.answer3,
                                         answer4: question.value.answer4,
                                         correctAnswer: question.value.correctAnswer == 0 ? 1 : question.value.correctAnswer ))
        }
        
        return newQuestions
    }
    
    func setQuestionText(number question: Int , text: String) {
        if let _ = self.questions[question] {
            self.questions[question]?.questionText = text
        } else {
            self.questions[question] = (questionText: text, answer1: "", answer2: "", answer3: "", answer4: "", correctAnswer: 0)
        }
    }
    
    
    func setAnswer1Text(number question: Int , text: String) {
        if let _ = self.questions[question] {
            self.questions[question]?.answer1 = text
        } else {
            self.questions[question] = (questionText: "", answer1: text, answer2: "", answer3: "", answer4: "", correctAnswer: 0)
        }
    }
    
    func setAnswer2Text(number question: Int , text: String) {
        if let _ = self.questions[question] {
            self.questions[question]?.answer2 = text
        } else {
            self.questions[question] = (questionText: "", answer1: "", answer2: text, answer3: "", answer4: "", correctAnswer: 0)
        }
    }
    
    func setAnswer3Text(number question: Int , text: String) {
        if let _ = self.questions[question] {
            self.questions[question]?.answer3 = text
        } else {
            self.questions[question] = (questionText: "", answer1: "", answer2: "", answer3: text, answer4: "", correctAnswer: 0)
        }
        
    }
    
    func setAnswer4Text(number question: Int , text: String) {
        if let _ = self.questions[question] {
            self.questions[question]?.answer4 = text
        } else {
            self.questions[question] = (questionText: "", answer1: "", answer2: "", answer3: "", answer4: text, correctAnswer: 0)
        }
    }
    
    func setCorrectAnswer(number question: Int , correctAnswer: Int) {
        if let _ = self.questions[question] {
            self.questions[question]?.correctAnswer = correctAnswer
        } else {
            self.questions[question] = (questionText: "", answer1: "", answer2: "", answer3: "", answer4: "", correctAnswer: correctAnswer)
        }
        
    }
    
}

class Question:  Codable {
    var questionText: String
    var answer1: String
    var answer2: String
    var answer3: String
    var answer4: String
    
    var correctAnswer: Int
    
    init() {
        self.questionText = ""
        self.answer1 = ""
        self.answer2 = ""
        self.answer3 = ""
        self.answer4 = ""
        self.correctAnswer = 0
    }
    
    init(questionText: String, answer1: String, answer2: String, answer3: String, answer4: String, correctAnswer: Int) {
        self.questionText = questionText
        self.answer1 = answer1
        self.answer2 = answer2
        self.answer3 = answer3
        self.answer4 = answer4
        self.correctAnswer = correctAnswer
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
