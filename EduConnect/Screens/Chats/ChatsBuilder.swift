//
//  ChatsBuilder.swift
//  EduConnect
//
//  Created by Akylai Bekbolsunova on 18/4/24.
//

import UIKit

class ChatsBuilder {
    
    static func create() -> UIViewController {
        let controller = ChatsController()
        let presenter = ChatsPresenter(delegate: controller)
        
        controller.presenter = presenter
        
        return controller
    }
}
