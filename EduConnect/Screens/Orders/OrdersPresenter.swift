//
//  OrderPresenter.swift
//  EduConnect
//
//  Created by Akylai Bekbolsunova on 16/5/24.
//

import Foundation

protocol OrdersDelegate: AnyObject {
    func showOrders(model: [OrderModel])
}

class OrdersPresenter: BasePresenter<OrdersDelegate> {
    
    private var api = UserServices.shered
    
    func fetchData() {
        api.getAllOrder { items in
            self.delegate?.showOrders(model: items)
        }
    }
}
