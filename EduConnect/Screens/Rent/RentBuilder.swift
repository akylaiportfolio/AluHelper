//
//  RentBuilder.swift
//  EduConnect
//
//  Created by Akylai Bekbolsunova on 2/6/24.
//

import UIKit

class RentBuilder {
    
    static func create() -> UIViewController {
        let controller = RentController()
        let presenter = RentPresenter(delegate: controller)
        
        controller.presenter = presenter
        
        return controller
    }
}
