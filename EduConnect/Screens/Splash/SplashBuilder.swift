//
//  SplashBuilder.swift
//  EduConnect
//
//  Created by Akylai Bekbolsunova on 7/4/24.
//

import UIKit

class SplashBuilder {
    
    static func create() -> UIViewController {
        let controller = SplashController()
        let presenter = SplashPresenter(delegate: controller)
        
        controller.presenter = presenter
        
        return controller
    }
}
