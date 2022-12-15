//
//  CategoryTextCollectionCell.swift
//  quiz-app
//
//  Created by Vadym Potapov on 14.11.2022.
//

import UIKit

protocol CategoryCollectionCellOutput: AnyObject {
    func categoryCollectionCellDidSelect(_ category: Category)
}

class CategoryCollectionCell: UICollectionViewCell {
    
    
    static var reuseId = "CategoryTextCollectionCell"
    
    weak var delegate: CategoryCollectionCellOutput? //controller
    
    var category: Category?
    
    private var categoryImage: UIImageView = {
        
        let categoty = UIImageView(image: UIImage(named: ""))
        categoty.contentMode = .scaleAspectFit
        categoty.layer.borderWidth = 2.5
        categoty.layer.borderColor = CGColor(red: 0.627, green: 0.663, blue: 0.988, alpha: 1)
        categoty.layer.cornerRadius = 30
        categoty.clipsToBounds = true
        return categoty
    }()
    
    private lazy var titleButton: UIButton = {
        var button = UIButton()
        //button.backgroundColor = .clear
        button.backgroundColor = .systemGray6.withAlphaComponent(0.1)
        button.addTarget(self, action: #selector(titleButtonAction), for: .touchUpInside)
        button.layer.cornerRadius = 30
        return button
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.clipsToBounds = true
        label.lineBreakMode = .byWordWrapping
        label.font = UIFont(name: "NotoSans-Light", size: 20)
        label.layer.cornerRadius = 30
        return label
    }()
    
    private var categotyNameLabel: UILabel = {
        
        let label = UILabel()
        label.numberOfLines = 0
        label.clipsToBounds = true
        label.lineBreakMode = .byWordWrapping
        label.font = .boldSystemFont(ofSize: 15)
        label.textColor = .systemBackground
        label.backgroundColor = UIColor(named: "background-color")
        label.layer.cornerRadius = 12
        label.layer.borderColor = CGColor(red: 0.627, green: 0.663, blue: 0.988, alpha: 1)
        label.layer.borderWidth = 2.5
        label.textAlignment = .center
        return label
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
    func configure(model: Category) {
        
        
        self.category = model
        
        categotyNameLabel.text = model.name
        
        if model.selected {
            titleLabel.backgroundColor = UIColor(named: "gold")
            categoryImage.layer.borderWidth = 4
            categoryImage.layer.borderColor = CGColor(red: 1, green: 0.578, blue: 0, alpha: 1)
        } else {
            titleLabel.backgroundColor = UIColor(named: "background-color")
            categoryImage.layer.borderWidth = 2.5
            categoryImage.layer.borderColor = CGColor(red: 0.627, green: 0.663, blue: 0.988, alpha: 1)
            
        }
    }
    
    func configurePhoto(model: String) {
        
        categoryImage.image = UIImage.init(named: model)
    }
    
    
    
    
    
    // MARK: - Private
    
    private func setupViews() {
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(titleButton)
        contentView.addSubview(categoryImage)
        contentView.addSubview(categotyNameLabel)
    }
    
    private func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.left.right.bottom.equalTo(contentView).inset(10)
        }
        
        titleButton.snp.makeConstraints { make in
            make.top.left.right.bottom.equalTo(contentView).inset(10)
        }
        categoryImage.snp.makeConstraints { make in
            make.top.left.right.bottom.equalTo(contentView).inset(10)
        }
        categotyNameLabel.snp.makeConstraints { make in
            make.bottom.equalTo(categoryImage.snp.bottom).inset(10)
            make.height.equalTo(40)
            make.width.equalTo(120)
            make.centerX.equalTo(categoryImage.snp.centerX)
        }
    }
    
    // MARK: - Actions
    @objc func titleButtonAction() {
        
        if let category = category {
            category.selected = true
            delegate?.categoryCollectionCellDidSelect(category)
        }
        
    }
    
}
