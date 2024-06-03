//
//  NewPresenter.swift
//  EduConnect
//
//  Created by Akylai Bekbolsunova on 16/5/24.
//

import Foundation

protocol NewsDelegate: AnyObject {
    func showNews(models: [NewsModel])
}

class NewsPresenter: BasePresenter<NewsDelegate> {
    
    private var api = UserServices.shered
    
    func fetchData() {
        api.getAllNews { [self] news in
            delegate?.showNews(models: news)
        }
    }
    
    func remove(id: Int) {
        api.getSingleAllNews { [self] models in
            var models = models
            
            for (index, item) in models.enumerated() {
                if item.id == id {
                    models.remove(at: index)
                    
                    break
                }
            }
            
            api.putAllNews(models: models, result: {})
        }
    }
}
