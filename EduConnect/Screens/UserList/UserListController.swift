//
//  UserListController.swift
//  EduConnect
//
//  Created by Akylai Bekbolsunova on 4/6/24.
//

import UIKit
import SnapKit

class UserListController: BaseController<UserListPresenter> {
    
    private lazy var toolbar: ToolbarView = {
        let view = ToolbarView()
        view.titleView.text = "User list"
        return view
    }()
    
    private lazy var list = UserListView()
        
    override func setupController() {
        toolbar.onTapBack {
            self.router?.back()
        }
        
        list.onItemClick { [self] model in
            let controller = UIAlertController(title: "User update", message: nil, preferredStyle: .actionSheet)
            
            controller.addAction(UIAlertAction(title: "Make student", style: .default, handler: { _ in
                self.presenter?.makeStudent(uid: model.uid)
            }))
            
            controller.addAction(UIAlertAction(title: "Make teacher", style: .default, handler: { _ in
                self.presenter?.makeTeacher(uid: model.uid)
            }))
            
            controller.addAction(UIAlertAction(title: "Cansel", style: .destructive, handler: nil))
            
            present(controller, animated: true)
        }
        
        presenter?.fetchUsers()
    }
    
    override func setupSubViews() {
        view.addSubview(toolbar)
        toolbar.snp.makeConstraints { make in
            make.top.equalTo(view.safeArea.top)
            make.left.right.equalToSuperview()
            make.height.equalTo(53)
        }
        
        view.addSubview(list)
        list.snp.makeConstraints { make in
            make.top.equalTo(toolbar.snp.bottom)
            make.left.right.bottom.equalToSuperview()
        }
    }
}

extension UserListController: UserListDelegate {
    func showAllUser(users: [UserModel]) {
        list.fill(model: users)
    }
}
