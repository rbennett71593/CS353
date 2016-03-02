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
    
    
    @IBAction func backspace() {
        if !isNewEntry {
            if display.text!.characters.count > 0 {
                var text = display.text!
                text = String(text.characters.dropLast()) // I don't know why this has to be written with String(..) around it, but that's what stack overflow says... Figure out what this means sometime.
                if display.text!.characters.count > 0 {
                    display.text = text
                } else {
                    display.text = "0"
                }
            }
        } else {
            if let result = brain.removeLast() {
                displayValue = result
            } else {
                displayValue = 0
            }
            history.text = historyValue
        }
    }
    
    @IBAction func storeVar() {
        if let value = displayValue {
            brain.variableValues["M"] = value
        }
        isNewEntry = true
        if let result = brain.evaluate() {
            displayValue = result
        } else {
            displayValue = nil
        }
        history.text = historyValue
    }
    
    @IBAction func retrieveVar() {
        if let value = brain.pushOperand("M") {
            displayValue = value
        } else {
            displayValue = nil
        }

        history.text = historyValue
    }
    
    
    
    
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
        history.text = historyValue
    }
    
    var operandStack = Array<Double>()
    
    @IBAction func enter() {
        if !isErrorState{
            isNewEntry = true
            decimalEntered = false
            if let result = brain.pushOperand(displayValue!){
                displayValue = result
                
//                if historyAdding {
//                    history.text! += ", \(result)"
//                } else {
//                    history.text! += "\(result)"
//                    historyAdding = true
//                }
            } else {
                displayValue = 0
            }
            history.text = historyValue
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
    var historyValue: String {
        get{
            return brain.description
        }
    }

    @IBAction func operate(sender: UIButton) {
        if !isNewEntry {
            enter()
        }
        if let operation = sender.currentTitle {
//            
//            if historyAdding {
//                history.text! += ", " + operation
//            } else {
//                history.text! += operation
//                historyAdding = true
//            }
            
            
//            if operation == "π" {
//                displayValue = M_PI
//                enter()
//            }
            
            if let result = brain.performOperation(operation){
                displayValue = result
            } else {
                displayValue = nil
            }
        }
        history.text = historyValue
        
    }
    
    @IBAction func clear() {
        brain.clear()
        displayValue = 0
        isErrorState = false
//        historyAdding = false
        history.text = "="
    }
    

}

