//
//  LoginBuilder.swift
//  EduConnect
//
//  Created by Akylai Bekbolsunova on 7/4/24.
//

import UIKit

class LoginBuilder {
    
    static func create() -> UIViewController {
        let controller = LoginController()
        let presenter = LoginPresenter(delegate: controller)
        
        controller.presenter = presenter
        
        return controller
    }
}
