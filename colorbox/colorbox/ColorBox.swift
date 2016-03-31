//
//  ColorBox.swift
//  colorbox
//
//  Created by Ryan Bennett on 3/29/16.
//  Copyright © 2016 bennry01. All rights reserved.
//

import Foundation
import UIKit

struct ColorBox {
    let name: String
    let desc: String
    let color: UIColor
    
    init?(json: Dictionary<String, AnyObject>) {
        guard let name = json["name"] as? String else {
            return nil
        }
        self.name = name
        
        guard let colors = json["rbg"] as? [Int] where colors.count == 3 else {
            return nil
        }
        let color = UIColor(red: CGFloat(colors[0])/255, green: CGFloat(colors[1])/255, blue: CGFloat(colors[2])/255, alpha: 1)
        self.color = color
    
        if let desc = json["description"] as? String {
            self.desc = desc
        } else {
            self.desc = ""
        }

    }
}