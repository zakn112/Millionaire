//
//  QuestionUsageModeStrategyConsistently.swift
//  Millionaire
//
//  Created by Андрей Закусов on 23.02.2020.
//  Copyright © 2020 Андрей Закусов. All rights reserved.
//

import Foundation

class QuestionUsageModeStrategyConsistently: QuestionUsageModeStrategy {
    func getQuestions() -> [Question] {
        let allQuestions = Questions.shared.getQuestions()
        var questions = [Question]()
        
        var i = 0
        for question in allQuestions {
            if i == 15 { break }
            questions.append(question)
            i += 1
        }
        
        return questions
    }
    
}
