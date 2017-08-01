//
//  DummyViewController.swift
//  ImageBoard
//
//  Created by Kangsoo on 01/08/2017.
//  Copyright © 2017 Dough. All rights reserved.
//

import UIKit

class DuummyViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let signInViewController = self.storyboard?.instantiateViewController(withIdentifier: "SignInViewController") {
            let navigationController = UINavigationController(rootViewController: signInViewController)
            self.present(navigationController, animated:false, completion: nil)
        }
    }
}
