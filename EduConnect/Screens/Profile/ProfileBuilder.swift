//
//  ProfileBuilder.swift
//  EduConnect
//
//  Created by Akylai Bekbolsunova on 18/4/24.
//

import UIKit

class ProfileBuilder {
    
    static func create() -> UIViewController {
        let controller = ProfileController()
        let presenter = ProfilePresenter(delegate: controller)
        
        controller.presenter = presenter
        
        return controller
    }
}
