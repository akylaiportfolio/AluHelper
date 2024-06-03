//
//  EmptySearchView.swift
//  EduConnect
//
//  Created by Akylai Bekbolsunova on 20/4/24.
//

import UIKit

class EmptySearchView: BaseView {
    
    public lazy var title: BaseTextField = {
        let view = BaseTextField()
        view.textColor = .init(hex: "#000000")
        view.font = .systemFont(ofSize: 15, weight: .regular)
        view.placeholder = "Search"
        view.isUserInteractionEnabled = false
        return view
    }()
    
    private lazy var searchImage = BaseImage(image: UIImage(named: "Search"))
    
    override func setupView() {
        layer.cornerRadius = 22.5
        
        layer.borderColor = UIColor(hex: "#DDDDDD").cgColor
        layer.borderWidth = 1
    }
    
    override func setupSubViews() {
        addSubview(title)
        title.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            
            make.left.equalToSuperview().offset(16)
            
            make.right.equalToSuperview().offset(60)
        }
        
        addSubview(searchImage)
        searchImage.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            
            make.right.equalToSuperview().offset(-16)

            make.width.height.equalTo(24)
        }
    }
}
