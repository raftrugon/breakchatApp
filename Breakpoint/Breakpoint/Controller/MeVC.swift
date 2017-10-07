//
//  MeVC.swift
//  Breakpoint
//
//  Created by rafa on 25/8/17.
//  Copyright © 2017 rafa trujillo. All rights reserved.
//

import UIKit
import Firebase

class MeVC: UIViewController {

    @IBOutlet var imageProfile: UIImageView!
    @IBOutlet var emailProfile: UILabel!
    @IBOutlet var table: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.emailProfile.text = Auth.auth().currentUser?.email
    }
    
    @IBAction func logOutBtnPressed(_ sender: Any) {
    
        let logOutAlert = UIAlertController(title: "Logout?", message: "Are you sure?", preferredStyle: .actionSheet)
        
        let logoutAction = UIAlertAction(title: "Logout", style: .destructive) { (buttonTapped) in
            do{
                try Auth.auth().signOut()
                let authVC = self.storyboard?.instantiateViewController(withIdentifier: "AuthVC") as? AuthVC
                self.present(authVC!, animated: true, completion: nil)
            }catch{
                print(error)
            }
           
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        
        logOutAlert.addAction(logoutAction)
        logOutAlert.addAction(cancelAction)
        present(logOutAlert, animated: true, completion: nil)
        
    }
    

}
