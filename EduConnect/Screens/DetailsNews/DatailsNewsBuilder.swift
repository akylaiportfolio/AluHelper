//
//  DatailsNewsBuilder.swift
//  EduConnect
//
//  Created by Akylai Bekbolsunova on 16/5/24.
//

import UIKit

class DatailsNewsBuilder {
    
    static func create(_ model: NewsModel) -> UIViewController {
        let controller = DetailsNewsController()
        let presenter = DetailsNewsPresenter(delegate: controller)
        
        presenter.model = model
        
        controller.presenter = presenter
        
        return controller
    }
}
