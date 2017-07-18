//
//  ViewController.swift
//  MyButton
//
//  Created by Kangsoo on 17/07/2017.
//  Copyright © 2017 Dough. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var myButton: MyButton!
    
    var isAble: Bool = true
    
    @IBAction func switchButtonTouched(_ sender: UIButton) {
        let currentControlState = myButton.controlState

        if isAble {
            switch currentControlState {
            case UIControlState.normal:
                myButton.isUserInteractionEnabled = false
            case UIControlState.selected:
                myButton.isUserInteractionEnabled = false
            default:
                print("Error is occured at switchButtonTouched.")
                print("Current isAble: \(isAble)")
                print("Current control state: \(currentControlState)")
                return
            }
            
            myButton.imageView.alpha = 0.5
            sender.setTitle("Enable the button", for: .normal)
            isAble = false
        } else {
            switch currentControlState {
            case UIControlState.normal:
                myButton.isUserInteractionEnabled = true
            case UIControlState.selected:
                myButton.isUserInteractionEnabled = true
            default:
                print("Error is occured at switchButtonTouched.")
                print("Current isAble: \(isAble)")
                print("Current control state: \(currentControlState)")
                return
            }
            
            myButton.imageView.alpha = 1.0
            sender.setTitle("Disable the button", for: .normal)
            isAble = true
        }
    }
}

