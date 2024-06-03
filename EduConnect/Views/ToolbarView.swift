//
//  ToolbarView.swift
//  EduConnect
//
//  Created by Akylai Bekbolsunova on 20/4/24.
//

import Foundation

class ToolbarView: BaseView {
    
    public lazy var titleView: BaseLabel = {
        let view = BaseLabel()
        view.textColor = .init(hex: "#000000")
        view.font = .systemFont(ofSize: 16, weight: .bold)
        return view
    }()
    
    public lazy var back: BaseImage = {
        let view = BaseImage(image: .init(named: "Back"))
        view.isHidden = true
        return view
    }()
    
    public lazy var added: BaseImage = {
        let view = BaseImage(image: .init(named: "Added"))
        view.isHidden = true
        return view
    }()
    
    override func setupSubViews() {
        addSubview(titleView)
        titleView.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        addSubview(back)
        back.snp.makeConstraints { make in
            make.width.height.equalTo(24)
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(16)
        }
        
        addSubview(added)
        added.snp.makeConstraints { make in
            make.width.height.equalTo(24)
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-16)
        }
    }
    
    func onTapAdded(action: @escaping () -> Void) {
        added.isHidden = false
        
        added.onTab {
            action()
        }
    }
    
    func onTapBack(action: @escaping () -> Void) {
        back.isHidden = false
        
        back.onTab {
            action()
        }
    }
}
