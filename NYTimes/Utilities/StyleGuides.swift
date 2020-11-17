//
//  StyleGuides.swift
//  NYTimes
//
//  Created by Apple on 17/11/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit

extension UIColor {
    static var navBarColor: UIColor {
        return UIColor(red: 0.2760736346, green: 0.8880123496, blue: 0.7466617227, alpha: 1)
    }
    
    func with(alpha: CGFloat) {
        self.withAlphaComponent(alpha)
    }
}

extension UIFont {
    static var titleFont: UIFont {
        return UIFont.systemFont(ofSize: 17, weight: .semibold)
    }
}
