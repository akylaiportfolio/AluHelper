//
//  UserToolbar.swift
//  EduConnect
//
//  Created by Akylai Bekbolsunova on 18/4/24.
//

import UIKit
import SnapKit
import Kingfisher

class UserToolbar: BaseView {
        
    private lazy var avatar: BaseImage = {
        let view = BaseImage()
        view.layer.cornerRadius = 17.5
        view.layer.masksToBounds = true
        view.backgroundColor = .init(hex: "#848484")
        return view
    }()
    
    private lazy var welcomeLabel: BaseLabel = {
        let view = BaseLabel()
        view.textColor = .init(hex: "#000000")
        view.font = .systemFont(ofSize: 13, weight: .thin)
        view.text = "Welcome"
        return view
    }()
    
    private lazy var nameLabel: BaseLabel = {
        let view = BaseLabel()
        view.textColor = .init(hex: "#000000")
        view.font = .systemFont(ofSize: 13, weight: .medium)
        view.text = "Akilay Bekbolsunova"
        return view
    }()
    
    func fill(model: UserModel) {
        if UserServices.shered.getUser()?.status == "admin" {
            nameLabel.text = "\(model.fullName) (Administrator)"
        } else if UserServices.shered.getUser()?.status == "teacher" {
            nameLabel.text = "\(model.fullName) (Teacher)"
        } else {
            nameLabel.text = "\(model.fullName) (\(model.group))"
        }
        
        avatar.kf.setImage(with: URL(string: model.avatar))
    }
    
    override func setupSubViews() {
        addSubview(avatar)
        avatar.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.height.width.equalTo(35)
            make.leading.equalToSuperview().inset(16)
        }
        
        addSubview(welcomeLabel)
        welcomeLabel.snp.makeConstraints { make in
            make.top.equalTo(avatar.snp.top).offset(2)
            make.leading.equalTo(avatar.snp.trailing).inset(-8)
        }
        
        addSubview(nameLabel)
        nameLabel.snp.makeConstraints { make in
            make.bottom.equalTo(avatar.snp.bottom).offset(-2)
            make.leading.equalTo(avatar.snp.trailing).inset(-8)
        }
    }
}
