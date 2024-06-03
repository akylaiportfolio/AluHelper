//
//  UserListBuilder.swift
//  EduConnect
//
//  Created by Akylai Bekbolsunova on 4/6/24.
//

import UIKit

class UserListBuilder {
    
    static func create() -> UIViewController {
        let controller = UserListController()
        let presenter = UserListPresenter(delegate: controller)
        
        controller.presenter = presenter
        
        return controller
    }
}
