//
//  ChatToolbar.swift
//  EduConnect
//
//  Created by Akylai Bekbolsunova on 21/4/24.
//

import UIKit
import SnapKit

class ChatToolbar: BaseView {
    
    public lazy var titleView: BaseLabel = {
        let view = BaseLabel()
        view.textColor = .init(hex: "#000000")
        view.font = .systemFont(ofSize: 16, weight: .bold)
        view.text = "Eldar Akkozov"
        return view
    }()
    
    public lazy var back: BaseImage = {
        return BaseImage(image: UIImage(named: "Back"))
    }()
    
    private lazy var avatar: BaseImage = {
        let view = BaseImage()
        view.layer.cornerRadius = 22
        view.layer.masksToBounds = true
        view.backgroundColor = .init(hex: "#848484")
        return view
    }()
    
    override func setupSubViews() {
        addSubview(titleView)
        titleView.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        addSubview(back)
        back.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(16)
            make.width.height.equalTo(24)
        }
        
        addSubview(avatar)
        avatar.snp.makeConstraints { make in
            make.height.width.equalTo(44)
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-16)
        }
    }
}
