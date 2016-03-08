//
//  CalcBrain.swift
//  calc
//
//  Created by Ryan Bennett on 2/16/16.
//  Copyright © 2016 bennry01. All rights reserved.
//

import Foundation

class CalculatorBrain {
    
    private enum Op: CustomStringConvertible{
        case Operand(Double)
        case UnaryOperation(String, Double -> Double)
        case BinaryOperation(String, Int, (Double, Double)->Double)
        case ConstantOperation(String, () -> Double)
        case Variable(String)
        
        var description: String {
            get {
                switch self {
                case .Operand(let operand):
                    return "\(operand)"
                case .UnaryOperation(let symbol, _):
                    return symbol
                case .BinaryOperation(let symbol, _, _):
                    return symbol
                case .ConstantOperation(let symbol, _):
                    return symbol
                case .Variable(let variable):
                    return variable
                }
            }
        }
        
        var orderOfOperations: Int {
            // Property to help determine what order of operations priority this operation has
            get {
                switch self {
                case .BinaryOperation(_, let orderOfOperations, _):
                    // only binary operations have order right now
                    // do any unary operations have order? I don't think so...
                    // if they do, then they're probably first priority
                    return orderOfOperations
                default:
                    return Int.max
                }
            }
        }
        
    }
    
    // var opStack = Array<Op>()
    private var opStack = [Op]()
    
    //var knownOps = Dictionary<String, Op>()
    private var knownOps = [String:Op]()
    
    var variableValues = Dictionary<String, Double>()
    
    
    init(){
        func learnOp(op: Op){
            knownOps[op.description] = op
        }
        learnOp(Op.BinaryOperation("X", 2) {$1 * $0})
        learnOp(Op.BinaryOperation("/", 2) {$1 / $0})
        learnOp(Op.BinaryOperation("+", 1) {$1 + $0})
        learnOp(Op.BinaryOperation("-", 1) {$1 - $0})
        learnOp(Op.UnaryOperation("sqrt",sqrt))
        learnOp(Op.UnaryOperation("cos", cos))
        learnOp(Op.UnaryOperation("sin",sin))
        learnOp(Op.ConstantOperation("π", { M_PI }))
    }
    
    
    private func evaluate(ops:[Op]) -> (result: Double?, remainingOps:[Op]){
        if !ops.isEmpty {
            var remainingOps = ops
            let op = remainingOps.removeLast()
            
            switch  op {
            case .Operand(let operand):
               return (operand, remainingOps)
                
            case .UnaryOperation(_, let operation):
                let operandEvaluation = evaluate(remainingOps)
                if let operand = operandEvaluation.result{
                    return (operation(operand), operandEvaluation.remainingOps)
                }
            case .BinaryOperation(_, _, let operation):
                let op1Evaluation = evaluate(remainingOps)
                if let operand1 = op1Evaluation.result {
                    let op2Evaluation = evaluate(op1Evaluation.remainingOps)
                    if let operand2 = op2Evaluation.result {
                        return (operation(operand1, operand2), op2Evaluation.remainingOps)
                    }
                }
            case .ConstantOperation(_, let operation):
                return (operation(), remainingOps)
                
            case .Variable(let variable):
                if let value = variableValues[variable]{
                    return (value, remainingOps)
                }
                return (nil, remainingOps)
            }
        
        }
        return (nil, ops)
    }
    
    func evaluate() -> Double? {
        let (result, _) = evaluate(opStack)
        //let (result, remainder) = evaluate(opStack)
        //print("\(opStack)=\(result) with \(remainder) left over")
        return result
    }
    
    func pushOperand(operand: Double) -> Double? {
        opStack.append(Op.Operand(operand))
        return evaluate()
    }
    
    func pushOperand(symbol: String) -> Double? {
        // For variable support
        opStack.append(Op.Variable(symbol))
        return evaluate()
    }
    
    func performOperation(symbol: String) -> Double?{
        if let operation = knownOps[symbol] {
            opStack.append(operation)
        }
        return evaluate()
    }
    
    func clear() {
        opStack.removeAll()
        variableValues = Dictionary<String, Double>()
    }
    
    func removeLast() -> Double? {
        if(opStack.count > 0){
            opStack.removeLast()
        }
        return evaluate()
    }
    
    var description: String {
        // Hint 7 ---+-
        get {
            var(desc, newOps, _) = opString(opStack)
            while(newOps.count > 0) {
                let (nextDesc, nextOps, _) = opString(newOps)
                desc = nextDesc + ", " + desc
                newOps = nextOps
            }
            
            return desc + " = "
        }
    }
    
    private func opString(var ops: [Op]) -> (String, [Op], Int){
        // look at operate() for guidance
        if !ops.isEmpty {
            let currentOp = ops.removeLast()
            switch currentOp {
            case .Operand(let operand):
                return (operand.description, ops, currentOp.orderOfOperations)
            
            case .UnaryOperation(let symbol, _):
                let (operandString,ops, _) = opString(ops)
                return (symbol + "(" + operandString + ")", ops, currentOp.orderOfOperations)
            
            case .BinaryOperation(let symbol, let ordOfOps, _):
                var (op1String,remainingOps1, ordOfOps1) = opString(ops)
                var (op2String,remainingOps2, ordOfOps2) = opString(remainingOps1)
                // Order of operations priority parenthesis
                if(ordOfOps > ordOfOps1) {
                    op1String = "(" + op1String + ")"
                }
                if(ordOfOps > ordOfOps2) {
                    op2String =  "(" + op2String + ")"
                }
                return (op2String + symbol + op1String, remainingOps2, ordOfOps)
            
            case .ConstantOperation(let symbol, _):
                return (symbol, ops, currentOp.orderOfOperations)
                
            case .Variable(let variable):
                // return the variable name (string)
                return (variable, ops, currentOp.orderOfOperations)
                
            }
            
        }
        return ("", ops, Int.max)
    }
    
}
