//
//  SendNewsBuilder.swift
//  EduConnect
//
//  Created by Akylai Bekbolsunova on 17/5/24.
//

import UIKit

class SendOrderBuilder {
    
    static func create() -> UIViewController {
        let controller = SendOrderController()
        let presenter = SendOrderPresenter(delegate: controller)
        
        controller.presenter = presenter
        
        return controller
    }
}
