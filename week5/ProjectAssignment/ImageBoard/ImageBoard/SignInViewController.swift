//
//  SignInViewController.swift
//  ImageBoard
//
//  Created by Kangsoo on 31/07/2017.
//  Copyright © 2017 Dough. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController {
    @IBAction func pressSignInButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let nextViewController = segue.destination as? SignUpViewController {
            nextViewController.delegate = self
        }
    }
}

extension SignInViewController: SignUpViewControllerDelegate {
    func alertAfterSignUp() {
        let alertController = UIAlertController(title: "회원가입 완료", message: "",
                                                preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "확인", style: .default, handler: nil)
        alertController.addAction(alertAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
}
