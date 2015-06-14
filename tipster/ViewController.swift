//
//  ViewController.swift
//  tipster
//
//  Created by Brian Schmitz on 6/11/15.
//  Copyright (c) 2015 Brian Schmitz. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var totalBill: UILabel!
    @IBOutlet weak var lowestRate: UILabel!
    @IBOutlet weak var lowRate: UILabel!
    @IBOutlet weak var middlelowRate: UILabel!
    @IBOutlet weak var middlehighRate: UILabel!
    @IBOutlet weak var highlowRate: UILabel!
    @IBOutlet weak var highestRate: UILabel!
    @IBOutlet weak var tipSlider: UISlider!
    @IBOutlet weak var groupSizeSlider: UISlider!
    @IBOutlet weak var lowtipper: UILabel!
    @IBOutlet weak var middletip: UILabel!
    @IBOutlet weak var hightipper: UILabel!
    @IBOutlet weak var groupSize: UILabel!
    
    
    //we declare all initial variables here
    var finalTotal = 0.0
    var decimalHasBeenPressed = false
    var placesAfterDecimal = 1.0
    var finalStringCalculation = ""
    var lowTip = 0.0
    var midTip = 0.0
    var highTip = 0.0
    var lowCost = 0.0
    var midCost = 0.0
    var highCost = 0.0
    var selectedRate = 5
    var selectedRate2 = 10
    var selectedRate3 = 20
    var group = 2
    
    //our function to update the varables as they should be shown on the screen
    func total () {
        //we respond to the group size slider at the bottom of the page here, we rewrite group size and then concat on the group variable based on the slider value we get back
        var name = "Group Size "
        groupSize.text = name + String(stringInterpolationSegment: group)
        println(groupSize.text)
        
        //this takes the info from our calcButtonPressed function below and determines how to display the string onto the page, whether the decimalButton has been pressed and the number of places after the decimal point at the current button press each cycle
        if (decimalHasBeenPressed && placesAfterDecimal != 1.0){
            finalStringCalculation = String(stringInterpolationSegment: finalTotal)
//            println("inside")
//            println(finalStringCalculation)
        } else {
           finalStringCalculation = String(stringInterpolationSegment: Int(finalTotal))
//            println("various")
//            println(finalStringCalculation)
        }
        println(finalStringCalculation)
        
        //displays the final bill that we enetered
        totalBill.text = "$" + finalStringCalculation
        
        //set the low tip value based on the final total typed in * the rate we set above in our initial varibles and then dividing by 100 and then by the group size we get from the scroll
        lowTip = (Double(finalTotal) * Double(selectedRate) / 100 / Double(group))
        midTip = (Double(finalTotal) * Double(selectedRate2) / 100 / Double(group))
        highTip = (Double(finalTotal) * Double(selectedRate3) / 100 / Double(group))
        
        //this writes to the page based on our tip values from above
        lowestRate.text = "$" + String(format: "%.02f", lowTip)
        middlelowRate.text = "$" + String(format: "%.02f",  midTip)
        highlowRate.text = "$" + String(format:"%.02f",  highTip)
        
        //this sets the variable for the final costs based on the final bill + the tip cost we get above
        lowCost = Double(finalTotal) + Double(lowTip * 2)
        midCost = Double(finalTotal) + Double(midTip * 2)
        highCost = Double(finalTotal) + Double(highTip * 2)
        
        //this writes the values to the page that we get above from our final cost variables
        lowRate.text = "$" + String(format: "%.02f", lowCost)
        middlehighRate.text = "$" + String(format: "%.02f", midCost)
        highestRate.text = "$" + String(format: "%.02f", highCost)
        middletip.text = String(selectedRate2) + "%"
        lowtipper.text = String(selectedRate) + "%"
        hightipper.text = String(selectedRate3) + "%"
    }
    
    //we are setting initial values upon page load here
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
         totalBill.text = "$" + String(stringInterpolationSegment: 0)
         lowestRate.text = "$" + String(stringInterpolationSegment: 0)
         middlelowRate.text = "$" + String(stringInterpolationSegment: 0)
         highlowRate.text = "$" + String(stringInterpolationSegment: 0)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //this runs on each button press, the "c" button has a sender.tag of 10, if this is pressed we change our intial value of decimalButtonPressed to true, if decimalButtonPressed is false then we run the else and multiply each number by 10 and add on the sender.tag value of each button. We can go into the second else statement if the decimalHasBeenPressed is true, then we restrict the number of decimals to be less than 3.
    @IBAction func calcButtonPressed(sender: UIButton) {
        if sender.tag == 10 {
            println("hey")
            if decimalHasBeenPressed == false {
            decimalHasBeenPressed = true
            }
        } else{
            if !decimalHasBeenPressed {
                println("hey")
                finalTotal *= 10
                finalTotal = finalTotal + Double(sender.tag)
                println(finalTotal)
            } else {
                if placesAfterDecimal < 3.0 {
                    finalTotal = finalTotal +  Double(sender.tag) / pow(10.0, placesAfterDecimal)
                    println(finalTotal)
                    ++placesAfterDecimal
                }
            }
        }
    total()
        
    }
    
    //command shift k - starts over your build from zero, starts with a clean build
    
   
    
    //this clears the claculator, giving us a total bill of $0 and resetting the decimal place to false, and places after decimal to its iniital value, and then runs the total funciton to recalcualte on the page
    @IBAction func clearButtonPressed(sender: UIButton) {
        finalTotal = 0.0
        decimalHasBeenPressed = false
        placesAfterDecimal  = 1.0
        total()
    }
    
    
    //we respond to the tip slider number and store that value in the three different rate options. We take the result from the slider (0-1) and multiply by 20 which gives us a value between 1 and 20 and then we add 10 to get a number between 10 and 30. This is for the middle value, to get the lower and upper values we subtract and add 5 basaed on the value of the middle percentage.
    @IBAction func tipSlider(sender: UISlider) {
        selectedRate2 = Int(round(Double(sender.value) * Double(20) + Double(10)))
        selectedRate = selectedRate2 - 5
        selectedRate3 = selectedRate2 + 5
            println(selectedRate2)
            total()
    }
    
    
    //this responds to the group size slider, we store the value from the slider (which is 0-1) and then multiply by 4 and add 1 to get a group size of 1-5. We store that number in group and the call the total function where we display to the screen
    @IBAction func groupSize(sender: UISlider) {
        group = Int(round(Double(sender.value) * Double(4)) + 1)
        total()
//        println(group)
    }

    
    
}

