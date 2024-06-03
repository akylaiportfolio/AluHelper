//
//  SearchToolbar.swift
//  EduConnect
//
//  Created by Akylai Bekbolsunova on 21/4/24.
//

import UIKit
import SnapKit

class SearchToolbar: BaseView {
    
    public lazy var titleView: BaseLabel = {
        let view = BaseLabel()
        view.textColor = .init(hex: "#000000")
        view.font = .systemFont(ofSize: 16, weight: .bold)
        view.text = "Search"
        return view
    }()
    
    public lazy var back: BaseImage = {
        return BaseImage(image: UIImage(named: "Back"))
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
    }
}
