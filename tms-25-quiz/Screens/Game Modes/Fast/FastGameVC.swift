//
//  FastGameVC.swift
//  quiz-project
//
//  Created by Vadym Potapov on 28.10.22.
//

import UIKit
import SnapKit

enum QuestionSectionsType: Int, CaseIterable {
    case question
    case answer
}

enum QuestionsType: Int, CaseIterable {
    case text
    case image
}

class FastGameVC: UIViewController {
    
    var provider: QuestionsProvider
    
    lazy var questionNumberHeader = QuestionNumberHeader(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 100))
    
    private lazy var tableView: UITableView = {
        var tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        
        tableView.tableHeaderView = questionNumberHeader
        
        tableView.register(QuestionImageCell.self, forCellReuseIdentifier: QuestionImageCell.reuseId)
        tableView.register(QuestionTextCell.self, forCellReuseIdentifier: QuestionTextCell.reuseId)
        tableView.register(SelectAnswerCell.self, forCellReuseIdentifier: SelectAnswerCell.reuseId)
        
        return tableView
    }()
    
    //MARK: - Lifecycle
    
    init(questionProvider: QuestionsProvider) {
        self.provider = questionProvider
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupConstraints()
        
        fetchLocalQuestions()
    }
    
    //MARK: - Request
    private func fetchLocalQuestions() {
        
//        provider.fetchAllQuestions()
//        let (_, number, count) = provider.nextQuestion()
//        
//        questionNumberHeader.configure(currentQuestion: number, numberOfQuestions: count)
//        tableView.reloadData()
    }
    
    //MARK: - Private
    private func setupViews() {
        view.addSubview(tableView)
    }
    
    private func setupConstraints() {
        tableView.snp.makeConstraints { make in
            make.top.left.right.bottom.equalToSuperview()
        }
    }
}
//MARK: - UITableViewDataSource
extension FastGameVC: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return QuestionSectionsType.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let sectionType = QuestionSectionsType.init(rawValue: section) {
            
            switch sectionType {
            case .question: return QuestionsType.allCases.count
            case .answer: return provider.currentQuestion?.answers.count ?? 0
            }
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let sectionType = QuestionSectionsType.init(rawValue: indexPath.section) {
            
            switch sectionType {
            case .question:
                
                if let questionsType = QuestionsType(rawValue: indexPath.row) {
                    
                    switch questionsType {
                    case .text:
                        guard let cell = tableView.dequeueReusableCell(withIdentifier: QuestionTextCell.reuseId, for: indexPath) as? QuestionTextCell else { return UITableViewCell() }
                        cell.configure(provider.currentQuestion)
                        return cell
                        
                    case .image:
                        guard let cell = tableView.dequeueReusableCell(withIdentifier: QuestionImageCell.reuseId, for: indexPath) as? QuestionImageCell else { return UITableViewCell() }
                        cell.configure(provider.currentQuestion)
                        return cell
                    }
                }
                
            case .answer:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: SelectAnswerCell.reuseId, for: indexPath) as? SelectAnswerCell else { return UITableViewCell() }
                let answer = provider.currentQuestion?.answers[indexPath.row]
                cell.configure(answer)
                cell.delegate = self
                
                return cell
            }
        }
        return UITableViewCell()
    }
}
//MARK: - UITableViewDelegate
extension FastGameVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if let sectionType = QuestionSectionsType.init(rawValue: indexPath.section) {
            switch sectionType {
            case .question:
                
                if let questionsType = QuestionsType(rawValue: indexPath.row) {
                    switch questionsType {
                    case .text:
                        return provider.currentQuestion?.text == "" ? 0 : UITableView.automaticDimension
                    case .image:
                        return provider.currentQuestion?.image == "" ? 0 : UIScreen.main.bounds.width //захардкодили квадратную картинку
                    }
                }
            default: return UITableView.automaticDimension
            }
        }
        return UITableView.automaticDimension
    }
}
//MARK: - SelectAnswerCellDelegate
extension FastGameVC: SelectAnswerCellDelegate {
    
    func selectAnswerCellNextQuestion() {
        
        var isCorrect = true
        let answers = provider.currentQuestion?.answers ?? []
        for answer in answers {
            
            if answer.isCorrect != answer.isSelected {
                isCorrect = false
            }
        }
        if isCorrect == true {
            provider.numberOfCorrectQuestions += 1
        }
        
        let (question, number, count) = provider.nextQuestion()
        questionNumberHeader.configure(currentQuestion: number, numberOfQuestions: count)
        
        if question == nil {
            
            let alertController = UIAlertController(title: "Поздравляю!", message: "Отвечено правильно \(provider.numberOfCorrectQuestions) из \(provider.allQuestions.count) вопросов", preferredStyle: .alert)
            self.present(alertController, animated: true, completion: nil)
        }
        tableView.reloadData()
    }
}

