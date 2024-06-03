//
//  DetailsInfoPresenter.swift
//  EduConnect
//
//  Created by Akylai Bekbolsunova on 17/5/24.
//

import Foundation

protocol DetailsInfoDelegate: AnyObject {
    
}

class DetailsInfoPresenter: BasePresenter<DetailsInfoDelegate> {
 
    var model: InfoModel? = nil
}
