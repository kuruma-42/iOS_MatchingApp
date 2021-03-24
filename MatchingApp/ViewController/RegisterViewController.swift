//
//  RegisterViewController.swift
//  MatchingApp
//
//  Created by Yong Jun Cha on 2021/03/15.
//

import UIKit
import RxSwift
import FirebaseAuth
import FirebaseFirestore
import PKHUD

class RegisterViewController: UIViewController {
    
    private let disposeBag = DisposeBag()
    private let viewModel = RegisterViewModel()
    
    
    // MARK : UIview
    private let titleLabel = RegisterTitleLabel(text: "Tinder")
    private let nameTextField = RegisterTextField(placeHolder: "Name")
    private let emailTextField = RegisterTextField(placeHolder: "E-mail")
    private let passwordTextField = RegisterTextField(placeHolder: "Password")
    private let registerButton = RegisterButton(text: "Register")
    private let alreadyHaveAccountButton = UIButton(type: .system).createAboutAccount(text: "If you already have ID Please Click Here")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupGradientLayer()
        setupLayout()
        setupBindings()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.isNavigationBarHidden = true
    }
    
    // MARK : Methods
    private func setupGradientLayer(){
        let layer = CAGradientLayer()
        let startColor = UIColor.rgb(red: 227, green: 48, blue: 78).cgColor
        let endColor = UIColor.rgb(red: 245, green: 208, blue: 108).cgColor
        
        layer.colors = [startColor,endColor]
        layer.locations = [0.0, 1.3]
        layer.frame = view.bounds
        view.layer.addSublayer(layer)
    }
    
    private func setupLayout() {
        self.passwordTextField.isSecureTextEntry = true
        view.backgroundColor = .yellow
        
        let baseStackView = UIStackView(arrangedSubviews: [nameTextField, emailTextField, passwordTextField, registerButton])
        baseStackView.axis = .vertical
        baseStackView.distribution = .fillEqually
        baseStackView.spacing = 20
        
        view.addSubview(baseStackView)
        view.addSubview(titleLabel)
        view.addSubview(alreadyHaveAccountButton)
        
        nameTextField.anchor(height:45)
        baseStackView.anchor(left: view.leftAnchor, right: view.rightAnchor, centerY: view.centerYAnchor, leftPadding: 40, rightPadding: 40)
        titleLabel.anchor(bottom: baseStackView.topAnchor, centerX: view.centerXAnchor, bottomPadding: 20)
        alreadyHaveAccountButton.anchor(top: baseStackView.bottomAnchor, centerX: view.centerXAnchor,
                                        topPadding: 20)
    }
    
    private func setupBindings(){
        
        //textFiled Binding
        nameTextField.rx.text
            .asDriver()
            .drive { [weak self] text in
                self?.viewModel.nameTextInput.onNext(text ?? "")
            }
            .disposed(by: disposeBag)
        
        emailTextField.rx.text
            .asDriver()
            .drive { [weak self] text in
                self?.viewModel.emailTextInput.onNext(text ?? "")

            }
            .disposed(by: disposeBag)

        passwordTextField.rx.text
            .asDriver()
            .drive { [weak self] text in
                self?.viewModel.passwordTextInput.onNext(text ?? "")
            }
            .disposed(by: disposeBag)
        
        registerButton.rx.tap
            .asDriver()
            .drive {[weak self] _ in
                self?.createUser()
            }
            .disposed(by: disposeBag)
        
        //Button Bindings
        alreadyHaveAccountButton.rx.tap
            .asDriver()
            .drive { [weak self] _ in
                let login = LoginViewController()
                self?.navigationController?.pushViewController(login, animated: true)
            }
            .disposed(by: disposeBag)
        
        registerButton.rx.tap
            .asDriver()
            .drive {[weak self] _ in
                self?.createUser()
            }
            .disposed(by: disposeBag)
        
        // viewmodel binding
        viewModel.validRegisterDriver
            .drive { validAll in
                self.registerButton.isEnabled = validAll
                self.registerButton.backgroundColor = validAll ? .rgb(red: 227, green: 48, blue: 78) : .init(white: 0.7, alpha: 1)
            }
            .disposed(by: disposeBag)

        
    }
    private func createUser() {
        let email = emailTextField.text
        let password = passwordTextField.text
        let name = nameTextField.text
        
        HUD.show(.progress)
        Auth.createUserToFireAuth(email: email, password: password, name: name) { success in
            HUD.hide()
            if success {
                print("Success")
                self.dismiss(animated: true)
            } else{
                
            }
        }
    }
}
