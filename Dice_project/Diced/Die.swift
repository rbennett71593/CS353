//
//  Die.swift
//  Diced
//
//  Created by Ryan Bennett on 2/18/16.
//  Copyright © 2016 bennry01. All rights reserved.
//

import Foundation


class Die {
    private var numSides: Int
    private var values = [String]()
    private var frozen: Bool
    private var currentValue: String
    
    init(possibleValues: [String]){
        numSides = possibleValues.count
        values = possibleValues
        frozen = false
        currentValue = values[0]
    }
    
    func roll() -> String {
        if !frozen{
            currentValue = values[Int(arc4random_uniform(UInt32(numSides)))]
        }
        return currentValue
        
    }
    
    func freeze(f: Bool) {
        if f {
            frozen = true
        } else {
            frozen = false
        }
    }
    func isFrozen() -> Bool {
        return frozen
    }
    
    var value: String {
        get {
            return currentValue
        }
        set {
            currentValue = newValue
        }
    }
}