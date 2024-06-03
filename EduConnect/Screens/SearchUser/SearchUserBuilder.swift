//
//  SearchUserBuilder.swift
//  EduConnect
//
//  Created by Akylai Bekbolsunova on 21/4/24.
//

import UIKit

class SearchUserBuilder {
    
    static func create() -> UIViewController {
        let controller = SearchUserController()
        let presenter = SearchUserPresenter(delegate: controller)
        
        controller.presenter = presenter
        
        return controller
    }
}
