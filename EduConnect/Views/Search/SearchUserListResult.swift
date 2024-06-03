//
//  SearchUserListResult.swift
//  EduConnect
//
//  Created by Akylai Bekbolsunova on 21/4/24.
//

import Foundation
import UIKit
import Kingfisher

class SearchUserListResult: BaseView {
    
    private lazy var tableView: UITableView = {
        let view = UITableView()
        view.delegate = self
        view.dataSource = self
        
        view.backgroundColor = .clear
        view.separatorStyle = .none
                
        view.register(SearchUserListResultItem.self, forCellReuseIdentifier: "SearchUserListResultItem")
        
        return view
    }()
    
    override func setupSubViews() {
        addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.bottom.left.right.equalToSuperview()
        }
    }
    
    var models: [UserModel] = []
    
    func fill(models: [UserModel]) {
        self.models = models
        
        tableView.reloadData()
    }
}

extension SearchUserListResult: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchUserListResultItem") as! SearchUserListResultItem
        
        cell.fill(models[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}

class SearchUserListResultItem: BaseTableCell {
    
    private lazy var userImage: BaseImage = {
        let view = BaseImage()
        view.layer.cornerRadius = 25
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
        view.font = .systemFont(ofSize: 16, weight: .bold)
        view.textColor = .init(hex: "#000000")
        return view
    }()
    
    private lazy var nameMessage: BaseLabel = {
        let view = BaseLabel()
        view.font = .systemFont(ofSize: 16, weight: .regular)
        view.textColor = .init(hex: "#000000")
        return view
    }()
    
    private lazy var tabContener = BaseView()
    
    override func setupView() {
        
    }
    
    override func setupSubViews() {
        addSubview(userImage)
        userImage.snp.makeConstraints { make in
            make.width.height.equalTo(50)
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
            make.top.equalTo(userImage).offset(5)
            make.left.equalTo(userImage.snp.right).offset(10)
        }
        
        addSubview(nameMessage)
        nameMessage.snp.makeConstraints { make in
            make.bottom.equalTo(userImage.snp.bottom).offset(-5)
            make.left.equalTo(userImage.snp.right).offset(10)
        }
        
        addSubview(tabContener)
        tabContener.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func fill(_ model: UserModel) {
        userImage.kf.setImage(with: URL(string: model.avatar))
        
        name.text = model.fullName
        nameMessage.text = model.group
    }
    
    var action: (() -> Void)? = nil
    
    func onItemTap(action: @escaping () -> Void) {
        self.action = action
        
        tabContener.onTab {
            action()
        }
    }
}
