//
//  CardInfoLabel.swift
//  MatchingApp
//
//  Created by Yong Jun Cha on 2021/03/12.
//

import UIKit

class CardInfoLabel: UILabel {
    
    // nope, good label
    init(text : String, textColor : UIColor) {
        super.init(frame: .zero)
        
        font = .boldSystemFont(ofSize: 45)
        self.text = text
        self.textColor = textColor
        
        layer.borderWidth = 3
        layer.borderColor = textColor.cgColor
        layer.cornerRadius = 10
        
        textAlignment = .center
        alpha = 0
    }
    
    //ETC label
    init(text: String, font: UIFont) {
        super.init(frame: .zero)
        self.font = font
        textColor = .white
        self.text = text
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
