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
    
    var level = 0
    var currentQuestionNumber = 0
    
    weak var gameViewDelegate: GameSceneDelegate?{
        didSet{
            let question = nextQuestion()
            gameViewDelegate?.reloadQuestion(question: question)
        }
    }
    
    var hintHelpAudience = true
    var hintCallFriend = true
    var hint5050 = true
    var hintChangeQuestion = true
    
    
    init() {
        questions = Questions.shared.getQuestions()
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
            level += 1
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
        hintHelpAudience = false
        let currentQuestion = questions[currentQuestionNumber - 1]
        gameViewDelegate?.setHintHelpAudience(answer: currentQuestion.correctAnswer)
    }
    
    func setHintCallFriend() {
        hintCallFriend = false
        let currentQuestion = questions[currentQuestionNumber - 1]
        gameViewDelegate?.setHintCallFriend(answer: currentQuestion.correctAnswer)
    }
    
    func setHint5050() {
        hint5050 = false
        let currentQuestion = questions[currentQuestionNumber - 1]
        
        let rand1 = Int(arc4random_uniform(UInt32(3)) + 1) - 1
        let rand2 = Int(arc4random_uniform(UInt32(2)) + 1) - 1
        var answersNumbers:[Int] = [1,2,3,4]
        answersNumbers.remove(at: currentQuestion.correctAnswer - 1)
        gameViewDelegate?.setHint5050(answer1: answersNumbers[rand1], answer2: answersNumbers[rand2])
    }
    
    func setHintChangeQuestion() {
        let question = nextQuestion()
        gameViewDelegate?.setHintChangeQuestion(question: question)
    }
    
}
