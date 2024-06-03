//
//  ChatController.swift
//  EduConnect
//
//  Created by Akylai Bekbolsunova on 21/4/24.
//

import UIKit
import SnapKit

class ChatController: BaseController<ChatPresenter> {
    
    private lazy var listView = MessagingListView()
    
    private lazy var editChat = EditChatView()
    
    private lazy var toolbar = ChatToolbar()
    
    private lazy var safeArea: BaseView = {
        let view = BaseView()
        view.backgroundColor = .init(hex: "#FFFFFF")
        return view
    }()
    
    override func setupController() {
        view.backgroundColor = .init(hex: "#F5F5F5")
    }
    
    override func setupSubViews() {
        view.addSubview(editChat)
        editChat.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            
            make.height.equalTo(60)
            
            make.bottom.equalTo(view.safeArea.bottom)
        }
        
        view.addSubview(toolbar)
        toolbar.snp.makeConstraints { make in
            make.top.equalTo(view.safeArea.top)
            make.left.right.equalToSuperview()
            make.height.equalTo(53)
        }
        
        view.addSubview(safeArea)
        safeArea.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.left.right.equalToSuperview()
            make.top.equalTo(view.safeArea.bottom)
        }
        
        view.addSubview(listView)
        listView.snp.makeConstraints { make in
            make.top.equalTo(toolbar.snp.bottom)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(editChat.snp.top)
        }
    }
    
    override func keyboardShow(height: Double) {
        editChat.snp.remakeConstraints { make in
            make.leading.trailing.equalToSuperview()
            
            make.height.equalTo(60)
            
            make.bottom.equalToSuperview().offset(height * -1)
        }
    }
    
    override func keyboardHide() {
        editChat.snp.remakeConstraints { make in
            make.leading.trailing.equalToSuperview()
            
            make.height.equalTo(60)
            
            make.bottom.equalTo(view.safeArea.bottom)
        }
    }
}

extension ChatController: ChatDelegate {
    
}

class EditChatView: BaseView {
    
    private lazy var editContener: BaseView = {
        let view = BaseView()
        view.backgroundColor = .init(hex: "#F5F5F5")
        view.layer.cornerRadius = 10
        return view
    }()
    
    private lazy var textField: UITextField = {
        let view = UITextField()
        view.font = .systemFont(ofSize: 17)
        view.textColor = .init(hex: "#000000")
        view.placeholder = "Message"
        return view
    }()
    
    private lazy var fileImage: BaseImage = {
        return BaseImage(image: UIImage(named: "Send"))
    }()
    
    override func setupView() {
        backgroundColor = .init(hex: "#FFFFFF")
    }
    
    override func setupSubViews() {
        addSubview(editContener)
        editContener.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.bottom.equalToSuperview().offset(-8)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        editContener.addSubview(textField)
        textField.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            
            make.left.equalToSuperview().offset(13)
            
            make.right.equalToSuperview().offset(-40)
        }
        
        editContener.addSubview(fileImage)
        fileImage.snp.makeConstraints { make in
            make.width.height.equalTo(24)
            make.centerY.equalToSuperview()
            
            make.right.equalToSuperview().offset(-13)
        }
    }
}
