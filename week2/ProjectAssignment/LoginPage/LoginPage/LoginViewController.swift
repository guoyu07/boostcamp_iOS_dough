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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        idTextField.delegate = self
        passwordTextField.delegate = self
    }
    
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
        
//        guard let signUpViewController = self.storyboard?.instantiateViewController(withIdentifier: "signUpViewController") as? SignUpViewController else { return }
//        self.present(signUpViewController, animated: true, completion: nil)
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

