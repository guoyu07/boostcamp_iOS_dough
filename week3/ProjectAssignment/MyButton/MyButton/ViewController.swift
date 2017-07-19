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
    
    var isMyButtonWorking: Bool = true
    
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
}

