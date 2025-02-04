//
//  QueryVC+Keyboard.swift
//  Challenge Mercado Libre
//
//  Created by Theo Mendes on 03/02/25.
//

import UIKit

extension QueryVC {
    func setupKeyboardHandling() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    @objc func keyboardWillShow(notification: Notification) {
        guard let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }

        let keyboardHeight = keyboardFrame.height
        let bottomPadding: CGFloat = 20

        scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardHeight + bottomPadding, right: 0)
        scrollView.scrollIndicatorInsets = scrollView.contentInset
    }

    @objc func keyboardWillHide(notification: Notification) {
        scrollView.contentInset = .zero
        scrollView.scrollIndicatorInsets = .zero
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
