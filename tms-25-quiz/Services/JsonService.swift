//
//  JsonService.swift
//  tms-25-quiz
//
//  Created by Vadym Potapov on 18.10.2022.
//

import Foundation

//Сервис - грузит JSON

protocol JsonService {
    func loadJson(filename fileName: String) -> [Question]?
}

class JsonServiceImpl: JsonService {
    
    func loadJson(filename fileName: String) -> [Question]? {
        if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonResponse = try decoder.decode(QuestionsResponse.self, from: data)
                return jsonResponse.items
            } catch {
                print("error:\(error)")
            }
        }
        return nil
    }
}
