//
//  RegisterViewController.swift
//  MatchingApp
//
//  Created by Yong Jun Cha on 2021/03/15.
//

import UIKit

class RegisterViewController: UIViewController {
    
    private let nameTextField = RegisterTextField(placeHolder: "Name")
    
    private let emailTextField = RegisterTextField(placeHolder: "E-mail")

    private let passwordTextField = RegisterTextField(placeHolder: "Password")
    
    
    let registerButton : UIButton = {
        let button = UIButton(type : .system)
        button.setTitle("Register", for: .normal)
        button.backgroundColor = .red
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10 
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .yellow
        
        let baseStackView = UIStackView(arrangedSubviews: [nameTextField, emailTextField, passwordTextField, registerButton])
        baseStackView.axis = .vertical
        baseStackView.distribution = .fillEqually
        baseStackView.spacing = 20
        
        view.addSubview(baseStackView)
        
        nameTextField.anchor(height:45)
        baseStackView.anchor(left: view.leftAnchor, right: view.rightAnchor, centerY: view.centerYAnchor, leftPadding: 40, rightPadding: 40)
    }
    
}
