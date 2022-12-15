//
//  CALayerVC.swift
//  tms-25-quiz
//
//  Created by Vadym Potapov on 09.12.2022.
//

import UIKit
import CoreGraphics
import SnapKit

class CALayerVC: UIViewController {
    
    let layer = CALayer()

    
    let shapeLayer = CAShapeLayer()
    
    var textLayer = CATextLayer()
    
    private var timer = Timer()
    private var timeRemining: Double = 30
    
    var viewForLayer: UIView = {
        
        let view = UIView()
        view.backgroundColor = .systemYellow
        return view
    }()
    
    lazy var timerLabel: UILabel = {
        
        let label = UILabel()
        label.text = ""
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 32)
        label.textColor = .black
        label.backgroundColor = .magenta
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        setupLayer()
        setupShapeLayer()
        setupViews()
        setupConstrain()
        handletap()
        playTimer()
    }
    
    func setupConstrain () {
        viewForLayer.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().inset(50)
            make.right.left.equalToSuperview().inset(20)
        }
    }
    
    func setupViews() {
        view.backgroundColor = .lightGray
        view.addSubview(viewForLayer)
        viewForLayer.layer.addSublayer(layer)
        viewForLayer.layer.addSublayer(shapeLayer)
        viewForLayer.layer.addSublayer(textLayer)
        view.addSubview(timerLabel)
    }
    
    @objc func handletap () {
        
        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        basicAnimation.toValue = 1
        basicAnimation.duration = timeRemining
        basicAnimation.fillMode = CAMediaTimingFillMode.forwards
        basicAnimation.isRemovedOnCompletion = false
        shapeLayer.add(basicAnimation, forKey: "urSoBasic")
    }
    
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
    
}

extension CALayerVC {
    func setupLayer() {
        
        // устанавливаем границы лейеру из нашего вью, добавляем в качестве лейера каритинку
        layer.frame = CGRect(x: 25, y: 35, width: 140, height: 140)
        layer.contents = UIImage(named: "star")?.cgImage
        
        layer.contentsGravity = .center
        layer.magnificationFilter = .linear
        
        layer.cornerRadius = 40.0
        layer.borderWidth = 8.0
        layer.borderColor = UIColor.systemPink.cgColor
        layer.backgroundColor = UIColor.systemOrange.cgColor
        
        layer.shadowOpacity = 0.75
        layer.shadowOffset = CGSize(width: 0, height: 3)
        layer.shadowRadius = 3.0
        layer.isGeometryFlipped = false
    }
}

extension CALayerVC {
    func setupShapeLayer() {
        
        let top = CGPoint(x: 250, y: 100)
        let circularPath = UIBezierPath(arcCenter: top, radius: 50, startAngle: -CGFloat.pi / 2, endAngle: 2 * CGFloat.pi, clockwise: true)
        shapeLayer.path = circularPath.cgPath
        
        shapeLayer.strokeColor = UIColor.systemMint.cgColor
        shapeLayer.lineCap = CAShapeLayerLineCap.round
        shapeLayer.lineWidth = 8
        shapeLayer.strokeEnd = 0
        shapeLayer.fillColor = UIColor.clear.cgColor
        view.layer.addSublayer(shapeLayer)
        view.addGestureRecognizer(UIGestureRecognizer(target: self, action: #selector(handletap)))
        
        textLayer.font = UIFont.boldSystemFont(ofSize: 12)
        textLayer.frame = CGRect(x: 210, y: 80, width: 80, height: 40)
        textLayer.alignmentMode = .center
        textLayer.isWrapped = true
        textLayer.truncationMode = .end
        textLayer.backgroundColor = UIColor.clear.cgColor
        
    }
}


//let center = view.center
//let circularPath = UIBezierPath(arcCenter: center, radius: 50, startAngle: -CGFloat.pi / 2, endAngle: 2 * CGFloat.pi, clockwise: true)
//shapeLayer.path = circularPath.cgPath
//shapeLayer.strokeColor = UIColor.red.cgColor - done
//shapeLayer.lineCap = CAShapeLayerLineCap.round - done
//shapeLayer.fillColor = UIColor.clear.cgColor - done
//shapeLayer.lineWidth = 8 - done
//shapeLayer.strokeEnd = 0 - done
//view.layer.addSublayer(shapeLayer) - done
//view.addGestureRecognizer(UIGestureRecognizer(target: self, action: #selector(handletap)))
//let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
//basicAnimation.toValue = 1
//basicAnimation.duration = 2
//basicAnimation.fillMode = CAMediaTimingFillMode.forwards
//basicAnimation.isRemovedOnCompletion = false
//shapeLayer.add(basicAnimation, forKey: "urSoBasic")
