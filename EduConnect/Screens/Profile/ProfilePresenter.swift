//
//  ProfilePresenter.swift
//  EduConnect
//
//  Created by Akylai Bekbolsunova on 18/4/24.
//

import UIKit

protocol ProfileDelegate: AnyObject {
    func showProfile(model: UserModel)
}

class ProfilePresenter: BasePresenter<ProfileDelegate> {
 
    private var api = UserServices.shered
    
    func logout() {
        api.logout()
    }
    
    func fetchData() {
        let user = api.getUser()
        
        if let user = user {
            delegate?.showProfile(model: user)
        }
    }
    
    func updateProfile(image: UIImage, fullname: String, dateOfBirth: String) {
        let uid = api.getUser()?.uid ?? ""
        
        api.saveAvatar(image, uid: uid) { [self] url in
            api.updateProfile(uid: uid, avatar: url ?? "", fullname: fullname, dateOfBirth: dateOfBirth) {
                
                self.fetchData()
            }
        }
    }
}
