//
//  SendInfoPresenter.swift
//  EduConnect
//
//  Created by Akylai Bekbolsunova on 17/5/24.
//

import Foundation

protocol SendInfoDelegate: AnyObject {
    func showMessage(message: String)
    
    func showSussesd()
}

class SendInfoPresenter: BasePresenter<SendInfoDelegate> {
    
    private var api = UserServices.shered
    
    func postInfo(title: String, message: String) {
        var infoModel: InfoModel? = nil
        
        if api.getUser()?.status == "admin" {
            infoModel = .init(
                id: Int.random(in: Int.min..<Int.max),
                title: title,
                message: message,
                status: "pading",
                userName: UserServices.shered.getUser()?.fullName ?? "",
                group: "Administration"
            )
        } else {
            infoModel = .init(
                id: Int.random(in: Int.min..<Int.max),
                title: title,
                message: message,
                status: "pading",
                userName: UserServices.shered.getUser()?.fullName ?? "",
                group: UserServices.shered.getUser()?.group ?? ""
            )
        }
        
        if let infoModel = infoModel {
            api.putInfoModel(
                infoModel
            ) { [self] in
                delegate?.showSussesd()
            }
        }
    }

}
