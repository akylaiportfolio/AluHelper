//
//  HomeBuilder.swift
//  EduConnect
//
//  Created by Akylai Bekbolsunova on 20/4/24.
//

import UIKit

class HomeBuilder {
    
    static func create() -> UIViewController {
        let controller = HomeController()
        let presenter = HomePresenter(delegate: controller)
        
        controller.presenter = presenter
        
        return controller
    }
}
