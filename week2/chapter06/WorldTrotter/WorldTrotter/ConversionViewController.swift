//
//  ConversionViewController.swift
//  WorldTrotter
//
//  Created by Kangsoo on 05/07/2017.
//  Copyright © 2017 Dough. All rights reserved.
//

import UIKit

class ConversionViewController: UIViewController, UITextFieldDelegate {
    
    // MARK: IBOutlets
    @IBOutlet var fahrenheitTextField: UITextField!
    @IBOutlet var celsiusLabel: UILabel!
    
    // MARK: Properties
    var fahrenheitValue: Double? {
        // Property Observer: 프로퍼티 값이 변경될 때마다 아래 코드가 호출된다
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
    
    // MARK: IBActions
    @IBAction func fahrenheitFieldEditingChanged(textField: UITextField) {
        if let fahrenheitFromText = textField.text, let fahrenheitValue = Double(fahrenheitFromText) {
            self.fahrenheitValue = fahrenheitValue
        } else {
            self.fahrenheitValue = nil
        }
    }
    
    @IBAction func dismissKeyboard(sender: AnyObject) {
        fahrenheitTextField.resignFirstResponder()
    }
    
    // MARK: UITextFieldDelegate
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // 기존 문자열
        let existingTextHasDecimalSeparator = textField.text?.range(of: ".") // "."까지의 문자열 or nil
        // 변경 후 추가된 문자열
        let replacementTextHasDecimalSeparator = string.range(of: ".")
        
        if existingTextHasDecimalSeparator != nil && replacementTextHasDecimalSeparator != nil {
            return false // 입력 거부
        } else {
            return true
        }
    }
    
    // MARK: Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("ConversionViewController loaded its view.")
        fahrenheitTextField.delegate = self
        
    }
    
    func updateCelsiusLabel() {
        if let celsiusValue = celsiusValue {
            celsiusLabel.text = numberFormatter.string(from: NSNumber(value: celsiusValue))
        } else {
            celsiusLabel.text = "???"
        }
    }
}
