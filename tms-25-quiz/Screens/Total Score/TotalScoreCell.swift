//
//  TotalScoreCell.swift
//  tms-25-quiz
//
//  Created by Vadym Potapov on 29.11.2022.
//

import UIKit
import Lottie

class TotalScoreCell: UITableViewCell {
    
    
    
    static let reuseId = "TotalScoreCell"
    
    private lazy var numberOfrating: UILabel = {
        
        let label = UILabel()
        label.text = "1022"
        label.textColor = UIColor(named: "deep")
        label.textAlignment = .left
        label.font = .boldSystemFont(ofSize: 18)
        return label
    }()
    
    private var userPhoto: UIImageView = {
        
        let photo = UIImageView()
        photo.image = UIImage(named: "messi")
        photo.contentMode = .scaleAspectFit
        photo.layer.borderWidth = 2.5
        photo.layer.borderColor = CGColor(red: 0.644, green: 0.275, blue: 0.828, alpha: 1)
        photo.layer.cornerRadius = 30
        photo.clipsToBounds = true
        return photo
    }()
    
    private var userNickName: UILabel = {
        
        let name = UILabel()
        name.text = "Lionel Messi"
        name.textColor = UIColor(named: "deep")
        name.textAlignment = .left
        name.font = .boldSystemFont(ofSize: 18)
        name.lineBreakMode = .byTruncatingTail
        return name
    }()
    
    private var totalScoreCount: UILabel = {
       
        let score = UILabel()
        score.text = ""
        score.textColor = UIColor(named: "deep")
        score.textAlignment = .right
        score.font = .boldSystemFont(ofSize: 10)
        score.lineBreakMode = .byTruncatingTail
        return score
    }()
    
    private var animationView: LottieAnimationView = {
        
        let scoreAnimation = LottieAnimationView()
        scoreAnimation.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        scoreAnimation.animation = .named("sleep-man")
        return scoreAnimation
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupView()
        setupConstrain()
        animationView.play()
        animationView.loopMode = .repeat(1)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupView() {
        contentView.addSubview(numberOfrating)
        contentView.addSubview(userPhoto)
        contentView.addSubview(userNickName)
        contentView.addSubview(totalScoreCount)
        contentView.addSubview(animationView)
    }
    
    private func setupConstrain() {
        
        numberOfrating.snp.makeConstraints { make in
            make.left.equalTo(contentView.snp.left).inset(20)
            make.width.height.equalTo(50)
            make.centerY.equalTo(contentView.snp.centerY)
        }
        
        userPhoto.snp.makeConstraints { make in
            make.left.equalTo(numberOfrating.snp.left).inset(60)
            make.centerY.equalTo(contentView.snp.centerY)
            make.width.height.equalTo(60)
        }
        
        userNickName.snp.makeConstraints { make in
            make.left.equalTo(userPhoto.snp.left).inset(80)
            make.centerY.equalTo(contentView.snp.centerY)
            make.right.equalTo(animationView.snp.right).inset(20)
        }
        
        totalScoreCount.snp.makeConstraints { make in
            make.left.equalTo(animationView.snp.left).inset(30)
            make.centerY.equalTo(contentView.snp.centerY)
            make.right.equalTo(contentView).inset(20)
        }
        
        animationView.snp.makeConstraints { make in
            make.left.equalTo(userNickName.snp.left).inset(90)
            make.centerY.equalTo(contentView.snp.centerY)
            make.right.equalTo(totalScoreCount.snp.right).inset(10)
            make.width.height.equalTo(80)
        }
    }
    
    //MARK: - Public
    
    func configure(totalScore: Int) {
        
        totalScoreCount.text = "\(totalScore)"
    }
}
