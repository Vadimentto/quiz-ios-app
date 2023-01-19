//
//  ScoreHeaderView.swift
//  tms-25-quiz
//
//  Created by Vadym Potapov on 30.11.2022.
//

import UIKit

class ScoreHeaderView: UIView {
        
    private lazy var headerLabel: UILabel = {
        var label = UILabel()
        label.font = UIFont(name: "NotoSans-Medium", size: 20)
        label.textColor = UIColor(named: "light-blue")
        return label
    }()
    
    //Designated initializer -
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Private
    private func setupViews() {
        
        self.addSubview(headerLabel)
        self.backgroundColor = UIColor(named: "background-color")
    }
    
    private func setupConstraints() {
       
        headerLabel.snp.makeConstraints { make in
            make.top.left.right.bottom.equalToSuperview().inset(30)
        }
    }
    
    //MARK: - Public
    func configure(totalScore: Int) {
        headerLabel.text = " Total Score - \(totalScore)"
    }
    
}



