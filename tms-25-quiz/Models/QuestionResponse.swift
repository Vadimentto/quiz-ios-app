//
//  QuestionResponse.swift
//  tms-25-quiz
//
//  Created by Vadym Potapov on 18.10.2022.
//

import Foundation

// MARK: - QuestionsResponse
struct QuestionsResponse: Codable {
    let items: [Question]
}

// MARK: - Item
class Question: Codable {
    let id: Int
    let text, image: String?
    let type: String
    let category: String
    let answers: [Answer]
}

// MARK: - Answer
class Answer: Codable {
    let id: Int
    let text: String
    let isCorrect: Bool
    
    var isSelected: Bool
}
