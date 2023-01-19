//
//  LoginVC.swift
//  tms-25-quiz
//
//  Created by Vadym Potapov on 25.12.2022.
//

import UIKit
import FirebaseAuth

class LoginVC: UIViewController {
    
    // MARK: - Properties
    
    private lazy var backgroundImage: UIImageView = {
        
        let background = UIImageView()
        background.image = .init(named: "back-create-user-3")
        background.contentMode = .scaleAspectFill
        return background
    }()
    
    lazy var registredButton: UIBarButtonItem = {
        
         let image = UIImage(systemName: "person.crop.circle.badge.plus")
         let button = UIBarButtonItem.init(image: image, style: .plain, target: self, action: #selector(didTabRegister))
         button.tintColor = UIColor(named: "yellow")
         return button
    }()
    
    private var scrollView: UIScrollView = {
       
        let scrollView = UIScrollView()
        scrollView.clipsToBounds = true
        return scrollView
    }()
    
    private var emailTextField: UITextField = {
        
        let field = UITextField()
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.returnKeyType = .continue
        field.layer.cornerRadius = 12
        field.layer.borderWidth = 2
        field.layer.borderColor = UIColor(named: "deep")?.cgColor
        field.layer.shadowColor = UIColor(named: "deep")?.cgColor
        field.layer.shadowOpacity = 0.7
        field.layer.shadowRadius = 4
        field.layer.shadowOffset = CGSize(width: 4, height: 4)
        field.placeholder = "Email adress"
        field.textColor = UIColor(named: "deep")
        field.font = UIFont(name: "NotoSans-SemiBold", size: 16)
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        field.leftViewMode = .always
        field.backgroundColor = UIColor(named: "yellow")
        return field
    }()
    
    private var passwordTextField: UITextField = {
        
        let field = UITextField()
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.returnKeyType = .default
        field.layer.cornerRadius = 12
        field.layer.borderWidth = 2
        field.layer.borderColor = UIColor(named: "deep")?.cgColor
        field.layer.shadowColor = UIColor(named: "deep")?.cgColor
        field.layer.shadowOpacity = 0.7
        field.layer.shadowRadius = 4
        field.layer.shadowOffset = CGSize(width: 4, height: 4)
        field.placeholder = "Password"
        field.textColor = UIColor(named: "deep")
        field.font = UIFont(name: "NotoSans-SemiBold", size: 16)
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        field.leftViewMode = .always
        field.backgroundColor = UIColor(named: "yellow")
        field.isSecureTextEntry = true
        return field
    }()
    
    private var stackView: UIStackView = {
        
       let stack = UIStackView()
        stack.alignment = .center
        stack.distribution = .fill
        stack.axis = .vertical
        stack.spacing = 40
        stack.backgroundColor = .none
        stack.layer.cornerRadius = 20
        return stack
    }()
    
    private var loginButton: UIButton = {
        
        let button = UIButton()
        button.setTitle("Log in", for: .normal)
        button.backgroundColor = UIColor(named: "deep")
        button.setTitleColor(UIColor(named: "yellow"), for: .normal)
        button.layer.cornerRadius = 12
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor(named: "yellow")?.cgColor
        button.layer.shadowColor = UIColor(named: "deep")?.cgColor
        button.layer.shadowOpacity = 1
        button.layer.shadowRadius = 4
        button.layer.shadowOffset = CGSize(width: 4, height: 4)
//        button.layer.masksToBounds = true
        button.titleLabel?.font = UIFont(name: "NotoSans-SemiBold", size: 16)
        button.addTarget(self, action: #selector(logginButtonTaped), for: .touchUpInside)
        return button
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstrains()
        setupTitleNavigation()
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    private func setupViews() {
        view.addSubview(backgroundImage)
        view.addSubview(stackView)
        stackView.addSubview(emailTextField)
        stackView.addSubview(passwordTextField)
        stackView.addSubview(loginButton)
    }
    
    private func setupConstrains() {
        backgroundImage.snp.makeConstraints { make in
            make.top.left.right.bottom.equalToSuperview()
        }
        stackView.snp.makeConstraints { make in
            make.top.equalTo(backgroundImage.snp.top).inset(160)
           
            make.right.left.equalTo(backgroundImage).inset(40)
            make.bottom.equalTo(backgroundImage).inset(400)
        }
        emailTextField.snp.makeConstraints { make in
            make.top.centerX.equalTo(stackView).inset(20)
            make.height.equalTo(52)
            make.width.equalTo(220)
        }
        passwordTextField.snp.makeConstraints { make in
            make.top.centerX.equalTo(emailTextField).inset(60)
            make.height.equalTo(52)
            make.width.equalTo(220)
        }
        loginButton.snp.makeConstraints { make in
            make.top.centerX.equalTo(passwordTextField).inset(70)
            make.height.equalTo(52)
            make.width.equalTo(100)
        }
    }
    
    @objc private func logginButtonTaped() {
        
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        
        guard let email = emailTextField.text, let password = passwordTextField.text,
              !email.isEmpty, !password.isEmpty, password.count >= 6 else {
            alertUserLoginError()
            return
        }
        
        FirebaseAuth.Auth.auth().signIn(withEmail: email, password: password, completion: { [weak self] authResult, error in
            guard let strongSelf = self else {
                return
            }
            guard let result = authResult, error == nil else {
                print("Falied log in user with email: \(email) ")
                return
            }
            let user = result.user
            print("Logged in User: \(user)")
            strongSelf.navigationController?.dismiss(animated: true, completion: nil)
        })
    }
    
    func alertUserLoginError() {
        
        let alert = UIAlertController(title: "Ops!", message: "Please, enter all information to log in", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Dismis", style: .cancel))
        present(alert, animated: true)
    }
    
    @objc private func didTabRegister() {
        let vc = RegisterVC()
        vc.title = "Create account"
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func setupTitleNavigation() {
        navigationItem.title = "Login"
        navigationItem.rightBarButtonItem = registredButton
        navigationController?.navigationBar.tintColor = UIColor(named: "yellow")
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(named: "deep")
        appearance.titleTextAttributes = [.foregroundColor: UIColor(named: "yellow"), .font: UIFont(name: "NotoSans-SemiBold", size: 22)]
        navigationItem.scrollEdgeAppearance = appearance
        navigationItem.compactAppearance = appearance
    }

}

extension LoginVC: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailTextField {
            passwordTextField.becomeFirstResponder()
        }
            else if textField == passwordTextField {
                logginButtonTaped()
            }
            return true
        }
    }
