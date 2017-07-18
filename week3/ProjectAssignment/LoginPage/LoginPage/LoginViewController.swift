//
//  ViewController.swift
//  LoginPage
//
//  Created by Kangsoo on 03/07/2017.
//  Copyright © 2017 Dough. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var mybutton: MyButton!
    
    var isAble: Bool = true
    
    @IBAction func signInButton(_ sender: UIButton) {
        print("touch up inside - sign in")
        
        guard let id = idTextField.text, !id.isEmpty else {
            print("ID is empty.")
            return
        }
        guard let password = passwordTextField.text, !password.isEmpty else {
            print("Password is empty")
            return
        }
        
        let tempMember = Member()
        tempMember.id = id
        tempMember.password = password
        tempMember.printIDPassword()
    }
    
    @IBAction func signUpButton(_ sender: UIButton) {
        print("touch up inside - sign up")
    }
    
    @IBAction func switchButtonTouched(_ sender: UIButton) {
        let currentControlState = mybutton.controlState
        
        if isAble {
            switch currentControlState {
            case UIControlState.normal:
                mybutton.controlState = [.normal, .disabled]
            case UIControlState.selected:
                mybutton.controlState = [.selected, .disabled]
            default:
                print("Error is occured at switchButtonTouched.")
                print("Is able to touch my button? \(isAble)")
                print("Current control state: \(currentControlState)")
                return
            }
            
            mybutton.imageView.alpha = 0.5
            sender.setTitle("Enable the button", for: .normal)
            
            isAble = false
        } else {
            switch currentControlState {
            case [.normal, .disabled]:
                mybutton.controlState = .normal
            case [.selected, .disabled]:
                mybutton.controlState = .selected
            default:
                print("Error is occured at switchButtonTouched.")
                print("Is able to touch my button? \(isAble)")
                print("Current control state: \(currentControlState)")
                return
            }
            
            mybutton.imageView.alpha = 1.0
            sender.setTitle("Disable the button", for: .normal)
            
            isAble = true
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        idTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    // MARK: UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == idTextField {
            passwordTextField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return true
    }
    
    // MARK: UIResponder
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // Hide keyboard when view is touched
        self.view.endEditing(true)
    }
}

