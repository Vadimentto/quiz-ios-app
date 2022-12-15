//
//  HeaderCell.swift
//  tms-25-quiz
//
//  Created by Vadym Potapov on 21.10.22.
//

import UIKit

class QuestionNumberHeader: UIView {
    
    // MARK: - Properties
    
    private var timeRemining: Int = 30
    private var timer = Timer()
    
    
    private lazy var lightBackgroundCellView: UIView = {
        var view = UIView()
        //view.backgroundColor = #colorLiteral(red: 0.2573978007, green: 0.3208354115, blue: 0.610801816, alpha: 1)
        return view
    }()
    
    private lazy var headerLabel: UILabel = {
        var label = UILabel()
        label.font = .boldSystemFont(ofSize: 16)
        label.textColor = .black
        return label
    }()
    
    private lazy var timerLabel: UILabel = {
        
        var label = UILabel()
        return label
    }()
    
    
    
    //Designated initializer -
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setupConstraints()
        playTimer()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI
    
    
    private func playTimer() {
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(step), userInfo: nil, repeats: true)
    }
    
    @objc func step() {
        
        if timeRemining > 0 {
            
            timeRemining -= 1
        } else {
            
            timer.invalidate()
            timeRemining = 30
        }
        timerLabel.text = "\(timeRemining)"
    }
    
    private func setupViews() {
        
        self.addSubview(lightBackgroundCellView)
        self.addSubview(headerLabel)
        self.addSubview(timerLabel)
        self.backgroundColor = .none
    }
    
    private func setupConstraints() {
        lightBackgroundCellView.snp.makeConstraints { make in
            make.left.right.bottom.equalTo(self).inset(0)
            make.height.equalTo(0)
        }
        
        headerLabel.snp.makeConstraints { make in
            make.top.left.right.bottom.equalToSuperview().inset(30)
        }
        
        timerLabel.snp.makeConstraints { make in
            make.top.bottom.right.equalToSuperview().inset(30)
        }
    }
    
    //MARK: - Public
    func configure(currentQuestion: Int, numberOfQuestions: Int) {
        headerLabel.text = "Вопрос \(currentQuestion) из \(numberOfQuestions)"
        timerLabel.text = "\(timeRemining)"
    }
}
