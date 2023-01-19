//
//  GameModeCollectionCell.swift
//  quiz-app
//
//  Created by Vadym Potapov on 14.11.2022.
//

import UIKit

protocol GameModeCollectionCellDelegate: Any {
    func selectModeButtonAction()
}

class GameModeCollectionCell: UICollectionViewCell {
    
    static var reuseId = "GameModeCollectionCell"
    
    var delegate: GameModeCollectionCellDelegate?
    
    var categoryIsSelected = false
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.layer.cornerRadius = 20
        label.clipsToBounds = true
        label.textAlignment = .center
        label.lineBreakMode = .byWordWrapping
        label.font = UIFont(name: "Avenir Next", size: 20)
        label.textColor = .systemBackground
        return label
    }()
    
    private lazy var selectModeButton: UIButton = {
        
        var button = UIButton()
        button.backgroundColor = .clear
        //button.addTarget(self, action: #selector(selectModeButtonAction), for: .touchUpInside)
        
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
    
    //MARK: Public
    func configure(model: String) {
        titleLabel.text = model
    }
    
    // MARK: - Private
    
    private func setupViews() {
        titleLabel.backgroundColor = .blue
        contentView.addSubview(titleLabel)
        contentView.addSubview(selectModeButton)
    }
    
    private func setupConstraints() {
        
//        selectModeButton.snp.makeConstraints {
//            $0.top.left.right.bottom.equalTo(contentView).inset(20)
//        }
        
        titleLabel.snp.makeConstraints {
            $0.top.left.right.bottom.equalTo(contentView).inset(20)
        }
    }
    
    // MARK: - Actions
    
    @objc func selectModeButtonAction() {
//        categoryIsSelected = true
//        delegate?.selectModeButtonAction()
    }
}
