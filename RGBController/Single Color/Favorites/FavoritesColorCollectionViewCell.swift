//
//  FavoritesColorCollectionViewCell.swift
//  RGBController
//
//  Created by Jing Wei Li on 3/14/20.
//  Copyright © 2020 Jing Wei Li. All rights reserved.
//

import UIKit

class FavoritesColorCollectionViewCell: UICollectionViewCell {
    static let identifier = "colorCell"
    @IBOutlet weak var colorView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setColor(_ color: UIColor) {
        let width = (bounds.size.width - 18) / 2
        colorView.clipsToBounds = true
        colorView.layer.cornerRadius = width
        colorView.backgroundColor = color
        colorView.layer.borderColor = UIColor.gray.cgColor
        colorView.layer.borderWidth = 0.5
    }

}
