//
//  StartGameButtonCell.swift
//  quiz-app
//
//  Created by Vadym Potapov on 14.11.2022.
//

import UIKit

protocol StartGameButtonCellOutput: AnyObject {
    func startGameButtonCellDidSelect()
}

class StartGameButtonCell: UITableViewCell {

    static var reuseId = "StartGameButtonCell"
    
    weak var delegate: StartGameButtonCellOutput?
    
    private lazy var startButton: UIButton = {
        
        
        let largeConfig = UIImage.SymbolConfiguration(pointSize: 140, weight: .light, scale: .small)
               
        let largeBoldDoc = UIImage(systemName: "play.circle", withConfiguration: largeConfig)
        
        let button = UIButton(type: .custom)
        button.frame = CGRect(x: 0, y: 0, width: 70, height: 70)
        button.layer.cornerRadius = 0.5 * button.bounds.size.width
        button.clipsToBounds = true
        button.setImage(largeBoldDoc, for: .normal)
        button.tintColor = UIColor(named: "light-blue")
        button.backgroundColor = UIColor(named: "background-color")
        button.addTarget(self, action: #selector(startGameAction), for: .touchUpInside)
        button.isEnabled = false
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
        contentView.addSubview(startButton)
        contentView.backgroundColor = UIColor(named: "background-color")
        
        self.selectionStyle = .none
    }
    
    private func setupConstraints() {
        
        startButton.snp.makeConstraints { make in
            make.centerX.equalTo(contentView.snp.centerX)
            make.height.equalTo(70)
            make.width.equalTo(70)
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

