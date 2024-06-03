//
//  OrdersBuilder.swift
//  EduConnect
//
//  Created by Akylai Bekbolsunova on 16/5/24.
//

import UIKit

class OrdersBuilder {
    
    static func create() -> UIViewController {
        let controller = OrdersController()
        let presenter = OrdersPresenter(delegate: controller)
        
        controller.presenter = presenter
        
        return controller
    }
}
