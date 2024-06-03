//
//  SendNewsPresenter.swift
//  EduConnect
//
//  Created by Akylai Bekbolsunova on 17/5/24.
//

import UIKit

protocol SendOrderDelegate: AnyObject {
    func showMessage(message: String)
    
    func showSussesd()
}

class SendOrderPresenter: BasePresenter<SendOrderDelegate> {
    
    private var api = UserServices.shered
    
    func postNews(title: String, message: String, data: Data) {
        let id = Int.random(in: Int.min..<Int.max)
        
        api.savePdf(data, id: id) { url in
            let format = DateFormatter()
            format.dateFormat = "dd.MM.yyyy"
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "HH:mm"
            
            let orderSave = OrderModel(
                id: Int.random(in: 0...Int.max),
                title: title,
                decription: message,
                file: url ?? "",
                create: format.string(from: Date()),
                time: dateFormatter.string(from: Date())
            )
            
            self.api.getSingleAllOrder { order in
                var orders = order
                
                orders.append(orderSave)
                
                self.api.putAllOrders(models: orders) {
                    self.delegate?.showSussesd()
                }
            }
        }
    }

}
