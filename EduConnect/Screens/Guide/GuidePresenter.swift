//
//  GuidePresenter.swift
//  EduConnect
//
//  Created by Akylai Bekbolsunova on 17/5/24.
//

import Foundation

protocol GuideDelegate: AnyObject {
    func showGuide(models: [GuideModel])
}

class GuidePresenter: BasePresenter<GuideDelegate> {
    
    private var api = UserServices.shered
        
    func fetchData() {
        api.getGuideModels { [self] guide in
            delegate?.showGuide(models: guide)
        }
    }
    
    func remove(id: Int) {
        api.getGuideModelsData { [self] models in
            var models = models
            
            for (index, item) in models.enumerated() {
                if item.id == id {
                    models.remove(at: index)
                    
                    break
                }
            }
            
            api.putGuideModel(models, result: {})
        }
    }
}
