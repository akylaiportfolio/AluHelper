//
//  SendGuidePresenter.swift
//  EduConnect
//
//  Created by Akylai Bekbolsunova on 17/5/24.
//

import UIKit

protocol SendGuideDelegate: AnyObject {
    func showMessage(message: String)
    
    func showSussesd()
}

class SendGuidePresenter: BasePresenter<SendGuideDelegate> {
    
    private var api = UserServices.shered
    
    func postGuide(title: String, message: String, image: UIImage) {
        let id = Int.random(in: Int.min..<Int.max)
        
        api.saveGuideImage(image, id: id) { url in
            let guideModel: GuideModel = .init(
                id: Int.random(in: Int.min..<Int.max),
                title: title,
                message: message,
                userName: UserServices.shered.getUser()?.fullName ?? "",
                group: "Administration",
                url: url
            )
            
            self.api.getGuideModelsData { items in
                var items = items
                
                items.append(guideModel)
                
                self.api.putGuideModel(items) {
                    self.delegate?.showSussesd()
                }
            }
        }
    }

}
