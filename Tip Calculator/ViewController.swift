//
//  ViewController.swift
//  Tip Calculator
//
//  Created by Rajib Sinha on 1/1/17.
//  Copyright © 2017 Shivan Desai. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    
    @IBOutlet weak var billField: UITextView!
    @IBOutlet weak var tipControl: UISegmentedControl!

    @IBOutlet weak var p2: UILabel!
    @IBOutlet weak var p3: UILabel!
    @IBOutlet weak var p4: UILabel!
    
    @IBOutlet weak var visualEffectView: UIVisualEffectView!
    
    var counter = 0

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBAction func onTap(_ sender: Any) {
        view.endEditing(true)
        
    }
    @IBAction func segChange(_ sender: Any) {
        view.endEditing(true)
    }
    
    func animateOut() {
        UIView.animate(withDuration: 2, animations: {
            self.visualEffectView.effect = nil
        }) { (success:Bool) in
            self.visualEffectView.removeFromSuperview()
        }
    }

    @IBAction func calculateTip(_ sender: AnyObject) {
        
        let defaults = UserDefaults.standard
        let tipPercentages = [0.18, 0.2, 0.25]
        
        let bill = Double(billField.text!) ?? 0
        let tip = bill * tipPercentages[tipControl.selectedSegmentIndex]
        let total = bill + tip

        tipLabel.text = String(format: "$%.2f", tip)
        totalLabel.text = String(format: "$%.2f", total)
        p2.text = String(format: "$%.2f", total / 2)
        p3.text = String(format: "$%.2f", total / 3)
        p4.text = String(format: "$%.2f", total / 4)
        defaults.set(billField.text, forKey: "billField")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("view will appear")
        // This is a good place to retrieve the default tip percentage from UserDefaults
        // and use it to update the tip amount
        let defaults = UserDefaults.standard
        tipControl.selectedSegmentIndex = defaults.integer(forKey: "defaultPercentage")
        let tipPercentage = [0.18, 0.2, 0.25]
        
        billField.text = defaults.string(forKey: "billField") ?? "0"
        
        let bill = Double(billField.text!) ?? 0
        let tip = bill * tipPercentage[tipControl.selectedSegmentIndex]
        let total = bill + tip
        
        tipLabel.text = String(format: "$%.2f", tip)
        totalLabel.text = String(format: "$%.2f", total)
        p2.text = String(format: "$%.2f", total / 2)
        p3.text = String(format: "$%.2f", total / 3)
        p4.text = String(format: "$%.2f", total / 4)
    }
    
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("view did disappear")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if(counter == 0){
            animateOut()
            counter += 1
        }
        billField.becomeFirstResponder()
    }
    
}

