//
//  RegistredVC.swift
//  tms-25-quiz
//
//  Created by Vadym Potapov on 25.12.2022.
//

import UIKit
import FirebaseAuth

class RegisterVC: UIViewController {
    
    // MARK: - Properties
    
    private lazy var backgroundImage: UIImageView = {
        
        let background = UIImageView()
        background.image = .init(named: "ted-lasso-back")
        background.contentMode = .scaleAspectFill
        return background
    }()
    
    private lazy var logoUser: UIImageView = {
        
        let logo = UIImageView()
        logo.image = .init(systemName: "person.circle")
        logo.contentMode = .scaleAspectFill
        logo.layer.cornerRadius = 50
        logo.backgroundColor = UIColor(named: "deep")
        logo.tintColor = UIColor(named: "yellow")
        logo.layer.borderWidth = 1
        logo.layer.borderColor = UIColor(named: "yellow")?.cgColor
        logo.clipsToBounds = true
        logo.layer.masksToBounds = true
        return logo
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
    
    private var nickNameTextField: UITextField = {
        
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
        field.placeholder = "Nick name"
        field.textColor = UIColor(named: "deep")
        field.font = UIFont(name: "NotoSans-SemiBold", size: 14)
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        field.leftViewMode = .always
        field.backgroundColor = UIColor(named: "yellow")
        return field
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
        field.font = UIFont(name: "NotoSans-SemiBold", size: 14)
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
        field.font = UIFont(name: "NotoSans-SemiBold", size: 14)
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
        stack.spacing = 10
        stack.backgroundColor = .none
        stack.layer.cornerRadius = 20
        return stack
    }()
    
    private var loginButton: UIButton = {
        
        let button = UIButton()
        button.setTitle("Register", for: .normal)
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
        view.addSubview(scrollView)
        scrollView.addSubview(stackView)
        stackView.addSubview(logoUser)
        stackView.addSubview(nickNameTextField)
        stackView.addSubview(emailTextField)
        stackView.addSubview(passwordTextField)
        stackView.addSubview(loginButton)
        
        logoUser.isUserInteractionEnabled = true
        stackView.isUserInteractionEnabled = true
        let gesture = UITapGestureRecognizer(target: self, action: #selector(didTapChangeLogoProfile))
        logoUser.addGestureRecognizer(gesture)
    }
    
    @objc private func didTapChangeLogoProfile() {
        presentPhotoActionSheet()
    }
    
    private func setupConstrains() {
        backgroundImage.snp.makeConstraints { make in
            make.top.left.right.bottom.equalToSuperview()
        }
        scrollView.snp.makeConstraints { make in
            make.top.left.right.bottom.equalTo(backgroundImage)
        }
        stackView.snp.makeConstraints { make in
            make.top.equalTo(backgroundImage).inset(105)
            
            make.right.left.equalTo(backgroundImage).inset(40)
            make.bottom.equalTo(backgroundImage).inset(360)
        }
        logoUser.snp.makeConstraints { make in
            make.top.centerX.equalTo(stackView).inset(0)
            make.width.height.equalTo(100)
        }
        nickNameTextField.snp.makeConstraints { make in
            make.top.centerX.equalTo(logoUser).inset(110)
            make.height.equalTo(42)
            make.width.equalTo(220)
        }
        emailTextField.snp.makeConstraints { make in
            make.top.centerX.equalTo(nickNameTextField).inset(50)
            make.height.equalTo(42)
            make.width.equalTo(220)
        }
        passwordTextField.snp.makeConstraints { make in
            make.top.centerX.equalTo(emailTextField).inset(50)
            make.height.equalTo(42)
            make.width.equalTo(220)
        }
        loginButton.snp.makeConstraints { make in
            make.top.centerX.equalTo(passwordTextField).inset(55)
            make.height.equalTo(42)
            make.width.equalTo(100)
        }
        
    }
    
    private func setupTitleNavigation() {
        
        navigationItem.title = "Create account"
        let lineImage = UIImage(systemName: "arrowshape.turn.up.backward")
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(named: "deep")
        appearance.titleTextAttributes = [.foregroundColor: UIColor(named: "yellow"), .font: UIFont(name: "NotoSans-SemiBold", size: 22)]
        appearance.setBackIndicatorImage(lineImage, transitionMaskImage: lineImage)
        navigationItem.scrollEdgeAppearance = appearance
        navigationItem.compactAppearance = appearance
    }
    
    @objc private func logginButtonTaped() {
        
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        nickNameTextField.resignFirstResponder()
        
        guard let nickName = nickNameTextField.text,
              let email = emailTextField.text,
              let password = passwordTextField.text,
              !nickName.isEmpty,!email.isEmpty, !password.isEmpty, password.count >= 6 else {
            alertUserLoginError()
            return
        }
        
        DatabaseManager.shared.userExist(with: email, completion: { [weak self] exists in
            guard let strongSelf = self else {
                return
            }
            guard !exists else {
                // user already exists
                strongSelf.alertUserLoginError(message: "This email adress already exists")
                return
            }
            FirebaseAuth.Auth.auth().createUser(withEmail: email, password: password, completion: { authResult, error in
                guard authResult != nil, error == nil else {
                    print("Error creating user")
                    return
                }
                
                DatabaseManager.shared.insertUser(with: ChatAppUser(nickName: nickName, emailAdress: email))
                strongSelf.navigationController?.dismiss(animated: true, completion: nil)
            })
        })
    }
    
    func alertUserLoginError(message: String = "Please, enter all information to create a new account") {
        
        let alert = UIAlertController(title: "Ops!", message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Dismis", style: .cancel))
        present(alert, animated: true)
    }
    
    @objc private func didTabRegister() {
        let vc = RegisterVC()
        vc.title = "Create account"
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension RegisterVC: UITextFieldDelegate {
    
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

extension RegisterVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func presentPhotoActionSheet() {
        let actionSheet = UIAlertController(title: "Profile picture", message: "How, would you like select a picture?", preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        actionSheet.addAction(UIAlertAction(title: "Take photo", style: .default, handler: { [weak self] _ in
            self?.presentCamera()
        }))
        actionSheet.addAction(UIAlertAction(title: "Chose photo", style: .default, handler: { [weak self] _ in
            self?.presentPhotoPicker()
        }))
        
        present(actionSheet, animated: true)
    }
    
    func presentCamera() {
        let vc = UIImagePickerController()
        vc.sourceType = .camera
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
    }
    
    func presentPhotoPicker() {
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        guard let selectedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else {
            return
        }
        self.logoUser.image = selectedImage
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
