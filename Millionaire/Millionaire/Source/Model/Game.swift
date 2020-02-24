//
//  Game.swift
//  Millionaire
//
//  Created by Андрей Закусов on 15.02.2020.
//  Copyright © 2020 Андрей Закусов. All rights reserved.
//

import Foundation

enum QuestionUsageMode{
    case сonsistently
    case randomly
}

class Game {
    static let shared = Game()
    private let resultsCaretaker = ResultsCaretaker()
    
    var questionUsageModeStrategy:QuestionUsageModeStrategy?
    var questionUsageMode:QuestionUsageMode? {
        didSet{
            switch questionUsageMode {
            case .randomly:
                self.questionUsageModeStrategy = QuestionUsageModeStrategyRandomly()
            case .сonsistently:
                self.questionUsageModeStrategy = QuestionUsageModeStrategyConsistently()
            default:
                self.questionUsageModeStrategy = QuestionUsageModeStrategyConsistently()
            }
        }
    }
    
    private init() {
        self.results = self.resultsCaretaker.retrieveRecords()
        self.questionUsageMode = .сonsistently
        self.questionUsageModeStrategy = QuestionUsageModeStrategyConsistently()
    }
    
    var results = [ResultGame]()
    
    func addResult(numberCorrectAnswers: Int){
       let resultGame = ResultGame(time: Date(), numberCorrectAnswers: numberCorrectAnswers)
       results.append(resultGame)
       resultsCaretaker.save(results: self.results)
    }
}

struct ResultGame: Codable {
    var time: Date
    var numberCorrectAnswers: Int
}
