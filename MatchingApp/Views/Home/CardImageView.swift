//
//  CardImageView.swift
//  MatchingApp
//
//  Created by Yong Jun Cha on 2021/03/12.
//

import UIKit

class CardImageView : UIImageView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        backgroundColor = .blue
        layer.cornerRadius = 10
        contentMode = .scaleAspectFill
        image = UIImage(named: "test-image")
        clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
