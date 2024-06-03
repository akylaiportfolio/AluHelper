//
//  ScheduleBuilder.swift
//  EduConnect
//
//  Created by Akylai Bekbolsunova on 16/5/24.
//

import UIKit

class ScheduleBuilder {
    
    static func create() -> UIViewController {
        let controller = ScheduleController()
        let presenter = SchedulePresenter(delegate: controller)
        
        controller.presenter = presenter
        
        return controller
    }
}
