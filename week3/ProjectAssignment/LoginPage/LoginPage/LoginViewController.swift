//
//  LoginViewController.swift
//  LoginPage
//
//  Created by Kangsoo on 03/07/2017.
//  Copyright © 2017 Dough. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var myButton: MyButton!
    
	var isMyButtonWorking: Bool = true
	
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
        
        let tempMember = Member(id: id, password: password)
		print("ID : \(tempMember.id), PW : \(tempMember.password)")
    }
    
    @IBAction func signUpButton(_ sender: UIButton) {
        print("touch up inside - sign up")
    }
    
	@IBAction func switchButtonTouched(_ sender: UIButton) {
		if isMyButtonWorking {
			myButton.isUserInteractionEnabled = false
			myButton.imageView.alpha = 0.5
			sender.setTitle("Enable the button", for: .normal)
			isMyButtonWorking = false
		} else {
			myButton.isUserInteractionEnabled = true
			myButton.imageView.alpha = 1.0
			sender.setTitle("Disable the button", for: .normal)
			isMyButtonWorking = true
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
        self.view.endEditing(true)
    }
}

