//
//  GuideBuilder.swift
//  EduConnect
//
//  Created by Akylai Bekbolsunova on 17/5/24.
//

import UIKit

class GuideBuilder {
    
    static func create() -> UIViewController {
        let controller = GuideController()
        let presenter = GuidePresenter(delegate: controller)
                
        controller.presenter = presenter
        
        return controller
    }
}
