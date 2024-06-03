//
//  CardProfileItem.swift
//  EduConnect
//
//  Created by Akylai Bekbolsunova on 2/6/24.
//

import UIKit
import SnapKit

class CardProfileItem: BaseView {
    
    public lazy var imageView: BaseImage = {
        return BaseImage()
    }()
    
    public lazy var textView: BaseLabel = {
        let view = BaseLabel()
        view.textColor = .init(hex: "#000000")
        view.font = .systemFont(ofSize: 14, weight: .regular)
        return view
    }()
    
    public lazy var nextImage: BaseImage = {
        return BaseImage(image: .init(named: "LeftIcon"))
    }()
    
    override func setupView() {
        backgroundColor = .white
        layer.shadowOpacity = 0.1
        layer.shadowRadius = 3
        layer.shadowOffset = .zero

        layer.cornerRadius = 16
    }
    
    override func setupSubViews() {
        addSubview(nextImage)
        nextImage.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-20)
            make.width.height.equalTo(20)
        }
        
        addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(10)
            make.width.height.equalTo(20)
        }
        
        addSubview(textView)
        textView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(imageView.snp.right).offset(10)
        }
    }
}
