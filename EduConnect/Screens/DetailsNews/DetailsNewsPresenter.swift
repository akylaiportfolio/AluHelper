//
//  DetailsNewsPresenter.swift
//  EduConnect
//
//  Created by Akylai Bekbolsunova on 16/5/24.
//

import Foundation

protocol DetailsNewsDelegate: AnyObject {
    
}

class DetailsNewsPresenter: BasePresenter<DetailsNewsDelegate> {
    
    var model: NewsModel? = nil
    
}
