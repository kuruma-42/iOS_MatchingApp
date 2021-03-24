//
//  RegisterTitleLabel.swift
//  MatchingApp
//
//  Created by Yong Jun Cha on 2021/03/15.
//

import UIKit

class RegisterTitleLabel: UILabel {
    
    init(text: String) {
        super.init(frame: .zero)
        self.text = text
        self.font = .boldSystemFont(ofSize: 80)
        self.textColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
