//
//  SignUpViewController.swift
//  LoginPage
//
//  Created by Kangsoo on 16/07/2017.
//  Copyright © 2017 Dough. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController, UITextFieldDelegate,
UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var checkPasswordTextField: UITextField!
    @IBOutlet weak var selfIntroduceTextView: UITextView!
    
    @IBAction func selectImageFromPhotoLibrary(_ sender: UITapGestureRecognizer) {
        let imagePickerController = UIImagePickerController()
        
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.allowsEditing = true // 이미지 선택 후 편집으로 이동
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
    }
    
    @IBAction func cancelButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func signUpButton(_ sender: UIButton) {
        guard let textFromPassword = passwordTextField.text,
            !textFromPassword.isEmpty else {
                print("Password is empty.")
                return
        }
        
        guard let textFromCheckPassword = checkPasswordTextField.text,
            !textFromCheckPassword.isEmpty else {
                print("Check Password is empty.")
                return
        }
        
        if textFromPassword != textFromCheckPassword {
            print("Check your password.")
        } else {
            dismiss(animated: true, completion: nil)
        }
    }
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		idTextField.delegate = self
		passwordTextField.delegate = self
		checkPasswordTextField.delegate = self
	}
	
    // MARK: UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // MARK: UIResponder
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    // MARK: UIImagePickerControllerDelegate
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : Any]) {
        // UIImagePickerControllerOriginalImage -> UIImagePickerControllerEditedImage
        guard let selectedImage = info[UIImagePickerControllerEditedImage] as? UIImage
            else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        
        photoImageView.image = selectedImage
        dismiss(animated: true, completion: nil)
    }

}
