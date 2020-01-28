//
//  UIColor+RGB.swift
//  RGBController
//
//  Created by Jing Wei Li on 1/28/20.
//  Copyright © 2020 Jing Wei Li. All rights reserved.
//

import UIKit

extension UIColor {
    func rgb() -> (r: Int, g: Int, b: Int) {
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        getRed(&r, green: &g, blue: &b, alpha: nil)
        return (Int(r * 255), Int(g * 255), Int(b * 255))
    }
}
