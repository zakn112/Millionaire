//
//  ResultsCaretaker.swift
//  Millionaire
//
//  Created by Андрей Закусов on 17.02.2020.
//  Copyright © 2020 Андрей Закусов. All rights reserved.
//

import Foundation


final class ResultsCaretaker {
    
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    
    private let key = "records"
    
    func save(results: [ResultGame]) {
        do {
            let data = try self.encoder.encode(results)
            UserDefaults.standard.set(data, forKey: key)
        } catch {
            print(error)
        }
    }
    
    func retrieveRecords() -> [ResultGame] {
        guard let data = UserDefaults.standard.data(forKey: key) else {
            return []
        }
        do {
            return try self.decoder.decode([ResultGame].self, from: data)
        } catch {
            print(error)
            return []
        }
    }
}
