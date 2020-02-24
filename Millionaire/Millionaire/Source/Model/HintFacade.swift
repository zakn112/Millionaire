//
//  HintFacade.swift
//  Millionaire
//
//  Created by Андрей Закусов on 24.02.2020.
//  Copyright © 2020 Андрей Закусов. All rights reserved.
//

import Foundation

class HintUsageFacade {
    
    weak var gameSessionDelegate: GameSession?
    
    var hintHelpAudience = true
    var hintCallFriend = true
    var hint5050 = true
    var hintChangeQuestion = true
    
    func setHintHelpAudience() -> (Int) {
        
        guard let gameSession = gameSessionDelegate, hintHelpAudience else {return 0}
        hintHelpAudience = false
        let currentQuestion = gameSession.questions[gameSession.currentQuestionNumber - 1]
        return currentQuestion.correctAnswer
    }
    
    func setHintCallFriend() -> (Int) {
        guard let gameSession = gameSessionDelegate, hintCallFriend else {return 0}
        hintCallFriend = false
        let currentQuestion = gameSession.questions[gameSession.currentQuestionNumber - 1]
        return currentQuestion.correctAnswer
    }
    
    func setHint5050() -> ((Int, Int)){
        guard let gameSession = gameSessionDelegate, hint5050 else {return (0, 0) }
        hint5050 = false
        let currentQuestion = gameSession.questions[gameSession.currentQuestionNumber - 1]
        
        let rand1 = Int(arc4random_uniform(UInt32(3)) + 1) - 1
        let rand2 = Int(arc4random_uniform(UInt32(2)) + 1) - 1
        var answersNumbers:[Int] = [1,2,3,4]
        answersNumbers.remove(at: currentQuestion.correctAnswer - 1)
        return (answersNumbers[rand1], answersNumbers[rand2])
    }
    
    func setHintChangeQuestion() -> (Question) {
        guard let gameSession = gameSessionDelegate, hintChangeQuestion else {return Question()}
        hintChangeQuestion = false
        let question = gameSession.nextQuestion()
        return question
    }
    
}
