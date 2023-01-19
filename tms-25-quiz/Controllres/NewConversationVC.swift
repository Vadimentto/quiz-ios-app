//
//  NewConversationVC.swift
//  tms-25-quiz
//
//  Created by Vadym Potapov on 25.12.2022.
//

import UIKit
import FirebaseAuth

class NewConversationVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        validateAuth()
    }
    
    func setupView() {
        
        view.backgroundColor = .systemPink
    }
    
    private func validateAuth() {
        
        if FirebaseAuth.Auth.auth().currentUser == nil {
            let vc = LoginVC()
            let nav = UINavigationController(rootViewController: vc)
            nav.modalPresentationStyle = .fullScreen
            present(nav, animated: false)
    }

    }
}

