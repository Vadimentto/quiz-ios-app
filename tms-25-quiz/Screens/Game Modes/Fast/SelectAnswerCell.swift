//
//  SelectAnswerCell.swift
//  quiz-project
//
//  Created by Vadym Potapov on 28.10.22.
//

import UIKit
import SnapKit

protocol SelectAnswerCellDelegate: AnyObject {
    func selectAnswerCellNextQuestion()
}

class SelectAnswerCell: UITableViewCell {
    
    static var reuseId = "SelectAnswerCell"
    var currentAnswer: Answer? = nil
    var delegate: SelectAnswerCellDelegate?
    
    private lazy var answerButton: UIButton = {
        
        var button = UIButton()
        button.backgroundColor = .lightGray
        button.layer.cornerRadius = 30
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        
        button.addTarget(self, action: #selector(answerButtonsAction), for: .touchUpInside)
        
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
    
    //MARK: - Private
    
    private func setupViews() {
        contentView.addSubview(answerButton)
    }
    
    private func setupConstraints() {
        
        answerButton.snp.makeConstraints { make in
            make.top.left.right.bottom.equalTo(contentView).inset(5)
        }
        
    }
    
    //MARK: - Public
    
    func configure(_ model: Answer?) {
        
        currentAnswer = model
        
        var answerText = model?.text ?? ""
        answerButton.setTitle(answerText, for: .normal)
    }
    
    //MARK: - Actions
    @objc func answerButtonsAction() {
        
        currentAnswer?.isSelected = currentAnswer?.isSelected == false ? true : false
        delegate?.selectAnswerCellNextQuestion()
    }
}
