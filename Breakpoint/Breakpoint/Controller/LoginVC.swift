//
//  LoginVC.swift
//  Breakpoint
//
//  Created by rafa on 23/8/17.
//  Copyright © 2017 rafa trujillo. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {

    @IBOutlet var emailTxtField: InsetTextField!
    @IBOutlet var passwordTextField: InsetTextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTxtField.delegate = self
        passwordTextField.delegate = self
        // Do any additional setup after loading the view.
    }

    
    @IBAction func singBtnPressed(_ sender: Any) {
        if emailTxtField.text != nil && passwordTextField.text != nil {
            AuthService.instance.loingUser(withEmail: emailTxtField.text!, andPassword: passwordTextField.text!, loginComplete: { (success, loginError) in
                if success {
                    self.dismiss(animated: true, completion: nil)
                } else {
                    print(String(describing: loginError?.localizedDescription))
                }
                
                AuthService.instance.registerUser(withEmail: self.emailTxtField.text!, andPassword: self.passwordTextField.text!, userCreationComplete: { (success, registrationError) in
                    
                    if success{
                        AuthService.instance.loingUser(withEmail: self.emailTxtField.text!, andPassword: self.passwordTextField.text!, loginComplete: { (success, nil) in
                            self.dismiss(animated: true, completion: nil)
                            print("EXITO AL REGISTRAR USUARIO")
                            
                            
                        })
                    } else {
                        print(String(describing: registrationError?.localizedDescription))
                    }
                    
                })
            })
        }
    }
    
    @IBAction func closeBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}

extension LoginVC: UITextFieldDelegate{
    
}
