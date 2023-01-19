//
//  QuestionTextCell.swift
//  tms-25-quiz
//
//  Created by Vadym Potapov on 18.10.2022.
//

import UIKit

class QuestionTextCell: UITableViewCell {
    
    static var reuseId = "QuestionTextCell"
    
    private lazy var backgroundCellView: UIView = {
        var view = UIView()
        view.backgroundColor = UIColor(named: "background-color")
        view.layer.cornerRadius = 0
        
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        
        var label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.font = UIFont(name: "NotoSans-SemiBold", size: 15)
        label.textAlignment = .center
        label.textColor = .white
        label.backgroundColor = UIColor(named: "background-color")
        return label
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
        contentView.addSubview(backgroundCellView)
        contentView.addSubview(titleLabel)
        contentView.backgroundColor = UIColor(named: "background-color")
    }
    
    private func setupConstraints() {
        
        backgroundCellView.snp.makeConstraints { make in
            make.top.left.right.bottom.equalTo(contentView).inset(0)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.bottom.equalTo(backgroundCellView).inset(0)
            make.left.right.equalTo(backgroundCellView).inset(20)
        }
    }
    
    //MARK: - Public
    
    func configure(_ model: Question?) {
        
        titleLabel.text = model?.text ?? ""
    }
    
}

