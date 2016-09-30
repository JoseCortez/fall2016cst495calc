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
    
    @IBOutlet weak var history: UILabel!
    
    var userIsInTheMiddleOfTypingANumber: Bool = false
    
    var brain = CalculatorBrain()  //assignment 2
    
    @IBAction func appendDigit(sender: UIButton) {
        let digit = sender.currentTitle!
        
        if digit == "․" && display.text!.rangeOfString(".") != nil {  //assignment 2
            return;
        }
        
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
        history.text = "History";
        display.text = "0"
        brain.clearVariables()
        
    }
//    func performOperation2(operation: Double -> Double){
//        if operandStack.count >= 1{
//            displayValue = operation(operandStack.removeLast())
//            enter()
//        }
//    }

    @IBAction func pi(sender: UIButton) {
        userIsInTheMiddleOfTypingANumber = true
        if display.text == "0"
        {
            display.text = "\(M_PI)"
            enter()
        }
        else{
            display.text = "\(M_PI)"
            enter()
        }
    }
    
    @IBAction func enter() {
        userIsInTheMiddleOfTypingANumber = false
        history.text = history.text! + "," +  "\(displayValue!)"
        //operandStack.append(displayValue)
        if let result = brain.pushOperand(displayValue!){
            displayValue = result
        }else{
            
            displayValue = nil;
        }

    }
    //var operandStack: Array<Double> = Array<Double>() //assignment 1
    
    @IBAction func operate(sender: UIButton) {
        //let operation = sender.currentTitle!    //assignment 1
        
        if let operation = sender.currentTitle   //assignment 2
        {
            if userIsInTheMiddleOfTypingANumber && operation != "→M"
            {
                enter()
            }
            if operation == "→M" {
                brain.variableValues["M"] = displayValue
                userIsInTheMiddleOfTypingANumber = false
            }
            if operation == "M" {
                brain.pushOperand(operation)
            }
            
            if let result = brain.performOperation(operation) {
                displayValue = result
            } else {
                displayValue = nil
            }
        }
        
            
    }
    
    //var displayVAlue: Double?


    var displayValue: Double?{
        get{
            return NSNumberFormatter().numberFromString(display.text!)!.doubleValue
        }
        set{
            display.text = "\(newValue!)"
            //userIsInTheMiddleOfTypingANumber = true
            
        }
    }
}

