//
//  InfoBuilder.swift
//  EduConnect
//
//  Created by Akylai Bekbolsunova on 17/5/24.
//

import UIKit

class InfoBuilder {
    
    static func create() -> UIViewController {
        let controller = InfoController()
        let presenter = InfoPresenter(delegate: controller)
        
        controller.presenter = presenter
        
        return controller
    }
}
