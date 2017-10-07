//
//  CreateGroupVC.swift
//  Breakpoint
//
//  Created by rafa on 26/8/17.
//  Copyright © 2017 rafa trujillo. All rights reserved.
//

import UIKit
import Firebase

class CreateGroupVC: UIViewController {

    @IBOutlet var titleTxtfield: InsetTextField!
    
    @IBOutlet var descriptionTextField: InsetTextField!
    
    @IBOutlet var peopleTextField: InsetTextField!
    
    @IBOutlet var groupMemberLbl: UILabel!
    
    @IBOutlet var tableView: UITableView!
    
    @IBOutlet var doneBtn: UIButton!
    
    
    var emailArray = [String]()
    var choosenUserArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        peopleTextField.delegate = self 
        peopleTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
    }
    

    @objc func textFieldDidChange(){
        if peopleTextField.text == ""{
            emailArray = []
            tableView.reloadData()
        }else{
            DataService.instance.getEmail(forSearchquery: peopleTextField.text!, handler: { (returnedEmailArray) in
                self.emailArray = returnedEmailArray
                self.tableView.reloadData()
            })
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        doneBtn.isHidden = true
    }
    
    @IBAction func doneBtnPressed(_ sender: Any) {
        
        if titleTxtfield.text != "" && descriptionTextField.text != "" {
            DataService.instance.getIds(forUsername: choosenUserArray, handler: { (idsArray) in
                var userIds = idsArray
                userIds.append((Auth.auth().currentUser?.uid)!)
                
                DataService.instance.createGroup(title: self.titleTxtfield.text!, description: self.descriptionTextField.text!, ids: userIds, handler: { (groupCreated) in
                    if groupCreated{
                        self.dismiss(animated: true, completion: nil)
                    }else{
                        print("El grupo no pudo ser creado")
                    }
                })
            })
        }
        
    }
    
    
    @IBAction func closeBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}

extension CreateGroupVC: UITableViewDelegate, UITableViewDataSource{
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return emailArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "userCell") as? UserCell else{return UITableViewCell()}
        let image = UIImage(named: "defaultProfileImage")
        
        if choosenUserArray.contains(emailArray[indexPath.row]){
            cell.configureCell(profileImage: image!, email:emailArray[indexPath.row], isSelected: true)
        } else {
                      cell.configureCell(profileImage: image!, email:emailArray[indexPath.row], isSelected: false)
        }
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? UserCell else {return}
        
        if !choosenUserArray.contains(cell.emailLbl.text!){
            choosenUserArray.append(cell.emailLbl.text!)
            groupMemberLbl.text = choosenUserArray.joined(separator: ", ")
            doneBtn.isHidden = false
        }else{
            choosenUserArray = choosenUserArray.filter({$0 != cell.emailLbl.text!})
            
            if choosenUserArray.count >= 1 {
                groupMemberLbl.text = choosenUserArray.joined(separator: ", ")
            }else {
                groupMemberLbl.text = "add people to your group"
                doneBtn.isHidden = true
            }
        }
    }
    
}


extension CreateGroupVC: UITextFieldDelegate{
    
}
