//
//  RoomsDelegate.swift
//  EduConnect
//
//  Created by Akylai Bekbolsunova on 4/6/24.
//

import UIKit

class RoomsBuilder {
    
    static func create() -> UIViewController {
        let controller = RoomsController()
        let presenter = RoomsPresenter(delegate: controller)
        
        controller.presenter = presenter
        
        return controller
    }
}
