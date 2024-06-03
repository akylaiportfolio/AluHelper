//
//  FormBuilder.swift
//  EduConnect
//
//  Created by Akylai Bekbolsunova on 17/4/24.
//

import UIKit

class FormBuilder {
    
    static func create() -> UIViewController {
        let controller = FormController()
        let presenter = FormPresenter(delegate: controller)
        
        controller.presenter = presenter
        
        return controller
    }
}
