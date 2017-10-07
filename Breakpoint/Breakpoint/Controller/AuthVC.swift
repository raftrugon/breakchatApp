//
//  AuthVC.swift
//  Breakpoint
//
//  Created by rafa on 23/8/17.
//  Copyright © 2017 rafa trujillo. All rights reserved.
//

import UIKit
import Firebase

class AuthVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }


    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if Auth.auth().currentUser != nil {
            dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func fbSingINBtnWasPressed(_ sender: Any) {
    }
    

    @IBAction func gSingINBtnWasPressed(_ sender: Any) {
    }
    
    @IBAction func emailSingINBtnWasPressed(_ sender: Any) {
        
        let loginVC = storyboard?.instantiateViewController(withIdentifier: "LoginVC")
        present(loginVC!, animated: true, completion: nil)
    }
}
