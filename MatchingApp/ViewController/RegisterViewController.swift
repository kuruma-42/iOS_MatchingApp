//
//  RegisterViewController.swift
//  MatchingApp
//
//  Created by Yong Jun Cha on 2021/03/15.
//

import UIKit
import RxSwift
import FirebaseAuth

class RegisterViewController: UIViewController {
    
    private let disposeBag = DisposeBag()
    
    
    // MARK : UIview
    private let titleLabel = RegisterTitleLabel()
    private let nameTextField = RegisterTextField(placeHolder: "Name")
    private let emailTextField = RegisterTextField(placeHolder: "E-mail")
    private let passwordTextField = RegisterTextField(placeHolder: "Password")
    private let registerButton = RegisterButton()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupGradientLayer()
        setupLayout()
        setupBindings()
        
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
        
        nameTextField.anchor(height:45)
        baseStackView.anchor(left: view.leftAnchor, right: view.rightAnchor, centerY: view.centerYAnchor, leftPadding: 40, rightPadding: 40)
        titleLabel.anchor(bottom: baseStackView.topAnchor, centerX: view.centerXAnchor, bottomPadding: 20)
    }
    
    private func setupBindings(){
        
        nameTextField.rx.text
            .asDriver()
            .drive { [weak self] text in
                
            }
            .disposed(by: disposeBag)
        
        nameTextField.rx.text
            .asDriver()
            .drive { [weak self] text in
                
            }
            .disposed(by: disposeBag)

        nameTextField.rx.text
            .asDriver()
            .drive { [weak self] text in
                
            }
            .disposed(by: disposeBag)
        
        registerButton.rx.tap
            .asDriver()
            .drive {[weak self] _ in
                self?.createUserToFireAuth()
            }
            .disposed(by: disposeBag)
        
    }
    
    private func createUserToFireAuth() {
        guard let email = emailTextField.text else {return}
        guard let password = passwordTextField.text else {return}
        Auth.auth().createUser(withEmail: email, password: password) { (auth, err) in
            if let err = err {
                print("AuthInfo Save Failed", err)
                return
            }
            guard let uid = auth?.user.uid else { return }
            print("AuthInfo Save Success", uid)
        }
    }
}
