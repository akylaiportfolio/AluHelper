//
//  SearchUserPresenter.swift
//  EduConnect
//
//  Created by Akylai Bekbolsunova on 21/4/24.
//

import Foundation

protocol SearchUserDelegate: AnyObject {
    func showResult(models: [UserModel])
}

class SearchUserPresenter: BasePresenter<SearchUserDelegate> {
    let userServices = UserServices.shered
    
    func searchUser(text: String) {
        userServices.getAllUsers { [self] users in
            if let users {
                let result = users.filter { user in
                    return user.fullName.contains(text) && user.uid != (userServices.getUser()?.uid ?? "")
                }
                
                delegate?.showResult(models: result)
            }
        }
    }
}
