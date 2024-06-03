//
//  DetailsInfoBuilder.swift
//  EduConnect
//
//  Created by Akylai Bekbolsunova on 17/5/24.
//

import UIKit

class DetailsInfoBuilder {
    
    static func create(_ model: InfoModel) -> UIViewController {
        let controller = DetailsInfoController()
        let presenter = DetailsInfoPresenter(delegate: controller)
        
        presenter.model = model
        
        controller.presenter = presenter
        
        return controller
    }
}
