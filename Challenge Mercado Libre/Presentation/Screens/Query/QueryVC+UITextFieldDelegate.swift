//
//  QueryVC+UITextFieldDelegate.swift
//  Challenge Mercado Libre
//
//  Created by Theo Mendes on 03/02/25.
//

import UIKit

extension QueryVC: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = textField.text ?? ""
        let updatedText = (currentText as NSString).replacingCharacters(in: range, with: string)

        searchButton.isEnabled = updatedText.count >= 3

        return true
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        animateShadow(for: textField, to: 0.5)
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        animateShadow(for: textField, to: 0.2)
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()

        if searchButton.isEnabled, let text = textField.text {
            searchWithQuery(text)
        }
        return true
    }

    private func animateShadow(for textField: UITextField, to opacity: Float) {
        let animation = CABasicAnimation(keyPath: "shadowOpacity")
        animation.fromValue = textField.layer.shadowOpacity
        animation.toValue = opacity
        animation.duration = 0.3
        animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)

        textField.layer.add(animation, forKey: "shadowOpacity")
        textField.layer.shadowOpacity = opacity
    }
}
