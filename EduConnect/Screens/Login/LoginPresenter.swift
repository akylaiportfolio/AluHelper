//
//  LoginPresenter.swift
//  EduConnect
//
//  Created by Akylai Bekbolsunova on 7/4/24.
//

import Foundation

protocol LoginDelegate: AnyObject {
    func navigateToForm()
    
    func showError(message: String)
    
    func navigateToMain()
}


class LoginPresenter: BasePresenter<LoginDelegate> {
    
    private let userServices = UserServices.shered
    
    func login(_ email: String, _ password: String) {        
        userServices.login(email, password) { [self] status in
            switch status {
            case .error(_):
                delegate?.showError(message: "User not create")
                
                break
            case .pass(let model):
                if model.status == "form" {
                    delegate?.showError(message: "Your form has not been reviewed. Please wait a little longer.")
                } else {
                    userServices.save(user: model)
                    
                    delegate?.navigateToMain()
                }
                
                break
            }
        }
        
    }
    
    func navigateToForm() {
        delegate?.navigateToForm()
    }
}
