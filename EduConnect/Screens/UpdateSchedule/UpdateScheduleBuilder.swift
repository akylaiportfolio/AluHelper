//
//  ScheduleBuilder.swift
//  EduConnect
//
//  Created by Akylai Bekbolsunova on 16/5/24.
//

import UIKit

class UpdateScheduleBuilder {
    
    static func create(name: String) -> UIViewController {
        let controller = UpdateScheduleController()
        let presenter = UpdateSchedulePresenter(delegate: controller)
        
        presenter.name = name
        controller.presenter = presenter
        
        return controller
    }
}
