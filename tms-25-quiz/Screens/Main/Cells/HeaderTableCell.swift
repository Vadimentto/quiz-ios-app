//
//  HeaderCollectionCell.swift
//  tms-25-quiz
//
//  Created by Vadym Potapov on 14.12.2022.
//

import UIKit

class HeaderTableCell: UITableViewHeaderFooterView {
    
    static var reuseId = "HeaderCollectionCell"
    
    weak var delegate: HeaderTableCell?
    
    private lazy var textTitleCategoty: UILabel = {
        
        let text = UILabel()
        text.text = "Select category"
        text.font = UIFont(name: "NotoSans-Light", size: 24)
        text.textAlignment = .center
        text.textColor = .white
        
        return text
    }()
    
    private lazy var stackView: UIStackView = {
        
        let stack = UIStackView()
        stack.alignment = .center
        stack.spacing = 20
        stack.distribution = .equalCentering
        stack.backgroundColor = .none
        return stack
    }()
    
    private lazy var personButton: UIButton = {
        
        let largeConfig = UIImage.SymbolConfiguration(pointSize: 30, weight: .light, scale: .small)
               
        let largeBoldDoc = UIImage(systemName: "person.fill", withConfiguration: largeConfig)
        
        let view = UIButton(type: .custom)
        view.setImage(largeBoldDoc, for: .normal)
        view.tintColor = UIColor(named: "light-blue")
        return view
    }()
    
    private lazy var settingButton: UIButton = {
        
        let largeConfig = UIImage.SymbolConfiguration(pointSize: 30, weight: .light, scale: .small)
               
        let largeBoldDoc = UIImage(systemName: "gearshape.fill", withConfiguration: largeConfig)
        
        let view = UIButton(type: .custom)
        view.setImage(largeBoldDoc, for: .normal)
        view.tintColor = UIColor(named: "light-blue")
        return view
    }()
    
    
    
    // MARK: - Lifecycle
    
    override init( reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Private
    
    private func setupViews() {
        
        contentView.addSubview(textTitleCategoty)
        contentView.addSubview(stackView)
        contentView.addSubview(personButton)
        contentView.addSubview(settingButton)
        contentView.backgroundColor = UIColor(named: "background-color")
    }
    
    private func setupConstraints() {
        
        stackView.snp.makeConstraints { make in
            make.top.equalTo(contentView).inset(0)
            make.left.right.equalTo(contentView).inset(20)
            make.height.equalTo(70)
        }
        
        textTitleCategoty.snp.makeConstraints { make in
            make.top.equalTo(stackView.snp.top).inset(0)
            make.centerX.equalTo(stackView.snp.centerX)
            
        }
        
        personButton.snp.makeConstraints { make in
            make.top.equalTo(stackView).inset(5)
            make.left.equalTo(stackView).inset(10)
        }
        
        settingButton.snp.makeConstraints { make in
            make.top.equalTo(stackView).inset(5)
            make.right.equalTo(stackView).inset(10)
        }
        
    }
}

