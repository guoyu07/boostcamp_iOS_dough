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
        guard let fahrenheitFromText = textField.text,
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
        // textField에 알파벳과 복수의 소수점 입력 방지
        if string.rangeOfCharacter(from: CharacterSet.letters) != nil || (textField.text?.range(of: ".") != nil && string.range(of: ".") != nil) {
            return false
        } else {
            return true
        }
    }
    
    // MARK: Methods
    override func viewDidLoad() {
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
