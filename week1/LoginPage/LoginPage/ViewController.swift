//
//  ViewController.swift
//  LoginPage
//
//  Created by Kangsoo on 03/07/2017.
//  Copyright © 2017 Dough. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    // MARK: Properties
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        idTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    // MARK: UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // idTextField에서 Next(Return)키 누르면 passwordTextField로 이동
        // passwordTextField에서 Next(Return)키 누르면 키보드 숨김
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
    
    // MARK: Actions
    @IBAction func signInButton(_ sender: UIButton) {
        print("touch up inside - sign in")
        
        // 입력값 있는지 확인한 뒤 Member 생성
        if let id = idTextField.text,
            let pw = passwordTextField.text,
            !id.isEmpty,
            !pw.isEmpty {
            let tempMember = Member(id: id, password: pw)
            tempMember.printInfo()
        } else {
                print("ID or Password is empty")
            }
    }
    @IBAction func signUpButton(_ sender: UIButton) {
        print("touch up inside - sign up")
    }
}

