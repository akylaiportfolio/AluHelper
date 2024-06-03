//
//  BaseLabel.swift
//  EduConnect
//
//  Created by Akylai Bekbolsunova on 7/4/24.
//

import UIKit

class BaseLabel: UILabel {
    
    private var action: () -> Void = {}
    
    func onTab(action: @escaping () -> Void) {
        isUserInteractionEnabled = true
        
        self.action = action
        
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onClickEvent)))
    }
    
    @objc func onClickEvent() {
        animationShow()
        
        action()
    }
    
    func animationShow() {
        alpha = 0.2
        
        UIView.animate(withDuration: 0.3) { [self] in
            alpha = 1
        }
    }
}
