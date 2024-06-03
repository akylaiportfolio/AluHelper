//
//  RoomsController.swift
//  EduConnect
//
//  Created by Akylai Bekbolsunova on 4/6/24.
//

import UIKit
import SnapKit

class RoomsController: BaseController<RoomsPresenter> {
    
    private lazy var toolbar: ToolbarView = {
        let view = ToolbarView()
        view.titleView.text = "Rooms"
        return view
    }()
    
    private lazy var nameRooms: ContenerEditField = {
        let view = ContenerEditField()
        
        view.setTitle(text: "Room name")
        
        view.editField.placeholder = "Name"
        view.editField.autocapitalizationType = .none
        return view
    }()
    
    private lazy var send: BrandButton = {
        let view = BrandButton()
        view.setEnable(true)
        view.setTitle("Save rooms")
        return view
    }()
    
    private lazy var list = RoomListView()
    
    override func setupController() {
        toolbar.onTapBack {
            self.router?.back()
        }
        
        send.onTab { [self] in
            view.endEditing(true)
            
            if nameRooms.editField.text?.isEmpty == false {
                presenter?.addRooms(room: nameRooms.editField.text ?? "")
                
                nameRooms.editField.text = ""
            }
        }
        
        list.onItemClick { [self] room in
            let controller = UIAlertController(title: "Room update", message: nil, preferredStyle: .actionSheet)
            
            controller.addAction(UIAlertAction(title: "Remove", style: .default, handler: { _ in
                self.presenter?.removeRooms(room: room)
            }))
            
            controller.addAction(UIAlertAction(title: "Cansel", style: .destructive, handler: nil))
            
            present(controller, animated: true)
        }
        
        presenter?.fetchRooms()
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

extension RoomsController: RoomsDelegate {
    func showAllRooms(rooms: [String]) {
        list.fill(model: rooms)
    }
}
