//
//  ScoreArchiver.swift
//  tms-25-quiz
//
//  Created by Vadym Potapov on 30.11.2022.
//

import Foundation

struct Score: Codable {
    var category: String
    var progress: Float //0 - 1
    var correctAnswers: Float
    var allQuestion: Float
    var percent: String
    var correctQuestionIds: [Int]
    
}

protocol ScoreArchiver {
    func save(_ scores: [Score]) //сохраняем
    func retrieve() -> [Score] //закдалываем их массивом
}

final class ScoreArchiverImpl: ScoreArchiver {
    
    private let encoder = JSONEncoder() //кодирует в бинарник
    private let decoder = JSONDecoder() //разкодирует
    
    private let key = "Score"
    
    //retrieve - получить данные
    func retrieve() -> [Score] {  //метод получить
        
        //Data -> Array<Student>
        //вытаскиваем из UserDefaults бинарник
        guard let data = UserDefaults.standard.data(forKey: key) else { return [] }
        do {
            //раскодировали бинарник в массив друзей
            let array = try decoder.decode(Array<Score>.self, from: data)
            return array
        } catch {
            print(error)
        }
        return []
    }
    
    //MARK: - Public methods
    func save(_ scores: [Score]) { //метод сохранить
        
        //Array<Student> -> Data
        //массив кладем в бинарник и кодируем, бинарник кладем в UserDefaults
        do {
            let data = try encoder.encode(scores)
            UserDefaults.standard.set(data, forKey: key)
        } catch {
            print(error)
        }
    }
   
}
