//
//  ViewController.swift
//  calc
//
//  Created by Ryan Bennett on 2/8/16.
//  Copyright © 2016 bennry01. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var display: UILabel!
    @IBOutlet weak var history: UILabel!
    
    
    
    var isNewEntry = true
    var isErrorState = false
    var decimalEntered = false
    var historyAdding = false
    
    var brain = CalculatorBrain()
    
    
    @IBAction func appendDigit(sender: UIButton) {
        if !isErrorState{
            let digit = sender.currentTitle!
            if digit == "." {
                if !decimalEntered {
                    // Decimal has not yet been entered in this entry
                    if isNewEntry {
                        display.text = "0."
                        isNewEntry = false
                    } else {
                        display.text = display.text! + digit
                    }
                    decimalEntered = true
                }
            } else {
                if isNewEntry {
                    display.text = digit
                    isNewEntry = false
                } else {
                    display.text = display.text! + digit
                }
            }
        }
    }
    
    var operandStack = Array<Double>()
    
    @IBAction func enter() {
        if !isErrorState{
            isNewEntry = true
            decimalEntered = false
            if let result = brain.pushOperand(displayValue!){
                displayValue = result
                if historyAdding {
                    history.text! += ", \(result)"
                } else {
                    history.text! += "\(result)"
                    historyAdding = true
                }
            } else {
                displayValue = 0
            }
        }
    }
    
    var displayValue: Double? {
        get {
            return NSNumberFormatter().numberFromString(display.text!)!.doubleValue
        }
        set{
            if newValue == nil{
                display.text = "Error - Press clear"
                isErrorState = true
            } else {
                display.text = "\(newValue!)"
            }
            isNewEntry = true
        }
    }

    @IBAction func operate(sender: UIButton) {
        if !isNewEntry {
            enter()
        }
        if let operation = sender.currentTitle {
            
            if historyAdding {
                history.text! += ", " + operation
            } else {
                history.text! += operation
                historyAdding = true
            }
            
            
            if operation == "π" {
                displayValue = M_PI
                enter()
            }
            
            if let result = brain.performOperation(operation){
                displayValue = result
            } else {
                displayValue = nil
            }
        }
        
    }
    
    @IBAction func clear() {
        brain.clear()
        displayValue = 0
        isErrorState = false
        historyAdding = false
        history.text = ""
    }
    

}

