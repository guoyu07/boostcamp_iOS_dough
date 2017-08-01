//
//  SignUpViewController.swift
//  ImageBoard
//
//  Created by Kangsoo on 31/07/2017.
//  Copyright © 2017 Dough. All rights reserved.
//

import UIKit

enum alertType {
    case emptyTextField
//    case emailOverlapped
    case passwordUnconformed
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
    
    @IBAction func submitSignUp(_ sender: UIButton) {
        // 빈칸 확인
        guard
            let emailString = emailTextField.text, !emailString.isEmpty,
            let nicknameString = nicknameTextField.text, !nicknameString.isEmpty,
            let passwordString = passwordTextField.text, !passwordString.isEmpty,
            let checkString = passwordCheckTextField.text, !checkString.isEmpty else {
                alert(for: .emptyTextField)
                return
        }
    
        // 이메일 중복 확인
        
        // 암호 확인
        guard passwordTextField.text == passwordCheckTextField.text else {
            alert(for: .passwordUnconformed)
            return
        }
        
        // 회원정보 저장
        
        self.navigationController?.popViewController(animated: true)
        self.delegate?.alertAfterSignUp()
    }
    
    private func alert(for alertType: alertType) {
        let alertTitle: String
        switch alertType {
        case .emptyTextField:
            alertTitle = "모든 항목을 입력해주세요."
//        case .emailOverlapped: break
        case .passwordUnconformed:
            alertTitle = "암호와 암호확인이\n일치하지 않습니다."
        }
        
        let alertController = UIAlertController(title: alertTitle, message: "",
                                                preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "확인", style: .default, handler: nil)
        alertController.addAction(alertAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
}
