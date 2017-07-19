//
//  MyButton.swift
//  MyButton
//
//  Created by Kangsoo on 17/07/2017.
//  Copyright © 2017 Dough. All rights reserved.
//

import UIKit

class MyButton: UIView {
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var statusLabel: UILabel!
    
    var controlState: UIControlState = .normal
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        switch controlState {
        case [.normal]:
            imageView.alpha = 0.5
            statusLabel.text = "highlighted1"
            statusLabel.textColor = UIColor.white
            controlState = [.normal, .highlighted]
        case [.selected]:
            imageView.alpha = 0.5
            statusLabel.text = "highlighted2"
            statusLabel.textColor = UIColor.red
            controlState = [.selected, .highlighted]
        default:
            print("Error is occured at touchesBegan.")
            print("Current control state: \(controlState)")
            return
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        switch controlState {
        case [.normal, .highlighted]:
            imageView.alpha = 1.0
            statusLabel.text = "selected"
            statusLabel.textColor = UIColor.green
            controlState = .selected
        case [.selected, .highlighted]:
            imageView.alpha = 1.0
            statusLabel.text = "normal"
            statusLabel.textColor = UIColor.yellow
            controlState = .normal
        default:
            print("Error is occured at touchesEnded.")
            print("Current control state: \(controlState)")
            return
        }
        
        print("touch up inside")
        print("button tapped")
    }
}
