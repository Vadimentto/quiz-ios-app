//
//  ButtonCell.swift
//  tms-25-quiz
//
//  Created by Vadym Potapov on 05.12.2022.
//

import UIKit

protocol StartGameButtonCellCollection: AnyObject {
    func startGameButtonCellDidSelect()
}

class startButtonCollectionCell: UICollectionViewCell {
    
    static var reuseId = "startButtonCollectionCell"
    
    weak var delegate: StartGameButtonCellCollection?
    
    private lazy var startButton: UIButton = {
        
        var button = UIButton()
        button.setTitle("start quiz", for: .normal)
        button.backgroundColor = .blue
        button.layer.cornerRadius = 10
        button.isEnabled = false
        
        button.addTarget(self, action: #selector(startGameAction), for: .touchUpInside)
   
        return button
    }()
    
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private
    
    private func setupViews() {
        
        contentView.addSubview(startButton)
    }
    
    private func setupConstraints() {
        
        startButton.snp.makeConstraints { make in
            make.left.right.equalTo(contentView).inset(20)
            make.top.bottom.equalTo(contentView).inset(20)
            //make.height.equalTo(50)
        }
    }
    
    //MARK: - Public
    func configure(_ model: Category?) {
        
        if model != nil {
            startButton.isEnabled = true
        }
    }

    
    //MARK: - Actions
    @objc
    func startGameAction() {
        delegate?.startGameButtonCellDidSelect()
    }
    
}
