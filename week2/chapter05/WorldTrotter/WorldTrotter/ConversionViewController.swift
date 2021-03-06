//
//  ConversionViewController.swift
//  WorldTrotter
//
//  Created by Kangsoo on 05/07/2017.
//  Copyright © 2017 Dough. All rights reserved.
//

import UIKit

class ConversionViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var fahrenheitTextField: UITextField!
    @IBOutlet var celsiusLabel: UILabel!
    
    var fahrenheitValue: Double? {
        didSet {
            updateCelsiusLabel()
        }
    }
    var celsiusValue: Double? {
        if let value = fahrenheitValue {
            return (value - 32) * (5 / 9)
        } else {
            return nil
        }
    }
    
    let numberFormatter: NumberFormatter = {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.minimumFractionDigits = 0
        numberFormatter.maximumFractionDigits = 1
        return numberFormatter
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("ConversionViewController loaded its view.")
        fahrenheitTextField.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        updateBackgroundColorByCurrentHour()
    }
    
    @IBAction func fahrenheitFieldEditingChanged(textField: UITextField) {
        guard
            let fahrenheitFromText = textField.text,
            let fahrenheitValue = Double(fahrenheitFromText) else {
                self.fahrenheitValue = nil
                return
        }
        self.fahrenheitValue = fahrenheitValue
    }
    
    @IBAction func dismissKeyboard(sender: AnyObject) {
        fahrenheitTextField.resignFirstResponder()
    }
    
    // MARK: UITextFieldDelegate
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // 알파벳 입력 방지
        guard string.rangeOfCharacter(from: CharacterSet.letters) == nil else {
            print("Alphabets cannot be entered.")
            return false
        }
        
        // 복수의 소수점 입력 방지
        guard textField.text?.range(of: ".") != nil else {
            return true
        }
        guard string.range(of: ".") != nil else {
            return true
        }
        print("Only one dot can be entered.")
        return false
    }
    
    func updateCelsiusLabel() {
        if let celsiusValue = celsiusValue {
            celsiusLabel.text = numberFormatter.string(from: NSNumber(value: celsiusValue))
        } else {
            celsiusLabel.text = "???"
        }
    }
    
    func updateBackgroundColorByCurrentHour() {
        var colorArray = [UIColor]()
        colorArray.append(UIColor.darkGray)
        colorArray.append(UIColor(red: 245/255, green: 244/255, blue: 241/255, alpha: 1.0))
        
        let currentDate = Date()
        let calendar = Calendar.current
        let currentHour = calendar.component(.hour, from: currentDate)
        
        if (currentHour >= 18 && currentHour <= 23) || (currentHour >= 0 && currentHour <= 5) {
            view.backgroundColor = colorArray[0]
        } else {
            view.backgroundColor = colorArray[1]
        }
    }
    
}
