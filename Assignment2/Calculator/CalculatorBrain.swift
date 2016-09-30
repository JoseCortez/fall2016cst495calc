//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by Jose Cortez on 9/9/16.
//  Copyright (c) 2016 Jose Cortez. All rights reserved.
//

import Foundation

class CalculatorBrain
{
    private enum Op: Printable{
        
        case Operand(Double)
        case UnaryOperation(String, (Double) -> Double)
        case BinaryOperation(String, (Double, Double) -> Double)
        case Variable(String)
        var description: String {
            get {
                switch self {
                case .Operand(let operand):
                    return "\(operand)"
                case .UnaryOperation(let symbol, _):
                    return symbol
                case .BinaryOperation(let symbol, _):
                    return symbol
                case .Variable(let symbol):
                    return symbol
                }
            }
        }
    }
    
    private var opStack = [Op]()
    
    private var knownOps = [String:Op]()
    init() {
        
        knownOps["✖️"] = Op.BinaryOperation("x", *)
        knownOps["➗"] = Op.BinaryOperation("÷") {$1/$0}
        knownOps["➕"] = Op.BinaryOperation("+", +)
        knownOps["➖"] = Op.BinaryOperation("-") {$1 - $0}
        knownOps["√"] = Op.UnaryOperation("√", sqrt)
        knownOps["COS"] = Op.UnaryOperation("cos", cos)
        knownOps["SIN"] = Op.UnaryOperation("sin", sin)
    
        
    }
    
    private func evaluate(ops: [Op]) -> (result: Double?, remainingOps: [Op])
    {
        if !ops.isEmpty {
            var remainingOps = ops
            let op = remainingOps.removeLast()
            switch op {
            case .Operand(let operand):
                return (operand, remainingOps)
            case .UnaryOperation(_, let operation):
                let operandEvaluation = evaluate(remainingOps)
                if let operand = operandEvaluation.result {
                    return (operation(operand), operandEvaluation.remainingOps)
                
                }
            case .BinaryOperation(_, let operation):
                let op1Evaluation = evaluate(remainingOps)
                if let operand1 = op1Evaluation.result {
                    let op2Evaluation = evaluate(op1Evaluation.remainingOps)
                    if let operand2 = op2Evaluation.result {
                        return (operation(operand1, operand2), op2Evaluation.remainingOps)
                    }
        
                }
            case .Variable(let operand):
                if let variableValue = variableValues[operand] {
                    return (variableValue, remainingOps)
                }
                return (nil, remainingOps)
            }
        }
         return (nil, ops)
    }
    func clearVariables()
    {
        variableValues = [:]
    }
    
    var variableValues = [String:Double]()
    
    func evaluate() -> Double? {
        let (result, remainder) = evaluate(opStack)
        println("\(opStack) = \(result) with \(remainder) left over")
        return result
    }
    func pushOperand(symbol: String) -> Double?{
        
        opStack.append(Op.Variable(symbol))
        return evaluate()
    }
    
    func pushOperand(operand: Double) -> Double?{
        opStack.append(Op.Operand(operand))
        return evaluate()
    }
    
    func performOperation(symbol: String) -> Double?{
        if let operation = knownOps[symbol]{
            opStack.append(operation)
        }
         return evaluate()
    }
}