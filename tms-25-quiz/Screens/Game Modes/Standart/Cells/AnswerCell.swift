//
//  AnswerCell.swift
//  tms-25-quiz
//
//  Created by Vadym Potapov on 18.10.2022.
//

import UIKit


protocol AnswerCellDelegate: AnyObject {
    func answerCellSelectAnswer()
}

class AnswerCell: UITableViewCell {
    
    static var reuseId = "AnswerCell"
    
    var currentAnswer: Answer? = nil
    var canTapAnswer: Bool = true
    
    var delegate: AnswerCellDelegate?
    
    private lazy var answerLabel: UILabel = {
        
        var label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textColor = .white
        
        return label
    }()
    
    private lazy var backgroundCellView: UIView = {
        var view = UIView()
        view.backgroundColor = UIColor(named: "background-color")
        view.layer.borderWidth = 1.5
        view.layer.cornerRadius = 10
        view.layer.borderColor = CGColor(red: 0.627, green: 0.663, blue: 0.988, alpha: 0.7)
        
        
        return view
    }()
    
    private lazy var answerButton: UIButton = {
        
        var button = UIButton()
        //button.setTitle("Проверить", for: .normal)
        button.backgroundColor = .clear
        //button.layer.cornerRadius = 10
   
        button.addTarget(self, action: #selector(answerButtonAction), for: .touchUpInside)
        
        return button
    }()


    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        backgroundCellView.backgroundColor = .lightGray.withAlphaComponent(0.5)
    }
    
    //MARK: - Private
    
    private func setupViews() {
        contentView.addSubview(backgroundCellView)
        contentView.addSubview(answerLabel)
        contentView.addSubview(answerButton)
        contentView.backgroundColor = UIColor(named: "background-color")
    }
    
    private func setupConstraints() {
        
        backgroundCellView.snp.makeConstraints { make in
            make.left.right.equalTo(contentView).inset(30)
            make.top.bottom.equalTo(contentView).inset(8)
        }
        
        answerLabel.snp.makeConstraints { make in
            make.left.right.equalTo(contentView).inset(40)
            make.top.bottom.equalTo(contentView).inset(20)
        }
        
        answerButton.snp.makeConstraints { make in
            make.top.left.right.bottom.equalToSuperview()
        }
    }
    
    //MARK: - Public
    
    //5 вопросов - 5 ячеек - 1 ячейка
    
    //single -> answercell (1 нажатие) -> блокируем
    
    func configure(_ model: Answer?, buttonState: CheckButtonState, answerIsCorrect: Bool, canTapAnswer: Bool) {
        
        self.currentAnswer = model
        self.canTapAnswer = canTapAnswer
        
        answerLabel.text = model?.text ?? ""
        
        
        switch buttonState {
        case .normal, .next:
            
            if model?.isSelected == true {
                backgroundCellView.backgroundColor = UIColor(named: "background-color")?.withAlphaComponent(0.7)
            } else {
                backgroundCellView.backgroundColor = .lightGray.withAlphaComponent(0.5)
            }
            
        case .check:
            
            if answerIsCorrect == true {
                
                if let isCorrect = model?.isCorrect, isCorrect == true {
                    backgroundCellView.backgroundColor = .systemGreen.withAlphaComponent(0.9)
                    backgroundCellView.layer.borderColor = CGColor(red: 0.627, green: 0.663, blue: 0.988, alpha: 0.7)
                }
                
                return
            }
            
            //Расклад
            if let isCorrect = model?.isCorrect, isCorrect == true {
                backgroundCellView.backgroundColor = .systemGreen.withAlphaComponent(0.9)
            } else {
                backgroundCellView.backgroundColor = .systemRed.withAlphaComponent(0.9)
            }

        }

    
    }
    
    //MARK: - Actions
    
    @objc func answerButtonAction() {
        
        print("answerButtonAction")
    
        if canTapAnswer == true || currentAnswer?.isSelected == true {
            currentAnswer?.isSelected = currentAnswer?.isSelected == false ? true : false
            
            delegate?.answerCellSelectAnswer()
        }
    }
    
}
