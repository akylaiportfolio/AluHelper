//
//  GroupPresenter.swift
//  EduConnect
//
//  Created by Akylai Bekbolsunova on 4/6/24.
//

import Foundation

protocol GroupDelegate: AnyObject {
    func showGroups(groups: [String])
}

class GroupPresenter: BasePresenter<GroupDelegate> {
    
    private let api = UserServices.shered
    
    func fetchGroup() {
        api.getAllGroup { groups in
            let list = groups.map { item in
                return item.name ?? ""
            }
            
            self.delegate?.showGroups(groups: list)
        }
    }
    
    func addGroup(name: String) {
        api.getPutGroup(models: GroupModel(name: name)) {
            self.fetchGroup()
        }
    }
}
