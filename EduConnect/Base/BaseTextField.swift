//
//  BaseTextField.swift
//  EduConnect
//
//  Created by Akylai Bekbolsunova on 21/4/24.
//

import UIKit

class BaseTextField: UITextField {
    
    var action: (String) -> Void = { _ in }
    
    func onEditing(action: @escaping (String) -> Void) {
        self.action = action

        self.delegate = self
    }
}

extension BaseTextField: UITextFieldDelegate {
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        action(textField.text ?? "")
    }
}
