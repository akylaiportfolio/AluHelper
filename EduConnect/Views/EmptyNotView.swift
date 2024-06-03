//
//  EmptyView.swift
//  EduConnect
//
//  Created by Akylai Bekbolsunova on 21/4/24.
//

import Foundation
import UIKit

class EmptyNotView: BaseView {
    
    public lazy var title: BaseLabel = {
        let view = BaseLabel()
        view.textColor = .init(hex: "#CDCDCD")
        view.font = .systemFont(ofSize: 13, weight: .bold)
        return view
    }()
    
    private lazy var image = BaseImage(image: UIImage(named: "Empty"))
    
    override func setupSubViews() {
        addSubview(image)
        image.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.width.height.equalTo(74)
        }
        
        addSubview(title)
        title.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.centerX.equalToSuperview()
        }
    }
}
