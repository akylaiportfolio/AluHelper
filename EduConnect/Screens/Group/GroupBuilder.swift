//
//  GroupBuilder.swift
//  EduConnect
//
//  Created by Akylai Bekbolsunova on 4/6/24.
//

import UIKit

class GroupBuilder {
    
    static func create() -> UIViewController {
        let controller = GroupController()
        let presenter = GroupPresenter(delegate: controller)
        
        controller.presenter = presenter
        
        return controller
    }
}
