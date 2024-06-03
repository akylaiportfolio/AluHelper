//
//  DetailsOrderPresenter.swift
//  EduConnect
//
//  Created by Akylai Bekbolsunova on 16/5/24.
//

import Foundation

protocol DetailsOrderDelegate: AnyObject {
    
}

class DetailsOrderPresenter: BasePresenter<DetailsOrderDelegate> {
    
    var model: OrderModel? = nil
}
