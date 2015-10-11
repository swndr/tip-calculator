//
//  ViewController.swift
//  Tip Calculator
//
//  Created by Sam Wander on 10/7/15.
//  Copyright © 2015 Sam Wander. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tipSlider: UISlider!
    @IBOutlet var swipeOnBill: UISwipeGestureRecognizer!
    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var tipPercentageLabel: UILabel!

    var billAmount = 0.0 // declared as global so can access in onSwipeLeft()
    var decimalPlaced = false // if digits entered < 2
    var lastCharCount = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        // Graphically underline text field
        let border = CALayer()
        let width = CGFloat(1.0)
        border.borderColor = UIColor.lightGrayColor().CGColor
        border.frame = CGRect(x: 0, y: billField.frame.size.height - width, width:  billField.frame.size.width, height: billField.frame.size.height)
        border.borderWidth = width
        billField.layer.addSublayer(border)
        billField.layer.masksToBounds = true
        
        // Open keyboard on launch
        billField.becomeFirstResponder()
        
        // Initial tip %
        var sliderValue = Int(self.tipSlider.value)
        tipPercentageLabel.text = "Tip @ \(sliderValue)%"
        
        // Set to local currency
        let locale = NSLocale.currentLocale()
        let currencySymbol = locale.objectForKey(NSLocaleCurrencySymbol)
        billField.placeholder = "\(currencySymbol!)"
        tipLabel.text = "\(currencySymbol!)"
        totalLabel.text = "\(currencySymbol!)"
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onEditingChanged(sender: AnyObject) {
        
        // Cast slider value
        var sliderValue = Int(self.tipSlider.value)
        // Display tip %
        tipPercentageLabel.text = "Tip @ \(sliderValue)%"
        
        // Set to local currency
        let locale = NSLocale.currentLocale()
        let currencySymbol = locale.objectForKey(NSLocaleCurrencySymbol)
        
        // Const char for decimal point
        let decimal: Character = "."
        // Number of digits entered
        var digitsCount = billField.text!.characters.count
        
        // If backspaced, delete all
        if digitsCount < lastCharCount {
            billField.text!.removeAll()
            decimalPlaced = false
        } else if digitsCount > 2 {  // if more than 2 digits, and haven't yet, add decimal
            if decimalPlaced == false  {
                decimalPlaced = true
                billField.text?.insert(decimal, atIndex: billField.text!.endIndex.advancedBy(-2))
            }
            
            // If decimal isn't at 3rd place from end, move there
            if let decimalPos = billField.text!.characters.indexOf(decimal) {
                if decimalPos != billField.text!.endIndex.advancedBy(-3) {
                    billField.text!.removeAtIndex(billField.text!.endIndex.advancedBy(-4))
                    billField.text!.insert(decimal, atIndex: billField.text!.endIndex.advancedBy(-2))
                }
            }

            // Constrain length to max 999.99
            if digitsCount == 7 {
               billField.text!.removeAtIndex(billField.text!.startIndex)
            }
        }
        
        lastCharCount = digitsCount
        
        // Convert to double
        billAmount = NSString(string: billField.text!).doubleValue
        if decimalPlaced == false {
            billAmount = billAmount/100
        }
        
        var tip = billAmount * (Double(sliderValue)/100)
        var total = billAmount + tip
        
        tipLabel.text = String(format: "\(currencySymbol!) %.2f", tip)
        totalLabel.text = String(format: "\(currencySymbol!) %.2f", total)
    }
    
    @IBAction func onTap(sender: AnyObject) {
        //view.endEditing(true) // commented out to keep keyboard up permanently
    }


    @IBAction func onSwipeLeft(sender: AnyObject) {
        // Clear bill amount
        billField.text!.removeAll()
        decimalPlaced = false
        onEditingChanged(swipeOnBill)
    }
    
}

