//
//  ViewController.swift
//  Calculator
//
//  Created by Jose Cortez on 9/2/16.
//  Copyright (c) 2016 Jose Cortez. All rights reserved.
//


//testing branch
import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var display: UILabel!
    
    var userIsInTheMiddleOfTypingANumber: Bool = false
    
    //var brain = CalculatorBrain()  //assignment 2
    
    @IBAction func appendDigit(sender: UIButton) {
        let digit = sender.currentTitle!
        
//        if digit == "․" && display.text!.rangeOfString(".") != nil {  //assignment 2
//            return;
//        }
        
        if userIsInTheMiddleOfTypingANumber {
            display.text = display.text! + digit
        }
        else
        {
            display.text = digit
            userIsInTheMiddleOfTypingANumber = true
            
        }
        //println("Digit = \(digit)")
    }
    
    @IBAction func Clear() {      //assignment 1
        operandStack.removeAll()
        display.text = ""
        
    }
    var operandStack: Array<Double> = Array<Double>() //assignment 1
    
    @IBAction func operate(sender: UIButton) {
        let operation = sender.currentTitle!    //assignment 1
        if userIsInTheMiddleOfTypingANumber
        {
            enter()
        }
//        if let operation = sender.currentTitle   //assignment 2
//        {
//            if let result = brain.performOperation(operation) {
//                displayValue = result
//            } else {
//                displayValue = 0
//            }
//        }
        
        
        switch operation{                         //assignment 1
        case "✖️": performOperation { $0 * $1 }
        case "➕": performOperation { $0 + $1 }
        case "➖": performOperation { $1 - $0 }
        case "➗": performOperation { $1 / $0 }
        case "√": performOperation { sqrt($0) }
        case "SIN": performOperation { sin($0) }
        case "COS": performOperation { cos($0) }
        case "π": performOperation { $0 * M_PI }
        default: break
            
            
        }
    }
    
    @IBAction func enter() {
        userIsInTheMiddleOfTypingANumber = false
        operandStack.append(displayValue) //assignment 1
//        if let result = brain.pushOperand(displayValue)   //assignment 2
//        {
//            displayValue = result
//        }
//        else
//        {
//            displayValue = 0
//        }
        
    }
    
    func performOperation(operation: (Double, Double) -> Double) {    //assignment 1
        if operandStack.count >= 2 {
            displayValue = operation(operandStack.removeLast(), operandStack.removeLast())
            enter()
        }
    }
    
    func performOperation(operation: Double -> Double) {      //assignment 1
        if operandStack.count >= 1 {
            displayValue = operation(operandStack.removeLast())
            enter()
        }
    }
    
    var displayValue: Double{
        get{
            return NSNumberFormatter().numberFromString(display.text!)!.doubleValue
        }
        set{
            display.text = "\(newValue)"
            //userIsInTheMiddleOfTypingANumber = true
            
        }
    }
}

