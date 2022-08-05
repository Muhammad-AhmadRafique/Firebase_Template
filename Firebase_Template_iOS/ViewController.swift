//
//  ViewController.swift
//  Firebase_Template_iOS
//
//  Created by Ahmad Rafiq on 8/5/22.
//

import UIKit
import FirebaseAuth

class ViewController: UIViewController {

    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    //MARK:- View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
       
        
        
    }

    @IBAction func signupButtonWasPressed(_ sender: Any) {
        
        let email = emailField.text ?? ""
        let password = passwordField.text ?? ""
        
        if email.isEmpty {
            self.alertMessage(title: "Alert", alertMessage: "Please enter email", action: nil)
            return
        }
        
        if password.isEmpty {
            self.alertMessage(title: "Alert", alertMessage: "Please enter password", action: nil)
            return
        }
        
        showProgressHud()
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] authResult, error in
            
            guard let `self` = self else { return }
            DispatchQueue.main.async {
                self.hideProgressHud()
                print(authResult)

                if let authResult = authResult {
                    self.alertMessage(title: "Success", alertMessage: "User is registered successfully", action: nil)
                } else {
                    self.alertMessage(title: "Error", alertMessage: "User is registered successfully", action: nil)
                }
            }
        }
    }
    
    @IBAction func loginButtonWasPressed(_ sender: Any) {
        let email = emailField.text ?? ""
        let password = passwordField.text ?? ""
        
        if email.isEmpty {
            self.alertMessage(title: "Alert", alertMessage: "Please enter email", action: nil)
            return
        }
        
        if password.isEmpty {
            self.alertMessage(title: "Alert", alertMessage: "Please enter password", action: nil)
            return
        }
        
        showProgressHud()
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
            
            guard let `self` = self else { return }
            DispatchQueue.main.async {
                self.hideProgressHud()
                print(authResult)

                if let user = authResult?.user {
                    let str = ("Email : " + (user.email ?? "")) + "\n" + ( "User ID : " + user.uid )
                    self.alertMessage(title: "Success", alertMessage: str, action: nil)
                } else {
                    self.alertMessage(title: "Error", alertMessage: "Invalid email/password", action: nil)
                }
            }
        }
    }
}

