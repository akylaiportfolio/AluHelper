//
//  AddScheduleBuilder.swift
//  EduConnect
//
//  Created by Akylai Bekbolsunova on 4/6/24.
//

import UIKit

class AddScheduleBuilder {
    
    static func create(name: String) -> UIViewController {
        let controller = AddScheduleController()
        let presenter = AddSchedulePresenter(delegate: controller)
        
        presenter.nameGroup = name
        
        controller.presenter = presenter
        
        return controller
    }
}

