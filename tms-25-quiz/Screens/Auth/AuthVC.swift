//
//  AuthVC.swift
//  tms-25-quiz
//
//  Created by Vadym Potapov on 27.11.2022.
//

import UIKit
import FirebaseAuth
import Combine

class AuthVC: UIViewController {
    
    enum LoginStatus {
        
        case signIn
        case signUp
    }
    
    var emailIsEmpty = true
    var passwordIsEmpty = true
   lazy var loginStatus: LoginStatus = .signUp {
        didSet {
            self.signUpLabel.text = (loginStatus == .signUp) ? "Sign up" : "Sign in"
            self.buttonCreateAccount.setTitle((loginStatus == .signUp) ? "Create account" : "Sign in", for: .normal)
            self.buttonAlreadyHaveAccount.setTitle((loginStatus == .signUp) ? "Already have an account?" : "Don't have an account?" ,for: .normal)
            self.passwordTF.textContentType = (loginStatus == .signUp) ? .newPassword : .password
        }
    }
    private var tokens: Set<AnyCancellable> = []
    
    private lazy var backgroundImage: UIImageView = {
        
        let background = UIImageView()
        background.image = .init(named: "background-ball")
        background.contentMode = .scaleAspectFit
        return background
    }()
    
    private lazy var loginCard: UIView = {
        
        let view = UIView()
        view.layer.cornerRadius = 30
        view.layer.shadowOpacity = 0.15
        view.layer.shadowOffset = CGSize(width: 30, height: 30)
        view.layer.shadowColor = CGColor(red: 0.324, green: 0, blue: 0.662, alpha: 1)
        view.layer.shadowRadius = 30
        view.layer.borderWidth = 0.5
        view.layer.borderColor = CGColor(red: 0.476, green: 0.476, blue: 0.476, alpha: 1)
        view.backgroundColor = .systemBackground.withAlphaComponent(0.45)
        return view
    }()
    
    private lazy var signUpLabel: UILabel = {
        
        let label = UILabel()
        label.textColor = .systemIndigo.withAlphaComponent(0.8)
        label.font = .boldSystemFont(ofSize: 34)
        label.textAlignment = .left
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        
        let label = UILabel()
        label.text = "The most complete football quiz in the world. More than 5,000 thousand questions."
        label.lineBreakMode = .byWordWrapping
        label.textColor = .black.withAlphaComponent(0.7)
        label.font = .systemFont(ofSize: 14)
        label.textAlignment = .left
        label.numberOfLines = 2
        return label
    }()
    
    private lazy var conteinerForEmailTF: UIView = {
        
        let conteiner = UIView()
        conteiner.backgroundColor = .white.withAlphaComponent(0.6)
        conteiner.layer.cornerRadius = 15
        conteiner.layer.shadowOpacity = 0.5
        conteiner.layer.shadowOffset = CGSize(width: 30, height: 30)
        conteiner.layer.shadowColor = CGColor(red: 0.324, green: 0, blue: 0.662, alpha: 1)
        conteiner.layer.shadowRadius = 30
        conteiner.layer.borderColor = CGColor(red: 0.582, green: 0.216, blue: 1, alpha: 1)
        conteiner.layer.borderWidth = 1
        
        return conteiner
    }()
    
    private lazy var conteinerForPasswordTF: UIView = {
        
        let conteiner = UIView()
        conteiner.backgroundColor = .white.withAlphaComponent(0.6)
        conteiner.layer.cornerRadius = 15
        conteiner.layer.shadowOpacity = 0.5
        conteiner.layer.shadowOffset = CGSize(width: 30, height: 30)
        conteiner.layer.shadowColor = CGColor(red: 0.324, green: 0, blue: 0.662, alpha: 1)
        conteiner.layer.shadowRadius = 30
        conteiner.layer.borderColor = CGColor(red: 0.582, green: 0.216, blue: 1, alpha: 1)
        conteiner.layer.borderWidth = 1
        
        return conteiner
    }()
    
    private lazy var iconEmail: UIView = {
        
        let icon = UIView()
        icon.layer.cornerRadius = 8
        icon.layer.borderWidth = 1
        icon.backgroundColor = .systemBackground.withAlphaComponent(0.3)
        icon.layer.borderColor = CGColor(red: 1, green: 1, blue: 1, alpha: 0.1)
        return icon
    }()
    
    private lazy var iconPassword: UIView = {
        
        let icon = UIView()
        icon.layer.cornerRadius = 8
        icon.layer.borderWidth = 1
        icon.backgroundColor = .systemBackground.withAlphaComponent(0.3)
        icon.layer.borderColor = CGColor(red: 1, green: 1, blue: 1, alpha: 0.1)
        return icon
    }()
    
    private lazy var imageEmail: UIImageView = {
        
        let image = UIImageView()
        image.image = .init(systemName: "envelope.circle")
        image.tintColor = .systemIndigo.withAlphaComponent(0.8)
        return image
    }()
    
    private lazy var imagePassword: UIImageView = {
        
        let image = UIImageView()
        image.image = .init(systemName: "lock.circle")
        image.tintColor = .systemIndigo.withAlphaComponent(0.8)
        return image
    }()
    
    private lazy var passwordTF: UITextField = {
        
        let passwordTF = UITextField()
        passwordTF.textContentType = .password
        passwordTF.text = ""
        passwordTF.placeholder = "password"
        passwordTF.borderStyle = .none
        passwordTF.textColor = .black.withAlphaComponent(0.6)
        passwordTF.font = .systemFont(ofSize: 17)
        passwordTF.isSecureTextEntry = true
        return passwordTF
    }()
    
    private lazy var emailTF: UITextField = {
        
        let emailTF = UITextField()
        emailTF.textContentType = .emailAddress
        emailTF.text = ""
        emailTF.placeholder = "email"
        emailTF.borderStyle = .none
        emailTF.textColor = .black.withAlphaComponent(0.6)
        emailTF.font = .systemFont(ofSize: 17)
        return emailTF
    }()
    
    private lazy var conteinerForButton: UIView = {
        
        let view = UIView()
        view.backgroundColor = .white.withAlphaComponent(0.6)
        view.layer.cornerRadius = 15
        view.layer.shadowOpacity = 0.5
        view.layer.shadowOffset = CGSize(width: 30, height: 30)
        view.layer.shadowColor = CGColor(red: 0.324, green: 0, blue: 0.662, alpha: 1)
        view.layer.shadowRadius = 30
        view.layer.borderColor = CGColor(red: 0.582, green: 0.216, blue: 1, alpha: 1)
        view.layer.borderWidth = 1
        return view
    }()
    
    private lazy var buttonCreateAccount: UIButton = {
        
        let button = UIButton()
        button.setTitleColor(UIColor.systemIndigo.withAlphaComponent(0.7), for: .normal)
        button.addTarget(self, action: #selector(registrationToFirebase), for: .touchUpInside)
        button.titleLabel?.font = .boldSystemFont(ofSize: 17)
        return button
    }()
    
    private lazy var termsOfService: UILabel = {
        
        let label = UILabel()
        label.text = "By clicking on Sign up, you agree to our Terms of service and Privacy policy."
        label.lineBreakMode = .byWordWrapping
        label.textColor = .black.withAlphaComponent(0.7)
        label.font = .systemFont(ofSize: 14)
        label.textAlignment = .left
        label.numberOfLines = 2
        return label
    }()
    
    private lazy var lineView: UIView = {
        
        let line = UIView()
        line.backgroundColor = .black.withAlphaComponent(0.1)
        return line
    }()
    
    private lazy var buttonAlreadyHaveAccount: UIButton = {
        let button = UIButton()
        button.setTitleColor(UIColor.systemIndigo.withAlphaComponent(0.7), for: .normal)
        button.addTarget(self, action: #selector(accessoryButtonAction), for: .touchUpInside)
        button.titleLabel?.font = .boldSystemFont(ofSize: 17)
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupConstrains()
        authorizeToFirebase()
        registrationToFirebase()
        accessoryButtonAction()
        
        emailTF.publisher(for: \.text)
            .sink { newValee in
                self.emailIsEmpty = (newValee == "" || newValee == nil)
            }
            .store(in: &tokens)
        
        passwordTF.publisher(for: \.text)
            .sink { newValee in
                self.passwordIsEmpty = (newValee == "" || newValee == nil)
            }
            .store(in: &tokens)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    //MARK: - Navigation
    func showMainScreen() {
        
        let mainVC = ScreenFactoryImpl().makeMainScreen()
        self.navigationController?.pushViewController(mainVC, animated: true)
    }
    
    //Логин - вход в аккаунт
  @objc  func authorizeToFirebase() {
        
        Auth.auth().signIn(withEmail: "\(emailTF.text ?? "")", password: "\(passwordTF.text ?? "")") { result, error in
            
            if let error = error {
                
                print(error.localizedDescription)
                let alertController = UIAlertController(title: "error", message: "\(error.localizedDescription)", preferredStyle: .alert)
                let alertAction = UIAlertAction(title: "Ok", style: .cancel)
                alertController.addAction(alertAction)
                self.present(alertController, animated: true, completion: nil)
                return
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                self.showMainScreen()
            }
            
        }
    }
    
    //Создание аккаунта
    @objc func registrationToFirebase() {
        
        if (emailIsEmpty || passwordIsEmpty) {
            let alert = UIAlertController(title: "Missing infomation", message: "Please make sure to enter a valid email and password", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default))
            self.present(alert, animated: true, completion: nil)
        } else {
            if loginStatus == .signUp {
                Auth.auth().createUser(withEmail: emailTF.text ?? "", password: passwordTF.text ?? "")
                { result, error in
                    guard error == nil else {
                        print(error?.localizedDescription ?? "")
                        return
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        self.showMainScreen()
                    }
                }
            }
            else {
                Auth.auth().signIn(withEmail: "\(emailTF.text ?? "")", password: "\(passwordTF.text ?? "")") { result, error in
                    
                    if let error = error {
                        
                        print(error.localizedDescription)
                        let alertController = UIAlertController(title: "error", message: "\(error.localizedDescription)", preferredStyle: .alert)
                        let alertAction = UIAlertAction(title: "Ok", style: .cancel)
                        alertController.addAction(alertAction)
                        self.present(alertController, animated: true, completion: nil)
                        return
                    }
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        self.showMainScreen()
                    }
                    
                }
            }
        }
        
    }
    
    //Логаут - выход из аккаунта
    func logoutFromFirebase() {
        
        do {
            try Auth.auth().signOut()
            
        } catch {
            print(error.localizedDescription)
        }
        
        
    }
    
    private func setupConstrains() {
        backgroundImage.snp.makeConstraints { make in
            make.top.left.right.bottom.equalToSuperview()
        }
        
        loginCard.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(20)
            make.top.bottom.equalToSuperview().inset(200)
            make.height.equalTo(440)
        }
        
        signUpLabel.snp.makeConstraints { make in
            make.top.equalTo(loginCard).inset(10)
            make.left.right.equalTo(loginCard).inset(16)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(signUpLabel).inset(50)
            make.left.right.equalTo(loginCard).inset(16)
        }
        
        
        conteinerForEmailTF.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel).inset(50)
            make.left.right.equalTo(loginCard).inset(16)
            make.height.equalTo(52)
        }
        
        iconEmail.snp.makeConstraints { make in
            make.left.top.bottom.equalTo(conteinerForEmailTF).inset(8)
            make.width.equalTo(36)
            make.height.equalTo(36)
        }
        
        imageEmail.snp.makeConstraints { make in
            make.left.right.top.bottom.equalTo(iconEmail).inset(0)
        }
        
        emailTF.snp.makeConstraints { make in
            make.top.bottom.equalTo(conteinerForEmailTF).inset(8)
            make.left.equalTo(iconEmail).inset(45)
            make.right.equalTo(conteinerForEmailTF).inset(8)
        }
        
        conteinerForPasswordTF.snp.makeConstraints { make in
            make.top.equalTo(conteinerForEmailTF).inset(60)
            make.left.right.equalTo(loginCard).inset(16)
            make.height.equalTo(52)
        }
        
        iconPassword.snp.makeConstraints { make in
            make.left.top.bottom.equalTo(conteinerForPasswordTF).inset(8)
            make.width.equalTo(36)
            make.height.equalTo(36)
        }
        
        imagePassword.snp.makeConstraints { make in
            make.top.bottom.left.right.equalTo(iconPassword).inset(0)
        }
        
        passwordTF.snp.makeConstraints { make in
            make.top.bottom.equalTo(conteinerForPasswordTF).inset(8)
            make.left.equalTo(iconPassword).inset(45)
            make.right.equalTo(conteinerForPasswordTF).inset(8)
        }
        
        conteinerForButton.snp.makeConstraints { make in
            make.top.equalTo(conteinerForPasswordTF).inset(60)
            make.left.right.equalTo(loginCard).inset(16)
            make.height.equalTo(52)
        }
        
        buttonCreateAccount.snp.makeConstraints { make in
            make.top.left.right.equalTo(conteinerForButton)
            make.height.equalTo(52)
        }
        
        termsOfService.snp.makeConstraints { make in
            make.top.equalTo(buttonCreateAccount.snp.top).inset(70)
            make.right.left.equalTo(loginCard).inset(16)
        }
        
        lineView.snp.makeConstraints { make in
            make.top.equalTo(termsOfService.snp.top).inset(50)
            make.right.left.equalTo(loginCard).inset(16)
            make.height.equalTo(1)
        }
        
        buttonAlreadyHaveAccount.snp.makeConstraints { make in
            make.top.equalTo(lineView.snp.top).inset(20)
            make.right.left.equalTo(loginCard).inset(16)
            make.bottom.equalTo(loginCard.snp.bottom).inset(10)
            make.height.equalTo(30)
        }
    }
    
    private func setupViews() {
        
//        UIView.animate(withDuration: 1.0, delay: 0.2, options: .curveEaseInOut) {
//            self.loginCard.alpha = 1
//            self.loginCard.frame = self.loginCard.frame.offsetBy(dx: 0, dy: -400)
//        }
        view.addSubview(backgroundImage)
        view.addSubview(loginCard)
        view.addSubview(signUpLabel)
        view.addSubview(descriptionLabel)
        view.addSubview(conteinerForEmailTF)
        view.addSubview(iconEmail)
        view.addSubview(imageEmail)
        view.addSubview(emailTF)
        view.addSubview(conteinerForPasswordTF)
        view.addSubview(iconPassword)
        view.addSubview(imagePassword)
        view.addSubview(passwordTF)
        view.addSubview(conteinerForButton)
        view.addSubview(buttonCreateAccount)
        view.addSubview(termsOfService)
        view.addSubview(lineView)
        view.addSubview(buttonAlreadyHaveAccount)
    }
    
    @objc func accessoryButtonAction () {
        self.loginStatus = (self.loginStatus == .signUp) ? .signIn : .signUp
    }
}
