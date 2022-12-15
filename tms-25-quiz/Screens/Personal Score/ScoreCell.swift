//
//  ScoreCell.swift
//  tms-25-quiz
//
//  Created by Vadym Potapov on 25.11.2022.
//

import UIKit

final class ScoreCell: UITableViewCell {
    
    static let reuseId = "ScoreCell"
    
    private var scoreLabel: UILabel = {
        
        let label = UILabel()
        label.text = "50% (5/10)"
        
        return label
    }()
    
    private var categoryLabel: UILabel = {
        
        let label = UILabel()
        label.text = "Euro Euro"
        return label
    }()
    
    private var categoryImageView: UIImageView = {
        
        let imageView = UIImageView()
        imageView.backgroundColor = .systemMint
        
        return imageView
    }()
    
    private var scoreProgressView: UIProgressView = {
        
        let progreesView = UIProgressView()
        progreesView.progress = 0.25
        
        return progreesView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
        setupConstrains()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        
        contentView.backgroundColor = .systemGray6
        
        contentView.addSubview(categoryImageView)
        contentView.addSubview(categoryLabel)
        contentView.addSubview(scoreLabel)
        contentView.addSubview(scoreProgressView)
        
    }
    
    private func setupConstrains() {
        categoryImageView.snp.makeConstraints { make in
            make.left.equalTo(contentView.snp.left).inset(20)
            make.width.height.equalTo(50)
            make.centerY.equalTo(contentView.snp.centerY)
        }
        
        categoryLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView).inset(20)
            make.left.equalTo(categoryImageView.snp.right).offset(20)

            make.right.equalTo(contentView).inset(20)
        }
        
        scoreLabel.snp.makeConstraints { make in
            make.top.equalTo(categoryLabel.snp.bottom).offset(20)
            make.left.equalTo(categoryImageView.snp.right).offset(20)
            make.right.equalTo(contentView.snp.right).inset(20)

        }
        
        scoreProgressView.snp.makeConstraints { make in
            make.top.equalTo(scoreLabel.snp.bottom).offset(20)
            make.left.equalTo(categoryImageView.snp.right).offset(20)
            make.right.equalTo(contentView).inset(20)

            make.bottom.equalTo(contentView.snp.bottom).inset(20)
        }
    }
    
    //MARK: - Public
    
    func configure(_ model: Score) {
        categoryLabel.text = model.category
        
        let correct = Int(model.correctAnswers)
        let all = Int(model.allQuestion)
        
        // "50% (5/10)"
        scoreLabel.text = model.percent + " " + "(\(correct)/\(all))"
        
        scoreProgressView.progress = model.progress
    }
}
