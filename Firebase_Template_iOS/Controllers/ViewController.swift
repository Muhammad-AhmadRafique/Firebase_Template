//
//  ViewController.swift
//  Firebase_Template_iOS
//
//  Created by Ahmad Rafiq on 8/5/22.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

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
        FirebaseManager.shared.signup(email: email, password: password) { [weak self] result, error in
            guard let `self` = self else { return }
            DispatchQueue.main.async {
                self.hideProgressHud()
                if let authResult = result {
                    print(authResult)
                    self.alertMessage(title: "Success", alertMessage: "User is registered successfully", action: {
                        self.saveUserIntoDB(email: email, firstName: "Ahmad", lastName: "Rafiq", phoneNumber: "03001234567")
                    })
                } else {
                    self.alertMessage(title: "Error", alertMessage: "User is registered successfully", action: nil)
                }
            }
        }
    }
    
    private func saveUserIntoDB(email: String, firstName: String, lastName: String, phoneNumber: String) {

        guard let uid = Auth.auth().currentUser?.uid else { return }
        let userData = ["email":email, "first_name": firstName, "last_name": lastName, "phone_number": phoneNumber]
        
        showProgressHud()
        FirebaseManager.shared.saveData(userId: uid, userData: userData) { error in
            self.hideProgressHud()
            if let err = error {
                self.alertMessage(title: "Error", alertMessage: err.localizedDescription, action: nil)
            } else {
                self.alertMessage(title: "Succes", alertMessage: "User's data is saved successfully", action: nil)
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
        FirebaseManager.shared.loginUser(email: email, password: password) { [weak self] result, err in
            guard let `self` = self else { return }
            DispatchQueue.main.async {
                self.hideProgressHud()
                if let user = result?.user {
                    let str = ("Email : " + (user.email ?? "")) + "\n" + ( "User ID : " + user.uid )
                    self.alertMessage(title: "Success", alertMessage: str, action: nil)
                } else {
                    self.alertMessage(title: "Error", alertMessage: "Invalid email/password", action: nil)
                }
            }
        }
    }
}

