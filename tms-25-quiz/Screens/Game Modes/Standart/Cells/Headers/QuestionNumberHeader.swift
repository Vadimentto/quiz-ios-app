//
//  HeaderCell.swift
//  tms-25-quiz
//
//  Created by Vadym Potapov on 21.10.22.
//

import UIKit

protocol QuestionNumberHeaderOutput: AnyObject {
    
    func questionNumberHeaderTimerInvalidate()
}

class QuestionNumberHeader: UIView {
    
    // MARK: - Properties
    
    weak var delegate: QuestionNumberHeaderOutput?
    
    var timer: Timer?
    var durationTimer = 30
    
    let shapeLayer = CAShapeLayer()
    
    
    private lazy var lightBackgroundCellView: UIView = {
        var view = UIView()
        view.backgroundColor = UIColor(named: "background-color")
        return view
    }()
    
    private lazy var shapeView: UIImageView = {
        
        let shape = UIImageView()
//        shape.image = UIImage(named: "circle-2")
        return shape
    }()
    
    private var timerLabel: UILabel = {
        
        let label = UILabel()
        label.text = ""
        label.font = UIFont(name: "NoneSans-Bold", size: 14)
        label.textColor = .black
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    private lazy var headerLabel: UILabel = {
        var label = UILabel()
        label.font = UIFont(name: "NoneSans-Bold", size: 30)
        label.textColor = .white
        label.backgroundColor = UIColor(named: "background-color")
        return label
    }()
    

    //Designated initializer -
    
    override func layoutSubviews() {
        super.layoutSubviews()
        animationCircular()
        //UI
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setupConstraints()
        startTimer()
        timerLabel.text = "\(durationTimer)"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - UI
    
    func startTimer() {
        
        basicAnimation()
//        animationCircular()
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
    }
    
    @objc func timerAction () {
        
        durationTimer -= 1
        timerLabel.text = "\(durationTimer)"
        
        if durationTimer == 0 {
            //delegate
            delegate?.questionNumberHeaderTimerInvalidate()
            //timer = nil
            //timer?.invalidate()
        }
    }
    
    func resetTimer() {
        timer?.invalidate()
        timer = nil
        durationTimer = 31
        startTimer()
        
//        basicAnimation()
//        animationCircular()
//
//        timer.fire()
        
    }
    
    // MARK: - Animation
    
    func animationCircular () {
        
        let center = CGPoint(x: 5, y: 5)
        
        let endAngle = (-CGFloat.pi / 2)
        
        let startAngle = 2 * CGFloat.pi + endAngle
        
        
        let circularPath = UIBezierPath(arcCenter: center, radius: 25, startAngle: startAngle, endAngle: endAngle, clockwise: false)
        
        shapeLayer.path = circularPath.cgPath
        shapeLayer.lineWidth = 4
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeEnd = 1
        shapeLayer.lineCap = CAShapeLayerLineCap.round
        shapeLayer.strokeColor = UIColor(named: "light-blue")?.cgColor
        shapeView.layer.addSublayer(shapeLayer)
    }
    
    func basicAnimation () {
        
        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        basicAnimation.toValue = 0
        basicAnimation.duration = CFTimeInterval(durationTimer)
        basicAnimation.fillMode = CAMediaTimingFillMode.forwards
        basicAnimation.isRemovedOnCompletion = true
        shapeLayer.add(basicAnimation, forKey: "basicAnimation")
    }
    
    private func setupViews() {
        
        self.addSubview(lightBackgroundCellView)
        self.addSubview(headerLabel)
        self.addSubview(timerLabel)
        self.backgroundColor = .none
        headerLabel.addSubview(shapeView)
        shapeView.addSubview(timerLabel)
        
        timerLabel.text = "\(durationTimer)"
    }
    
    private func setupConstraints() {
        lightBackgroundCellView.snp.makeConstraints { make in
            make.left.right.bottom.equalTo(self).inset(0)
            make.height.equalTo(0)
        }
        
        headerLabel.snp.makeConstraints { make in
            make.top.left.right.bottom.equalToSuperview().inset(30)
        }
        
        shapeView.snp.makeConstraints { make in
            make.right.equalTo(headerLabel.snp.right).inset(20)
            make.top.equalTo(headerLabel).inset(10)
            make.height.equalTo(50)
            make.width.equalTo(50)
        }
        
        timerLabel.snp.makeConstraints { make in
            make.right.equalTo(headerLabel.snp.right).inset(40)
            make.top.equalTo(headerLabel).inset(-12)
            make.height.equalTo(50)
            make.width.equalTo(50)
        }
    }
    
    //MARK: - Public
    func configure(currentQuestion: Int, numberOfQuestions: Int) {
        headerLabel.text = "Вопрос \(currentQuestion) из \(numberOfQuestions)"
        timerLabel.text = "\(durationTimer)"
    }
}
