//
//  SendInfoBuilder.swift
//  EduConnect
//
//  Created by Akylai Bekbolsunova on 17/5/24.
//

import UIKit

class SendInfoBuilder {
    
    static func create() -> UIViewController {
        let controller = SendInfoController()
        let presenter = SendInfoPresenter(delegate: controller)
        
        controller.presenter = presenter
        
        return controller
    }
}
