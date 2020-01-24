//
//  UIVIewController.swift
//  QuizChallenge
//
//  Created by Rodrigo Pacheco on 24/01/20.
//  Copyright © 2020 RodrigoPacheco. All rights reserved.
//

import UIKit

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

extension UIViewController {
    func showSimpleAlert(withTitle tile: String?, andMessage message: String, buttonTitle: String) {
        let alert = UIAlertController(title: tile ?? "", message: message, preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: buttonTitle, style: .default, handler: { (action: UIAlertAction!) in
            
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
}
