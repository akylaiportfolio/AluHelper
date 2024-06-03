//
//  UserListPresenter.swift
//  EduConnect
//
//  Created by Akylai Bekbolsunova on 4/6/24.
//

import Foundation

protocol UserListDelegate: AnyObject {
    func showAllUser(users: [UserModel])
}

class UserListPresenter: BasePresenter<UserListDelegate> {
 
    private let api = UserServices.shered
    
    func fetchUsers() {
        api.observersUsers { users in
            self.delegate?.showAllUser(users: users.filter { $0.status != "admin" })
        }
    }
    
    func makeStudent(uid: String) {
        api.updateProfile(uid: uid, status: "student") {
            
        }
    }
    
    func makeTeacher(uid: String) {
        api.updateProfile(uid: uid, status: "teacher") {
            
        }
    }
    
    func makeBlock(uid: String) {
        api.updateProfile(uid: uid, status: "block") {
            
        }
    }
}
