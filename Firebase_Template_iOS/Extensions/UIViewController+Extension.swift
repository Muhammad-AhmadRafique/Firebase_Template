//
//  UIViewController+Extension.swift
//  Firebase_Template_iOS
//
//  Created by Ahmad Rafiq on 8/5/22.
//

import UIKit
import MBProgressHUD

extension UIViewController {
    func showProgressHud(title:String = "Loading") -> Void {
        let progressHud = MBProgressHUD.showAdded(to: view, animated: true)
        progressHud.label.text = title
    
        let bgColor = #colorLiteral(red: 0, green: 0.6792491078, blue: 0.9288210869, alpha: 1)
        progressHud.bezelView.color = bgColor
        progressHud.bezelView.style = .solidColor
        progressHud.contentColor = UIColor.white
    }
    
    func hideProgressHud() -> Void {
        DispatchQueue.main.async {
            MBProgressHUD.hide(for: self.view , animated: true)
        }
    }
    
    func alertMessage(title: String, alertMessage:String, identifier: String = "", action: (() -> Void)?)
    {
        DispatchQueue.main.async {
            self.hideProgressHud()
            let myAlert = UIAlertController(title:title, message:alertMessage, preferredStyle: UIAlertController.Style.alert)
            myAlert.view.accessibilityIdentifier = identifier
            let okAction = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default) {
                UIAlertAction in
                action?()
            }
            myAlert.addAction(okAction);
            self.present(myAlert, animated:true, completion:nil)
        }
    }
}
