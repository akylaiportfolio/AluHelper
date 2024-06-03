//
//  SentRentBuilder.swift
//  EduConnect
//
//  Created by Akylai Bekbolsunova on 2/6/24.
//

import UIKit

class SentRentBuilder {
    
    static func create() -> UIViewController {
        let controller = SentRentController()
        let presenter = SentRentPresenter(delegate: controller)
        
        controller.presenter = presenter
        
        return controller
    }
}
