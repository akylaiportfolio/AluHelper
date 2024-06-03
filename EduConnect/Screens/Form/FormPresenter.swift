//
//  FormPresenter.swift
//  EduConnect
//
//  Created by Akylai Bekbolsunova on 17/4/24.
//

import Foundation
import UIKit

protocol FormDelegate: AnyObject {
    func showError(message: String)
    
    func passForm()
    
    func showSelectGroup(group: [GroupModel])
}

class FormPresenter: BasePresenter<FormDelegate> {
    
    private let userServices = UserServices.shered
    
    func sendForm(
        _ avatar: UIImage,
        _ email: String,
        _ fullName: String,
        _ dateOfBirth: String,
        _ courses: String,
        _ password: String
    ) {
        userServices.sendForm(avatar, email, fullName, dateOfBirth, courses, password) { [self] result in
            switch result {
            case .error(let type):
                switch type {
                case .notValid:
                    delegate?.showError(message: "The form has already been sent via Gmail")
                    
                    break
                case .notCreate:
                    delegate?.showError(message: "Error send form")

                    break
                }
            case .pass:
                delegate?.passForm()
                
                break
            }
        }
    }
    
    func getAllGroup() {
        userServices.getAllGroup { [self] group in
            delegate?.showSelectGroup(group: group)
        }
    }
}
