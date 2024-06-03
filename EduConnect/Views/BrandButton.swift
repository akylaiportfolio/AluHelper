//
//  BrandButton.swift
//  EduConnect
//
//  Created by Akylai Bekbolsunova on 7/4/24.
//

import UIKit

class BrandButton: BaseView {
    
    private lazy var titleView: BaseLabel = {
        let view = BaseLabel()
        view.textColor = .init(hex: "#FFFFFF")
        view.font = .systemFont(ofSize: 16, weight: .medium)
        return view
    }()
    
    override func setupView() {
        layer.cornerRadius = 10
    }
    
    override func setupSubViews() {
        addSubview(titleView)
        titleView.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    public var state: Bool = true
    
    func setTitle(_ text: String) {
        titleView.text = text
    }
    
    func setEnable(_ state: Bool) {
        self.state = state
        
        UIView.animate(withDuration: 0.2) { [self] in
            if state {
                titleView.textColor = .init(hex: "#FFFFFF")
                
                backgroundColor = .init(hex: "#973535")
            } else {
                titleView.textColor = .init(hex: "#5C5C5C")
                
                backgroundColor = .init(hex: "#DDDDDD")
            }
        }
    }
    
    func onEnableTab(action: @escaping () -> Void) {
        onTab { [self] in
            animationShow()
            
            if state {
                action()
            }
        }
    }
    
    func animationShow() {
        alpha = 0.2
        
        UIView.animate(withDuration: 0.3) { [self] in
            alpha = 1
        }
    }
}
