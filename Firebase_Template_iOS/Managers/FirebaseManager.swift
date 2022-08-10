//
//  FirebaseManager.swift
//  Firebase_Template_iOS
//
//  Created by Ahmad Rafiq on 8/5/22.
//

import Foundation
import FirebaseAuth
import FirebaseCore
import FirebaseFirestore

class FirebaseManager: NSObject {
    
    let auth: Auth
    
    static let shared = FirebaseManager()
    
    override init() {
        FirebaseApp.configure()
        
        self.auth = Auth.auth()
        
        super.init()
    }
    
    func loginUser(email: String, password: String, completion: ((AuthDataResult?, Error?) -> Void)?) {
        FirebaseManager.shared.auth.signIn(withEmail: email, password: password) { result, err in
            if let err = err {
                print("Failed to login user:", err)
//                self.loginStatusMessage = "Failed to login user: \(err)"
                completion?(nil, err)
//                return
            } else {
                completion?(result, nil)
            }
            
//            print("Successfully logged in as user: \(result?.user.uid ?? "")")
//
//            self.loginStatusMessage = "Successfully logged in as user: \(result?.user.uid ?? "")"
        }
    }
    
    func signup(email: String, password: String, completion: ((AuthDataResult?, Error?) -> Void)?) {
        FirebaseManager.shared.auth.createUser(withEmail: email, password: password) { result, err in
            
            if let err = err {
                print("Failed to login user:", err)
//                self.loginStatusMessage = "Failed to login user: \(err)"
                completion?(nil, err)
//                return
            } else {
                completion?(result, nil)
            }
        }
    }
    
    
    func saveData(userId: String, userData: [String: String], completion: ((Error?) -> Void)?) {
        Firestore.firestore().collection("users").document(userId).setData(userData, completion: { error in
            if let err = error {
                completion?(err)
            } else {
                completion?(nil)
            }
        })
    }
}
