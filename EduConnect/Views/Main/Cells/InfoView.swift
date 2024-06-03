//
//  InfoView.swift
//  EduConnect
//
//  Created by Akylai Bekbolsunova on 18/4/24.
//

import Foundation

class InfoView: BaseTableCell {
    
    private lazy var title: BaseLabel = {
        let view = BaseLabel()
        view.font = .systemFont(ofSize: 15, weight: .medium)
        view.textColor = .init(hex: "#000000")
        return view
    }()
    
    private lazy var more: BaseLabel = {
        let view = BaseLabel()
        view.font = .systemFont(ofSize: 15, weight: .medium)
        view.textColor = .init(hex: "#973535")
        return view
    }()
    
    func fill(title: String, more: String?) {
        self.title.text = title
        
        if let more {
            self.more.text = more
        }
    }
    
    override func setupSubViews() {
        addSubview(title)
        title.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            
            make.leading.equalToSuperview().inset(16)
        }
        
        addSubview(more)
        more.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            
            make.trailing.equalToSuperview().inset(16)
        }
    }
}
