//
//  ViewController.swift
//  locatioNumerals
//
//  Created by Jason Casillas on 7/5/16.
//  Copyright © 2016 TWNH. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var convertedValueLabel: UILabel!
    @IBOutlet weak var abbreviatedValueLabel: UILabel!

    let locationNumeralConverter = LocationNumeralConverter()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func editingChangedForInitialValueTextField(sender: UITextField) {
        if let initialValue = sender.text {
            if !initialValue.isEmpty {
                runConversionsForValue(initialValue)
                return
            }
        }

        convertedValueLabel.text = ""
        abbreviatedValueLabel.text = ""
    }

    func runConversionsForValue(initialValue:String) {
        if initialValue.onlyContainsNumericValues() {
            let initialInteger:Int! = Int(initialValue)
            let currentSlowdownValue = 99999999999
            if initialInteger <= currentSlowdownValue {
                let locationNumeral = locationNumeralConverter.convertIntegerToLocationNumeral(initialInteger)
                convertedValueLabel.text = locationNumeral
            } else {
                convertedValueLabel.text = "Numbers larger than \(currentSlowdownValue) take too long to convert and don't fit on the screen. We could perform the calculation on a background process, animate the fact that it is processing, and put the end result on a scrollview, but this is just a sample app..."
            }
            abbreviatedValueLabel.text = ""
        } else if initialValue.onlyContainsAlphabeticalValues() {
            let initialLocationNumeral = initialValue
            let integerValue = locationNumeralConverter.convertLocationNumeralToInteger(initialLocationNumeral)
            let abbreviatedLocationNumeral = locationNumeralConverter.abbreviatedLocationNumeral(initialLocationNumeral)

            convertedValueLabel.text = String(integerValue)
            if abbreviatedLocationNumeral != initialLocationNumeral {
                abbreviatedValueLabel.text = abbreviatedLocationNumeral
            } else {
                abbreviatedValueLabel.text = ""
            }
        } else {
            convertedValueLabel.text = "We can only convert positive integers or location numerals."
        }
    }
}

