//
//  BaseView.swift
//  EduConnect
//
//  Created by Akylai Bekbolsunova on 7/4/24.
//

import UIKit

class BaseView: UIView {
 
    override func layoutSubviews() {
        setupView()
        
        setupSubViews()
    }
    
    func setupView() {
        
    }
    
    func setupSubViews() {
        
    }
    
    private var action: () -> Void = {}
    
    func onTab(action: @escaping () -> Void) {
        isUserInteractionEnabled = true
        
        self.action = action
        
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onClickEvent)))
    }
    
    @objc func onClickEvent() {
        action()
    }
}
