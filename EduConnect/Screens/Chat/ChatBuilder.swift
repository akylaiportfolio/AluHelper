//
//  ChatBuilder.swift
//  EduConnect
//
//  Created by Akylai Bekbolsunova on 21/4/24.
//

import UIKit

class ChatBuilder {
    
    static func create() -> UIViewController {
        let controller = ChatController()
        let presenter = ChatPresenter(delegate: controller)
        
        controller.presenter = presenter
        
        return controller
    }
}
