//
//  GroupController.swift
//  EduConnect
//
//  Created by Akylai Bekbolsunova on 4/6/24.
//

import UIKit
import SnapKit

class GroupController: BaseController<GroupPresenter> {
    
    private lazy var toolbar: ToolbarView = {
        let view = ToolbarView()
        view.titleView.text = "Groups"
        return view
    }()
    
    private lazy var nameRooms: ContenerEditField = {
        let view = ContenerEditField()
        
        view.setTitle(text: "Groups name")
        
        view.editField.placeholder = "Name"
        view.editField.autocapitalizationType = .none
        return view
    }()
    
    private lazy var send: BrandButton = {
        let view = BrandButton()
        view.setEnable(true)
        view.setTitle("Save groups")
        return view
    }()
    
    private lazy var list = GroupListView()
    
    override func setupController() {
        toolbar.onTapBack {
            self.router?.back()
        }
        
        send.onTab { [self] in
            view.endEditing(true)
            
            if nameRooms.editField.text?.isEmpty == false {
                let controller = UIAlertController(title: "Are you sure you want to add this group?", message: nil, preferredStyle: .alert)
                
                controller.addAction(UIAlertAction(title: "No", style: .default))
                
                controller.addAction(UIAlertAction(title: "Yes", style: .default, handler: { _ in
                    self.presenter?.addGroup(name: self.nameRooms.editField.text ?? "")
                    
                    self.nameRooms.editField.text = ""
                }))
                
                self.present(controller, animated: true)
            }
        }
        
        list.onItemClick { [self] group in
            router?.open(UpdateScheduleBuilder.create(name: group))
        }
        
        presenter?.fetchGroup()
    }
    
    override func setupSubViews() {
        view.addSubview(toolbar)
        toolbar.snp.makeConstraints { make in
            make.top.equalTo(view.safeArea.top)
            make.left.right.equalToSuperview()
            make.height.equalTo(53)
        }
        
        view.addSubview(nameRooms)
        nameRooms.snp.makeConstraints { make in
            make.top.equalTo(toolbar.snp.bottom).offset(8)
            make.left.right.equalToSuperview().inset(16)
            make.height.equalTo(64)
        }
        
        view.addSubview(send)
        send.snp.makeConstraints { make in
            make.top.equalTo(nameRooms.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(45)
        }
        
        view.addSubview(list)
        list.snp.makeConstraints { make in
            make.top.equalTo(send.snp.bottom).offset(8)
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
}

extension GroupController: GroupDelegate {
    
    func showGroups(groups: [String]) {
        list.fill(model: groups)
    }
}
