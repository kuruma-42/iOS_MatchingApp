//
//  ProfileImageView.swift
//  MatchingApp
//
//  Created by Yong Jun Cha on 2021/04/06.
//

import UIKit

class ProfileImageView: UIImageView {
    init() {
        super.init(frame: .zero)
        
        self.image = UIImage(named: "no-photos")
        self.contentMode = .scaleAspectFill
        self.layer.cornerRadius = 90
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
