//
//  ViewController.swift
//  MyButton
//
//  Created by Kangsoo on 17/07/2017.
//  Copyright © 2017 Dough. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var mybutton: MyButton!
    
    var isAble: Bool = true
    
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
            }
            
            mybutton.imageView.alpha = 1.0
            sender.setTitle("Disable the button", for: .normal)

            isAble = true
        }
    }
}

