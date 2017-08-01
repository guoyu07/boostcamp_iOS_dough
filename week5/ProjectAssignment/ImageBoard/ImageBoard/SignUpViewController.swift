//
//  SignUpViewController.swift
//  ImageBoard
//
//  Created by Kangsoo on 31/07/2017.
//  Copyright © 2017 Dough. All rights reserved.
//

import UIKit

enum alertType {
    case unfilledField
    case passwordCheck
    case overlapedEmail
}

protocol SignUpViewControllerDelegate {
    func alertAfterSignUp()
}

class SignUpViewController: UIViewController {
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var nicknameTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var passwordCheckTextField: UITextField!
    
    var delegate: SignUpViewControllerDelegate?
    
    let session: URLSession = {
        let config = URLSessionConfiguration.default
        return URLSession(configuration: config)
    }()
    
    @IBAction func submitSignUp(_ sender: UIButton) {
        guard
            let emailString = emailTextField.text, !emailString.isEmpty,
            let nicknameString = nicknameTextField.text, !nicknameString.isEmpty,
            let passwordString = passwordTextField.text, !passwordString.isEmpty,
            let checkString = passwordCheckTextField.text, !checkString.isEmpty else {
                alert(for: .unfilledField)
                return
        }
        
        guard passwordTextField.text == passwordCheckTextField.text else {
            alert(for: .passwordCheck)
            return
        }
        
        // [작업 중] 제출, 이메일 중복체크
        
        self.navigationController?.popViewController(animated: true)
        self.delegate?.alertAfterSignUp()
    }
    
    private func alert(for alertType: alertType) {
        let alertTitle: String
        switch alertType {
        case .unfilledField:
            alertTitle = "모든 항목을 입력해주세요."
        case .passwordCheck:
            alertTitle = "암호와 암호확인이\n일치하지 않습니다."
        case .overlapedEmail:
            alertTitle = "알림"
        }
        
        let alertController = UIAlertController(title: alertTitle, message: nil,
                                                preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "확인", style: .default, handler: nil)
        alertController.addAction(alertAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
}
