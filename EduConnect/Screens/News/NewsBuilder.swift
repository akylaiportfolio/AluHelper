//
//  NewsBuilder.swift
//  EduConnect
//
//  Created by Akylai Bekbolsunova on 16/5/24.
//

import UIKit

class NewsBuilder {
    
    static func create() -> UIViewController {
        let controller = NewsController()
        let presenter = NewsPresenter(delegate: controller)
        
        controller.presenter = presenter
        
        return controller
    }
}
