//
//  QuestionImageCell.swift
//  tms-25-quiz
//
//  Created by Vadym Potapov on 21.10.22.
//

import UIKit
import SDWebImage

class QuestionImageCell: UITableViewCell {
    
    static var reuseId = "QuestionImageCell"
    
    private lazy var questionImageView: UIImageView = {
        
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 15
        return imageView
    }()
    
    private lazy var stackViewImage: UIStackView = {
        
        var stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.layer.cornerRadius = 15
        
        return stack
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
        contentView.addSubview(questionImageView)
        contentView.backgroundColor = .none
        contentView.addSubview(stackViewImage)
    }
    
    private func setupConstraints() {
        
        questionImageView.snp.makeConstraints { make in
            make.top.bottom.left.right.equalTo(stackViewImage) //image 5000/7000
        }
        
        stackViewImage.snp.makeConstraints { make in
            make.top.equalTo(contentView).inset(30)
            make.left.right.equalTo(contentView).inset(30)
            make.bottom.equalTo(contentView).inset(40)
        }
        
    }
    
    //MARK: - Public
    
    func configure(_ model: Question?) {

        let url = URL.init(string: model?.image ?? "")
        questionImageView.sd_setImage(with: url)
    }
    
}
