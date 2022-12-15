//
//  ZeroView.swift
//  tms-25-zeroview-xib
//
//  Created by Vadym Potapov on 18.11.2022.
//

import UIKit
import SnapKit
import Lottie

class ZeroView: UIView {
    
    var animationView: LottieAnimationView!
    
    private var loadingView: LottieAnimationView = {
        
        let loading = LottieAnimationView()
        loading.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        loading.animation = .named("loadi")
        return loading
    }()
    
    init(jsonName: String) {
        super.init(frame: .zero)
        
        self.backgroundColor = .white
        
        setupAnimation(jsonName)
        setupConstrains()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        fatalError("init(coder:) has not been implemented")
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        //fatalError("init(coder:) has not been implemented")
        //setupAnimation(jsonName)
    }
    
    func setupAnimation(_ jsonName: String) {
        //let jsonName = "sleep-man"
        let animation = LottieAnimation.named(jsonName)
        // Load animation to AnimationView
        animationView = LottieAnimationView(animation: animation)
        animationView.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        
        self.addSubview(animationView)
        self.addSubview(loadingView)
        
        animationView.pinEdgesToSuperView()
        loadingView.pinEdgesToSuperView()
        
        animationView.play()
        
        animationView.loopMode = .repeat(1)
        loadingView.loopMode = .repeat(1)
        loadingView.play()
    }
    
    func startAnimation() {
        // Play the animation
        animationView.play()
        loadingView.play()
    }
    
    func stopAnimation() {
        animationView.stop()
        loadingView.stop()
    }
    
    func setupConstrains() {
        loadingView.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(5)
            make.top.equalTo(animationView).inset(5)
        }
    }
}
