//
//  ColorBox.swift
//  colorbox
//
//  Created by Ryan Bennett on 3/29/16.
//  Copyright © 2016 bennry01. All rights reserved.
//

import Foundation

struct ColorBox {
    let name: String
    let desc: String
    
    init?(json: Dictionary<String, AnyObject>) {
        guard let name = json["name"] as? String else {
            return nil
        }
        self.name = name
        
        guard let desc = json["desc"] as? String else{
            return nil
        }
        self.desc = desc
    }
}