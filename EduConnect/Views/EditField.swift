//
//  EditField.swift
//  EduConnect
//
//  Created by Akylai Bekbolsunova on 7/4/24.
//

import UIKit

enum StateField {
    case normal
    case error(String)
}

class EditField: UITextField {
    
    init(_ left: BaseImage? = nil, _ right: BaseImage? = nil) {
        super.init(frame: .zero)
        
        font = UIFont.systemFont(ofSize: 14)
        
        layer.cornerRadius = 10
        layer.borderWidth = 1
        layer.borderColor = UIColor(hex: "#DDDDDD").cgColor
        
        leftViewMode = .always
        let leftContener = UIView()
        leftView = leftContener
        
        leftContener.snp.makeConstraints { make in
            make.width.equalTo(10)
            make.height.equalTo(45)
        }
        
        rightViewMode = .always
        let rightContener = BaseView()
        
        rightView = rightContener
        
        rightContener.snp.makeConstraints { make in
            make.width.equalTo(10)
            make.height.equalTo(45)
        }
    }
    
    func state(_ state: StateField) {
        switch state {
        case .normal:
            textColor = .init(hex: "#000000")
            
            layer.borderColor = UIColor(hex: "#DDDDDD").cgColor
            
        case .error:
            textColor = .init(hex: "#973535")

            layer.borderColor = UIColor(hex: "#973535").cgColor
        }
    }
    
    func left(_ image: UIImage?) {
        let left = BaseImage(image: image)
        
        leftViewMode = .always
        let leftContener = UIView()
        leftView = leftContener
        
        leftContener.addSubview(left)
        left.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        leftContener.snp.makeConstraints { make in
            make.width.equalTo(44)
            make.height.equalTo(45)
        }
    }
    
    func setSecured() {
        isSecureTextEntry = true

        let right = BaseImage(image: .init(named: "CloseEye"))
        
        rightViewMode = .always
        let rightContener = BaseView()
        
        rightView = rightContener
        
        rightContener.onTab { [self] in
            if isSecureTextEntry {
                isSecureTextEntry = false
                
                right.image = .init(named: "OpenEye")
                
                right.show()
            } else {
                isSecureTextEntry = true
                
                right.image = .init(named: "CloseEye")
                
                right.show()
            }
        }
        
        rightContener.addSubview(right)
        right.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        rightContener.snp.makeConstraints { make in
            make.width.equalTo(44)
            
            make.height.equalTo(45)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var action: (String) -> Void = { _ in }
    
    func onChange(action: @escaping (String) -> Void) {
        self.action = action
        
        delegate = self
    }
}

extension EditField: UITextFieldDelegate {
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        state(.normal)
        
        action(textField.text ?? "")
    }
}
