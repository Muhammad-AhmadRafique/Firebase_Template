//
//  ModeSelection.swift
//  Firebase_Template_iOS
//
//  Created by Ahmad Rafiq on 8/5/22.
//

import Foundation
import UIKit

class ModeSelection {
    static let instance = ModeSelection()

    func loginMode() -> Void {
        if #available(iOS 13.0, *) {
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
                if let delegate = windowScene.delegate as? SceneDelegate {
                    if let window = delegate.window {
                        let rootVC = Storyboards.MAIN.instantiateViewController(withIdentifier: "MainViewController") as! MainViewController
                        window.rootViewController = rootVC
                        window.makeKeyAndVisible()
                    }
                }
            }
        }
    }
    
    func signupMode() -> Void {
        if #available(iOS 13.0, *) {
            print(UIApplication.shared.connectedScenes.count)
            print(UIApplication.shared.connectedScenes)
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
                if let delegate = windowScene.delegate as? SceneDelegate {
                    if let window = delegate.window {
                        let rootVC = Storyboards.SIGNUP.instantiateViewController(withIdentifier: "ViewController")
                        window.rootViewController = rootVC
                        window.makeKeyAndVisible()
                    }
                }
            }
        }
    }
    
}

