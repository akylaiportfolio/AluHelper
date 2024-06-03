//
//  SelectorView.swift
//  EduConnect
//
//  Created by Akylai Bekbolsunova on 20/4/24.
//

import Foundation
import UIKit

class SelectorView: BaseView {
    
    private lazy var chats: SelectorItem = {
        let view = SelectorItem()
        view.title.text = "Chats"
        return view
    }()
    
    private lazy var group: SelectorItem = {
        let view = SelectorItem()
        view.title.text = "Group"
        return view
    }()
    
    override func setupView() {
        layer.cornerRadius = 22.5
        
        layer.borderColor = UIColor(hex: "#5068BD").cgColor
        layer.borderWidth = 1
        
        chats.onTab { [self] in
            chats.active()
            
            group.disable()
        }
        
        group.onTab { [self] in
            chats.disable()
            
            group.active()
        }
    }
    
    override func setupSubViews() {
        addSubview(chats)
        chats.snp.makeConstraints { make in
            make.height.equalTo(35)
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(5)
            make.width.equalTo((UIScreen.main.bounds.width / 2) - 20)
        }
        
        addSubview(group)
        group.snp.makeConstraints { make in
            make.height.equalTo(35)
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-5)
            make.width.equalTo((UIScreen.main.bounds.width / 2) - 20)
        }
        
        DispatchQueue.main.async { [self] in
            chats.backgroundColor = .init(hex: "5068BD")
            
            chats.title.textColor = .init(hex: "#FFFFFF")
        }
    }
}

class SelectorItem: BaseView {
    
    public lazy var title: BaseLabel = {
        let view = BaseLabel()
        view.font = .systemFont(ofSize: 15, weight: .medium)
        return view
    }()
    
    override func setupView() {
        layer.cornerRadius = 17.5
        backgroundColor = .clear
        
        title.textColor = .init(hex: "#000000")
    }
    
    override func setupSubViews() {
        addSubview(title)
        title.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    func active() {
        UIView.animate(withDuration: 0.3) { [self] in
            backgroundColor = .init(hex: "5068BD")
            
            title.textColor = .init(hex: "#FFFFFF")
        }
    }
    
    func disable() {
        UIView.animate(withDuration: 0.3) { [self] in
            backgroundColor = .clear
            
            title.textColor = .init(hex: "#000000")
        }
    }
}
