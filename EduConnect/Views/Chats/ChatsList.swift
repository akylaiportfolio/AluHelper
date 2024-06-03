//
//  ChatsList.swift
//  EduConnect
//
//  Created by Akylai Bekbolsunova on 20/4/24.
//

import UIKit
import SnapKit

class ChatsList: BaseView {
    
    private lazy var topGradient = GradientView(orintaion: .top)

    private lazy var tableView: UITableView = {
        let view = UITableView()
        view.delegate = self
        view.dataSource = self
        
        view.backgroundColor = .clear
        view.separatorStyle = .none
                
        view.register(ChatItem.self, forCellReuseIdentifier: "ChatItem")
        
        return view
    }()
    
    private lazy var notChat: EmptyNotView = {
        let view = EmptyNotView()
        view.title.text = "Chat not found"
        return view
    }()
    
    override func setupSubViews() {
        addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.bottom.left.right.equalToSuperview()
        }
        
        addSubview(topGradient)
        topGradient.snp.makeConstraints { make in
            make.top.equalToSuperview()
            
            make.left.right.equalToSuperview()
            
            make.height.equalTo(10)
        }
        
        addSubview(notChat)
        notChat.snp.makeConstraints { make in
            make.center.equalToSuperview()
            
            make.width.height.equalTo(86)
        }
    }
    
    var action: (() -> Void)? = nil
    
    func onItemTap(action: @escaping () -> Void) {
        self.action = action
    }
}

extension ChatsList: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatItem") as! ChatItem
        
        cell.onItemTap { [self] in
            action?()
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 76
    }
}

class ChatItem: BaseTableCell {
    
    private lazy var userImage: BaseImage = {
        let view = BaseImage()
        view.layer.cornerRadius = 28
        view.layer.masksToBounds = true
        view.backgroundColor = .init(hex: "#DDDDDD")
        return view
    }()
    
    private lazy var separator: BaseView = {
        let view = BaseView()
        view.backgroundColor = .init(hex: "#DDDDDD")
        return view
    }()
    
    private lazy var name: BaseLabel = {
        let view = BaseLabel()
        view.font = .systemFont(ofSize: 16, weight: .medium)
        view.textColor = .init(hex: "#000000")
        view.text = "Name"
        return view
    }()
    
    private lazy var time: BaseLabel = {
        let view = BaseLabel()
        view.font = .systemFont(ofSize: 13, weight: .regular)
        view.textColor = .init(hex: "#686868")
        view.text = "16:20"
        return view
    }()
    
    private lazy var nameMessage: BaseLabel = {
        let view = BaseLabel()
        view.font = .systemFont(ofSize: 13, weight: .regular)
        view.textColor = .init(hex: "#000000")
        view.text = "Eldar"
        return view
    }()
    
    private lazy var message: BaseLabel = {
        let view = BaseLabel()
        view.font = .systemFont(ofSize: 13, weight: .regular)
        view.textColor = .init(hex: "#686868")
        view.text = "Hi!"
        return view
    }()
    
    private lazy var tabContener = BaseView()
    
    override func setupView() {
        
    }
    
    override func setupSubViews() {
        addSubview(userImage)
        userImage.snp.makeConstraints { make in
            make.width.height.equalTo(56)
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(16)
        }
        
        addSubview(separator)
        separator.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-16)
            make.left.equalTo(userImage.snp.right).offset(10)
            make.bottom.equalToSuperview()
            make.height.equalTo(1)
        }
        
        addSubview(name)
        name.snp.makeConstraints { make in
            make.top.equalTo(userImage)
            make.left.equalTo(userImage.snp.right).offset(10)
        }
        
        addSubview(nameMessage)
        nameMessage.snp.makeConstraints { make in
            make.top.equalTo(name.snp.bottom).offset(2)
            make.left.equalTo(userImage.snp.right).offset(10)
        }
        
        addSubview(message)
        message.snp.makeConstraints { make in
            make.top.equalTo(nameMessage.snp.bottom)
            make.left.equalTo(userImage.snp.right).offset(10)
        }
        
        addSubview(time)
        time.snp.makeConstraints { make in
            make.centerY.equalTo(name)
            make.right.equalToSuperview().offset(-16)
        }
        
        addSubview(tabContener)
        tabContener.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    var action: (() -> Void)? = nil
    
    func onItemTap(action: @escaping () -> Void) {
        self.action = action
        
        tabContener.onTab {
            action()
        }
    }
}
