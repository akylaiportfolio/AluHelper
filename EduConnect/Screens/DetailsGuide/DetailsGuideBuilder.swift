//
//  DetailsGuideBuilder.swift
//  EduConnect
//
//  Created by Akylai Bekbolsunova on 17/5/24.
//

import UIKit

class DetailsGuideBuilder {
    
    static func create(_ model: GuideModel) -> UIViewController {
        let controller = DetailsGuideController()
        let presenter = DetailsGuidePresenter(delegate: controller)
        
        presenter.model = model
        
        controller.presenter = presenter
        
        return controller
    }
}
