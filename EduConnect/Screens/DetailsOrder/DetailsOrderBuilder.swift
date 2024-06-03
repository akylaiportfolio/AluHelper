//
//  DetailsOrderBuilder.swift
//  EduConnect
//
//  Created by Akylai Bekbolsunova on 16/5/24.
//

import UIKit

class DetailsOrderBuilder {
    
    static func create(model: OrderModel) -> UIViewController {
        let controller = DetailsOrderController()
        let presenter = DetailsOrderPresenter(delegate: controller)
        
        presenter.model = model
        
        controller.presenter = presenter
        
        return controller
    }
}
