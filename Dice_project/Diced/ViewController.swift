//
//  ViewController.swift
//  Diced
//
//  Created by Ryan Bennett on 2/18/16.
//  Copyright © 2016 bennry01. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var dice = [Die]()
    var cupFilled = false
    
    @IBOutlet var dicons: [UIButton]!
    
    func fillCup(count: Int){
        for _ in 1...count{
            dice.append(Die(possibleValues:["⚀", "⚁", "⚂", "⚃", "⚄", "⚅"]))
        }
    }
    
    @IBAction func roll() {
        if !cupFilled {
            fillCup(5)
        }
        for d in dice{
            d.roll()
        }
        for di in dicons{
            di.setTitle(dice[di.tag].value, forState:UIControlState.Normal)
        }
    }
    
    @IBAction func dieTouch(sender: UIButton) {
        if dice[sender.tag].isFrozen() {
            dice[sender.tag].freeze(false)
            sender.setTitleColor(UIColor.blueColor(), forState: .Normal)
        } else {
            dice[sender.tag].freeze(true)
            sender.setTitleColor(UIColor.redColor(), forState: .Normal)
        }
        
    }
    
    


}

