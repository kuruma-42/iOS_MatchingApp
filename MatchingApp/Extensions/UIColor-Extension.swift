//
//  UIColor-Extension.swift
//  MatchingApp
//
//  Created by Yong Jun Cha on 2021/03/12.
//

import UIKit

extension UIColor {
    static func rgb(red : CGFloat, green : CGFloat, blue : CGFloat, alpha : CGFloat = 1) -> UIColor {
        return .init(red: red / 255, green: green / 255 , blue: blue / 255, alpha: alpha)
    }
}
