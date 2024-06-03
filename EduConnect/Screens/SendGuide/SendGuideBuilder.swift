//
//  SendGuideBuilder.swift
//  EduConnect
//
//  Created by Akylai Bekbolsunova on 17/5/24.
//

import UIKit

class SendGuideBuilder {
    
    static func create() -> UIViewController {
        let controller = SendGuideController()
        let presenter = SendGuidePresenter(delegate: controller)
        
        controller.presenter = presenter
        
        return controller
    }
}
