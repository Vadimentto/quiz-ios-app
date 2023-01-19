//
//  QuestionService.swift
//  tms-25-quiz
//
//  Created by Vadym Potapov on 21.10.2022.
//

import Foundation
import FirebaseDatabase
//import Firebase

//Input Interface - внутренний интерфейс сервиса - то как мы можем работать с сервисом
protocol QuestionsProvider {
    
    //вопрос 5 / 10
    
    var allQuestions: [Question] { get set } //все вопросы - 10
    var questions: [Question] { get set } // все вопросы по выбранной категории
    var activeQuestions: [Question] { get set } //текущие активные вопросы
    
    //Ответ выбран - если не выбран (нейтрально) если выбран (красные/зеленые)
    //var answerIsChecked: Bool { get set }
    
    var correctQuestionIds: Array<Int> { get set }
    
    var checkButtonState: CheckButtonState { get set }
    
    var currentQuestion: Question? { get set }
    
    var answerIsChecked: (Bool, Int) { get }
    var answerIsCorrect: Bool { get } //вопрос отвечен правильно
    var canTapAnswer: Bool { get }
    
    var numberOfCorrectQuestions: Int { get set }
    
  
    func nextQuestion() -> (Question?, Int, Int)
    
    func shuffleQuestions() //Рандом - перемешать вопросы
    
    func fetchAllLocalQuestions()
    func fetchAllQuestions(completion: @escaping ()->())
}

class QuestionsProviderImpl: QuestionsProvider {
    //var answerIsChecked: Bool
    
    private init() {}
    
    static let shared = QuestionsProviderImpl()

    var allQuestions: [Question] = []
    var questions: [Question] = []
    var activeQuestions: [Question] = []
    
    var correctQuestionIds: [Int] {
        get {
            let array = UserDefaults.standard.array(forKey: "correctQuestionIds") as? [Int] ?? []
            return array
        }
        set {
            
            UserDefaults.standard.set(newValue, forKey: "correctQuestionIds")
        }
    }
    
    
    var currentQuestion: Question? = nil
    var checkButtonState: CheckButtonState = .normal
    
    var numberOfCorrectQuestions = 0 //счетчик правильных ответов
    
    var jsonService = JsonServiceImpl()
//
//    init(jsonService: JsonService) {
//        self.jsonService = jsonService
//    }
    
    
    //Computed property
    var canTapAnswer: Bool {
        let (_, selectedCount) = answerIsChecked // количество выбранных
        let type = currentQuestion?.type ?? "" //тип вопроса
        print(type.contains("single"))
        if selectedCount >= 1,  type.contains("single") || type.contains("binary") {
            return false
        }
        return true
    }
    
    var answerIsCorrect: Bool {
        let answers = currentQuestion?.answers ?? []
        for answer in answers {
            if answer.isCorrect != answer.isSelected {
                return false
            }
        }
        return true
    }
    
    var answerIsChecked: (Bool, Int) {
        var selectedCount = 0
        var isSelected = false
        let answers = currentQuestion?.answers ?? []
        for answer in answers {
            if answer.isSelected == true {
                isSelected = true
                selectedCount += 1
            }
        }
        return (isSelected, selectedCount)
    }
    

 
    func fetchAllLocalQuestions() {
        
        if let questions = jsonService.loadJson(filename: "questions") {
            allQuestions = questions //список всех вопросов
            self.questions = questions //список активных вопросов
        }
    }
    
    func fetchQuestion(by category: Category, completion: @escaping ()->()) {
        
        questions = allQuestions.filter { $0.category == category.name }
        activeQuestions = questions
        
        completion()
    }
    
    func fetchAllCategories() -> [Category] {
        
        //30 -> 4 категории (Set)
        
        var categories: Set<String> = []
        for question in allQuestions {
            categories.insert(question.category)
        }
        
        let sortedCategories = categories.sorted()
        
        var result: [Category] = []
        for categoryName in sortedCategories {
            let object = Category.init(name: categoryName)
            result.append(object)
        }
        
        return result
    }
    
    func fetchAllQuestions(completion: @escaping ()->()) {
        
        let ref = Database.database().reference()
        
        ref.child("items").observe(.value) { snapshot in
            guard let children = snapshot.children.allObjects as? [DataSnapshot] else {
                return
            }
            
            let objects: [Question] = children.compactMap { snapshot in
                return try? JSONDecoder().decode(Question.self, from: snapshot.data!)
            }

            self.allQuestions = objects //список всех вопросов
            self.questions = objects //список активных вопросов
            completion()
        }
        
    }
    
    func nextQuestion() -> (Question?, Int, Int) { //question, number, count
        
        currentQuestion = activeQuestions.first
        self.activeQuestions = Array(activeQuestions.dropFirst())
        
        return (currentQuestion, questions.count - activeQuestions.count, questions.count)
    }
    
    func shuffleQuestions() {
        allQuestions.shuffle()
    }
}

extension DataSnapshot {
    var data: Data? {
        guard let value = value, !(value is NSNull) else { return nil }
        return try? JSONSerialization.data(withJSONObject: value)
    }
    var json: String? { data?.string }
}
extension Data {
    var string: String? { String(data: self, encoding: .utf8) }
}
