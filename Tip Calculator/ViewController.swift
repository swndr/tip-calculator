//
//  ViewController.swift
//  Tip Calculator
//
//  Created by Sam Wander on 10/7/15.
//  Copyright © 2015 Sam Wander. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tipControl: UISegmentedControl!
    
    @IBOutlet var swipeOnBill: UISwipeGestureRecognizer!
    
    @IBOutlet weak var billField: UITextField!
    
    @IBOutlet weak var tipLabel: UILabel!
    
    @IBOutlet weak var totalLabel: UILabel!

    var billAmount = 0.0 // declared as global
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let border = CALayer()
        let width = CGFloat(1.0)
        border.borderColor = UIColor.lightGrayColor().CGColor
        border.frame = CGRect(x: 0, y: billField.frame.size.height - width, width:  billField.frame.size.width, height: billField.frame.size.height)
        
        border.borderWidth = width
        billField.layer.addSublayer(border)
        billField.layer.masksToBounds = true
        
        billField.becomeFirstResponder()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onEditingChanged(sender: AnyObject) {
        
        var tipPercentages = [0.18,0.2,0.22]
        var tipPercentage = tipPercentages[tipControl.selectedSegmentIndex]
        
        billAmount = NSString(string: billField.text!).doubleValue
        var tip = billAmount * tipPercentage
        var total = billAmount + tip
        
        tipLabel.text = String(format: "$%.2f", tip)
        totalLabel.text = String(format: "$%.2f", total)
    }
    
    @IBAction func onTap(sender: AnyObject) {
        //view.endEditing(true) // keep keyboard up
    }


    @IBAction func onSwipeLeft(sender: AnyObject) {
        billField.text = ""
        onEditingChanged(swipeOnBill)
    }
    
}

