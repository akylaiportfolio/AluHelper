//
//  InfoPresenter.swift
//  EduConnect
//
//  Created by Akylai Bekbolsunova on 17/5/24.
//

import Foundation

protocol InfoDelegate: AnyObject {
    func showInfoList(model: [InfoModel])
}

class InfoPresenter: BasePresenter<InfoDelegate> {
    
    private var api = UserServices.shered
    
    func fetchData() {
        api.getInfoModels { [self] result in
            if UserServices.shered.getUser()?.status == "admin" {
                delegate?.showInfoList(model: result)
            } else {
                delegate?.showInfoList(model: result.filter { $0.status == "confirm"})
            }
        }
    }
    
    func remove(id: Int) {
        api.getSingleInfoModels { [self] models in
            var models = models
            
            for (index, item) in models.enumerated() {
                if item.id == id {
                    models.remove(at: index)
                    
                    break
                }
            }
            
            api.putInfoModel(models, result: {})
        }
    }
    
    func confirm(id: Int) {
        api.getSingleInfoModels { [self] models in
            var models = models
            
            for (index, item) in models.enumerated() {
                if item.id == id {
                    models[index].status = "confirm"
                    
                    break
                }
            }
            
            api.putInfoModel(models, result: {})
        }
    }
    
    func cansel(id: Int) {
        api.getSingleInfoModels { [self] models in
            var models = models
            
            for (index, item) in models.enumerated() {
                if item.id == id {
                    models[index].status = "cansel"

                    break
                }
            }
            
            api.putInfoModel(models, result: {})
        }
    }
}
