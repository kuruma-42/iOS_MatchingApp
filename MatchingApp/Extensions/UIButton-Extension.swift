//
//  UIButton-Extension.swift
//  MatchingApp
//
//  Created by Yong Jun Cha on 2021/03/12.
//

import UIKit

extension UIButton {
    
    func createCardInfoButton() -> UIButton {
        
        self.setImage(UIImage(systemName: "info.circle.fill")?.resize(size: .init(width: 40, height: 40)), for: .normal)
        self.tintColor = .white
        self.imageView?.contentMode = .scaleAspectFit
        return self
    }
    
    func createAboutAccount(text: String) -> UIButton {
        self.titleLabel?.font = .systemFont(ofSize: 14)
        self.setTitle(text, for: .normal)
        return self
    }
}
