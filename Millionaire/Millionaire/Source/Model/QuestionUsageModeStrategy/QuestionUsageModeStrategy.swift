//
//  QuestionUsageModeStrategy.swift
//  Millionaire
//
//  Created by Андрей Закусов on 23.02.2020.
//  Copyright © 2020 Андрей Закусов. All rights reserved.
//

import Foundation

protocol QuestionUsageModeStrategy {
    func getQuestions() -> [Question]
}
