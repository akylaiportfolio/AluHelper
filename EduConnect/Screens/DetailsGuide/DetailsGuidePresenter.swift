//
//  DetailsGuidePresenter.swift
//  EduConnect
//
//  Created by Akylai Bekbolsunova on 17/5/24.
//

import Foundation

protocol DetailsGuideDelegate: AnyObject {
    
}

class DetailsGuidePresenter: BasePresenter<DetailsGuideDelegate> {
    
    public var model: GuideModel? = nil
}
