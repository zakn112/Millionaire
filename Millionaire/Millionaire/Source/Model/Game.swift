//
//  Game.swift
//  Millionaire
//
//  Created by Андрей Закусов on 15.02.2020.
//  Copyright © 2020 Андрей Закусов. All rights reserved.
//

import Foundation

class Game {
    static let shared = Game()
    private let resultsCaretaker = ResultsCaretaker()
    
    private init() {
        self.results = self.resultsCaretaker.retrieveRecords()
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
