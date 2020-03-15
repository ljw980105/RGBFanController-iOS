//
//  UIColor+RGBColor.swift
//  RGBController
//
//  Created by Jing Wei Li on 3/15/20.
//  Copyright © 2020 Jing Wei Li. All rights reserved.
//

import UIKit

extension UIColor {
    convenience init(rgbColor: RGBColor) {
        self.init(
            red: CGFloat(rgbColor.r) / 255.0,
            green: CGFloat(rgbColor.g) / 255.0,
            blue: CGFloat(rgbColor.b) / 255.0,
            alpha: 1)
    }
}
