//
//  GameSession.swift
//  Millionaire
//
//  Created by Андрей Закусов on 15.02.2020.
//  Copyright © 2020 Андрей Закусов. All rights reserved.
//

import Foundation

protocol GameSceneDelegate: class {
    func didEndGame(withResult result: Int, currentAnswer: Int, correctAnswer: Int)
    func reloadQuestion(question: Question)
    func setHintHelpAudience(answer: Int)
    func setHintCallFriend(answer: Int)
    func setHint5050(answer1: Int, answer2: Int)
    func setHintChangeQuestion(question: Question)
}

class GameSession {
    
    var questions = [Question]()
    
    let level:Observable<Int>
    var currentQuestionNumber = 0
    
    let hintUsageFacade:HintUsageFacade
    
    weak var gameViewDelegate: GameSceneDelegate?{
        didSet{
            let question = nextQuestion()
            gameViewDelegate?.reloadQuestion(question: question)
        }
    }
    
    
    init() {
        if let questionUsageModeStrategy = Game.shared.questionUsageModeStrategy {
            self.questions = questionUsageModeStrategy.getQuestions()
        }
        
        self.level = Observable(0)
        
        self.hintUsageFacade = HintUsageFacade()
        self.hintUsageFacade.gameSessionDelegate = self
        
    }
    
    func nextQuestion() ->(Question) {
        if self.questions.count > currentQuestionNumber {
            currentQuestionNumber += 1
            return questions[currentQuestionNumber - 1]
        }else{
            return Question()
        }
    }
    
    func setResponse(numberRespons: Int) {
        let currentQuestion = questions[currentQuestionNumber - 1]
        
        if currentQuestion.correctAnswer == numberRespons {
            let question = nextQuestion()
            level.value += 1
            if question.correctAnswer == 0 {
                didEndGame(currentAnswer: numberRespons, correctAnswer: currentQuestion.correctAnswer)
            } else{
                gameViewDelegate?.reloadQuestion(question: question)
            }
            
        }else{
            didEndGame(currentAnswer: numberRespons, correctAnswer: currentQuestion.correctAnswer)
        }
    }
    
    func didEndGame(currentAnswer: Int, correctAnswer: Int){
       Game.shared.addResult(numberCorrectAnswers: currentQuestionNumber - 1)
       gameViewDelegate?.didEndGame(withResult: currentQuestionNumber - 1, currentAnswer: currentAnswer, correctAnswer: correctAnswer)
    }
    
    func setHintHelpAudience() {
        let currentQuestion = hintUsageFacade.setHintHelpAudience()
        gameViewDelegate?.setHintHelpAudience(answer: currentQuestion)
    }
    
    func setHintCallFriend() {
        let currentQuestion = hintUsageFacade.setHintCallFriend()
        gameViewDelegate?.setHintCallFriend(answer: currentQuestion)
    }
    
    func setHint5050() {
        let currentQuestion = hintUsageFacade.setHint5050()
        gameViewDelegate?.setHint5050(answer1: currentQuestion.0, answer2: currentQuestion.1)
    }
    
    func setHintChangeQuestion() {
        let question =  hintUsageFacade.setHintChangeQuestion()
        gameViewDelegate?.setHintChangeQuestion(question: question)
    }
    
}
