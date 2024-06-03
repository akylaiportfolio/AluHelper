//
//  SplashPresenter.swift
//  EduConnect
//
//  Created by Akylai Bekbolsunova on 7/4/24.
//

import Foundation

protocol SplashDelegate: AnyObject {
    func navigateToMain()
    
    func navigateToLogin()
}

class SplashPresenter: BasePresenter<SplashDelegate> {
    
    private let userServices = UserServices.shered
    
    func checkNavigate() {
        if userServices.getUser() == nil {
            delegate?.navigateToLogin()
        } else {
            delegate?.navigateToMain()
        }
    }
}
