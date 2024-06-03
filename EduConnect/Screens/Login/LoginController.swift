//
//  LoginController.swift
//  EduConnect
//
//  Created by Akylai Bekbolsunova on 7/4/24.
//

import UIKit

class LoginController: BaseController<LoginPresenter> {
    
    private lazy var logo: BaseImage = {
        return BaseImage(image: .init(named: "AppMainIcon"))
    }()
    
    private lazy var contener = BaseView()
    
    private lazy var emailField: ContenerEditField = {
        let view = ContenerEditField()
        
        view.setTitle(text: "Log in")
        
        view.editField.placeholder = "Email"
        view.editField.left(.init(named: "Email"))
        view.editField.autocapitalizationType = .none
        return view
    }()
    
    private lazy var passwordField: ContenerEditField = {
        let view = ContenerEditField()
        
        view.setTitle(text: "Password")
        
        view.editField.placeholder = "Password"
        view.editField.setSecured()
        view.editField.left(.init(named: "Password"))
        view.editField.autocapitalizationType = .none
        return view
    }()
    
    private lazy var forgotPassword: BaseLabel = {
        let view = BaseLabel()
        view.font = .systemFont(ofSize: 12)
        view.textColor = .init(hex: "#727272")
        view.text = "Forgot your password"
        return view
    }()
    
    private lazy var checkBox = CheckBox()
    
    private lazy var checkBoxTitle: BaseLabel = {
        let view = BaseLabel()
        view.font = .systemFont(ofSize: 12)
        view.textColor = .init(hex: "#727272")
        
        let text = "I have read and agree to the privacy policy, terms of service."
        
        let attribute = NSMutableAttributedString(string: text)
        
        attribute.changeColor(text, of: "privacy policy", hex: "#973535")
        attribute.changeColor(text, of: "terms of service", hex: "#973535")

        view.attributedText = attribute
        view.numberOfLines = 0
        
        return view
    }()

    private lazy var login: BrandButton = {
        let view = BrandButton()
        view.setEnable(false)
        view.setTitle("Log in")
        return view
    }()
    
    private lazy var registerForm: BaseLabel = {
        let view = BaseLabel()
        view.font = .systemFont(ofSize: 14, weight: .bold)
        view.textColor = .init(hex: "#727272")
        
        let text = "New user? Send register form"
        
        let attribute = NSMutableAttributedString(string: text)
        
        attribute.changeColor(text, of: "Send register form", hex: "#973535")

        view.attributedText = attribute
        return view
    }()
    
    override func setupController() {
        emailField.onChange { [self] _ in
            validateData()
        }
        
        passwordField.onChange { [self] _ in
            validateData()
        }
        
        login.onEnableTab { [self] in
            let email = emailField.editField.text ?? ""
            let password = passwordField.editField.text ?? ""
            
            hideKeyboard()
            
            presenter?.login(email, password)
        }
        
        checkBox.onChange { [self] _ in
            validateData()
        }
        
        registerForm.onTab { [self] in
            presenter?.navigateToForm()
        }
        
        logo.show()
        
        contener.show()
    }
    
    private func validateData() {
        let email = emailField.editField.text?.count ?? 0 > 1
        let password = passwordField.editField.text?.count ?? 0 >= 8
        
        let checkBox = checkBox.enable
        
        login.setEnable(email && password && checkBox)
    }
    
    override func keyboardShow(height: Double) {
        if !logo.isHidden {
            logo.hide()
        }
        
        UIView.animate(withDuration: 0.1) { [self] in
            contener.transform = CGAffineTransform(translationX: 0, y: (height * 0.3) * -1)
        }
    }
    
    override func keyboardHide() {
        logo.show()
        
        UIView.animate(withDuration: 0.1) { [self] in
            contener.transform = CGAffineTransform(translationX: 0, y: 0)
        }
    }
    
    override func setupSubViews() {
        view.addSubview(logo)
        logo.snp.makeConstraints { make in
            make.top.equalTo(view.safeArea.top).offset(33)
            
            make.centerX.equalToSuperview()
        }
        
        view.addSubview(contener)
        contener.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
                        
            make.trailing.equalToSuperview().offset(-16)
            make.leading.equalToSuperview().offset(16)
        }
        
        contener.addSubview(emailField)
        emailField.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            
            make.height.equalTo(64)
        }
        
        contener.addSubview(passwordField)
        passwordField.snp.makeConstraints { make in
            make.top.equalTo(emailField.snp.bottom).offset(16)
            
            make.leading.trailing.equalToSuperview()
            
            make.height.equalTo(64)
        }
        
        contener.addSubview(forgotPassword)
        forgotPassword.snp.makeConstraints { make in
            make.trailing.equalToSuperview()
            
            make.top.equalTo(passwordField.snp.bottom).offset(6)
        }
        
        contener.addSubview(login)
        login.snp.makeConstraints { make in
            make.top.equalTo(passwordField.snp.bottom).offset(78)
            
            make.leading.trailing.equalToSuperview()
            
            make.height.equalTo(45)
        }
        
        contener.addSubview(registerForm)
        registerForm.snp.makeConstraints { make in
            make.centerX.bottom.equalToSuperview()
            
            make.top.equalTo(login.snp.bottom).offset(16)
        }
        
        contener.addSubview(checkBox)
        checkBox.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            
            make.width.height.equalTo(18)
            
            make.bottom.equalTo(login.snp.top).offset(-12)
        }
        
        contener.addSubview(checkBoxTitle)
        checkBoxTitle.snp.makeConstraints { make in
            make.leading.equalTo(checkBox.snp.trailing).offset(6)
            
            make.centerY.equalTo(checkBox)
            
            make.trailing.equalToSuperview()
        }
    }
}

extension LoginController: LoginDelegate {
    func showError(message: String) {
        let controller = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        
        controller.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        
        present(controller, animated: true)
    }
    
    func navigateToMain() {
        router?.new(MainBuilder.create())
    }
    
    func navigateToForm() {
        router?.open(FormBuilder.create())
    }
}
