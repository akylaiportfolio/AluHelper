//
//  ProfileUserView.swift
//  EduConnect
//
//  Created by Akylai Bekbolsunova on 17/5/24.
//

import Foundation

class ProfileUserView: BaseView {
    
    private lazy var logo: BaseImage = {
        let view = BaseImage()
        view.layer.cornerRadius = 25
        view.backgroundColor = .gray
        view.layer.masksToBounds = true
        return view
    }()
    
    override func setupView() {
        backgroundColor = .white
        layer.shadowOpacity = 0.1
        layer.shadowRadius = 3
        layer.shadowOffset = .zero

        layer.cornerRadius = 16
    }
    
    public lazy var nameView: BaseLabel = {
        let view = BaseLabel()
        view.textColor = .init(hex: "#000000")
        view.font = .systemFont(ofSize: 16, weight: .bold)
        return view
    }()
    
    public lazy var groupView: BaseLabel = {
        let view = BaseLabel()
        view.textColor = .init(hex: "#000000")
        view.font = .systemFont(ofSize: 14)
        return view
    }()
    
    lazy var changeView: BaseLabel = {
        let view = BaseLabel()
        view.textColor = .init(hex: "#973535")
        view.text = "Change"
        view.font = .systemFont(ofSize: 14, weight: .bold)
        return view
    }()
    
    override func setupSubViews() {
        addSubview(logo)
        logo.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.width.height.equalTo(50)
            make.top.bottom.equalToSuperview().inset(16)
        }
        
        addSubview(nameView)
        nameView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(22)
            make.left.equalTo(logo.snp.right).offset(10)
        }
        
        addSubview(groupView)
        groupView.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-22)
            make.left.equalTo(logo.snp.right).offset(10)
        }
        
        addSubview(changeView)
        changeView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-16)
        }
    }
    
    func fill(model: UserModel) {
        nameView.text = model.fullName
        
        if model.status == "admin" {
            groupView.text = "Administrator"
        } else if model.status == "teacher" {
            groupView.text = "Teacher"
        } else {
            groupView.text = "\(model.group)"
        }
        
        logo.kf.setImage(with: URL(string: model.avatar))
    }
}
