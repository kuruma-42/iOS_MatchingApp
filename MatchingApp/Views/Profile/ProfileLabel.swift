//
//  ProfileLabel.swift
//  MatchingApp
//
//  Created by Yong Jun Cha on 2021/04/06.
//

import UIKit
class ProfileLabel: UILabel {
    init() {
        super.init(frame: .zero)
        
        self.font = .systemFont(ofSize: 45, weight: .bold)
        self.textColor = .black
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
