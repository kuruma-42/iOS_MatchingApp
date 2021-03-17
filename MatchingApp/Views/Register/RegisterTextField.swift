//
//  RegisterTextFiled.swift
//  MatchingApp
//
//  Created by Yong Jun Cha on 2021/03/15.
//

import UIKit

class RegisterTextField: UITextField {
    
    init(placeHolder : String) {
        super.init(frame: .zero)
        
        placeholder = placeHolder
        borderStyle = .roundedRect
        font = .systemFont(ofSize: 14)
//        To solve stron password problem
        textContentType = .oneTimeCode
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
