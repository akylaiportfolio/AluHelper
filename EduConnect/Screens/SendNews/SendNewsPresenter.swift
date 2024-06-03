//
//  SendNewsPresenter.swift
//  EduConnect
//
//  Created by Akylai Bekbolsunova on 17/5/24.
//

import UIKit

protocol SendNewsDelegate: AnyObject {
    func showMessage(message: String)
    
    func showSussesd()
}

class SendNewsPresenter: BasePresenter<SendNewsDelegate> {
    
    private var api = UserServices.shered
    
    func postNews(title: String, message: String, image: UIImage) {
        let id = Int.random(in: Int.min..<Int.max)
        
        api.saveNewsImage(image, id: id) { url in
            let format = DateFormatter()
            format.dateFormat = "dd.MM.yyyy"
            
            let guideModel: NewsModel = .init(
                id: id, title: title,
                decription: message, image: url,
                create: format.string(from: Date()), time: format.string(from: Date())
            )
            
            self.api.getSingleAllNews { items in
                var items = items
                
                items.append(guideModel)
                
                self.api.putAllNews(models: items) {
                    self.delegate?.showSussesd()
                }
            }
        }
    }

}
