//
//  SendNewsBuilder.swift
//  EduConnect
//
//  Created by Akylai Bekbolsunova on 17/5/24.
//

import UIKit

class SendNewsBuilder {
    
    static func create() -> UIViewController {
        let controller = SendNewsController()
        let presenter = SendNewsPresenter(delegate: controller)
        
        controller.presenter = presenter
        
        return controller
    }
}
