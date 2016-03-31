//
//  colorboxTableViewCell.swift
//  colorbox
//
//  Created by Ryan Bennett on 3/29/16.
//  Copyright © 2016 bennry01. All rights reserved.
//

import UIKit

class colorboxTableviewCell: UITableViewCell {
    @IBOutlet weak var colorView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    
    func configure(color: ColorBox){
        titleLabel.text = color.name
        descLabel.text = color.desc
        colorView.backgroundColor = color.color
    }
}
