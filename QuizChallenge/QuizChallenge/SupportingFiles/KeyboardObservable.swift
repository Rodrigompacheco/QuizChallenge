//
//  KeyboardObservable.swift
//  QuizChallenge
//
//  Created by Rodrigo Pacheco on 24/01/20.
//  Copyright © 2020 RodrigoPacheco. All rights reserved.
//

import UIKit

protocol KeyboardObservable {
    func keyboardWillShowNotification(_ scrollView: UIScrollView, onShowHandler onShow: ((CGSize?) -> Void)?)
    func keyboardWillHideNotification(_ scrollView: UIScrollView, onHideHandler onHide: ((CGSize?) -> Void)?)
}

extension KeyboardObservable {
    
    func keyboardWillShowNotification(_ scrollView: UIScrollView, onShowHandler onShow: ((CGSize?) -> Void)? = nil) {
        _ = NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: nil, using: { notification -> Void in
            let userInfo = notification.userInfo!
            guard let keyboardFrameEndUserInfoKey = userInfo[UIResponder.keyboardFrameEndUserInfoKey] else { return }
            let keyboardSize = (keyboardFrameEndUserInfoKey as AnyObject).cgRectValue.size
            let contentInsets = UIEdgeInsets(top: scrollView.contentInset.top, left: scrollView.contentInset.left, bottom: keyboardSize.height, right: scrollView.contentInset.right)
            
            scrollView.setContentInsetAndScrollIndicatorInsets(contentInsets)
            onShow?(keyboardSize)
        })
    }
    
    func keyboardWillHideNotification(_ scrollView: UIScrollView, onHideHandler onHide: ((CGSize?) -> Void)? = nil) {
        _ = NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: nil, using: { notification -> Void in
            let userInfo = notification.userInfo!
            guard let keyboardFrameEndUserInfoKey = userInfo[UIResponder.keyboardFrameEndUserInfoKey] else { return }
            let keyboardSize = (keyboardFrameEndUserInfoKey as AnyObject).cgRectValue.size
            let contentInsets = UIEdgeInsets(top: scrollView.contentInset.top, left: scrollView.contentInset.left, bottom: 0, right: scrollView.contentInset.right)
            
            scrollView.setContentInsetAndScrollIndicatorInsets(contentInsets)
            onHide?(keyboardSize)
        })
    }
}

extension UIScrollView {
    
    func setContentInsetAndScrollIndicatorInsets(_ edgeInsets: UIEdgeInsets) {
        contentInset = edgeInsets
        scrollIndicatorInsets = edgeInsets
    }
}
