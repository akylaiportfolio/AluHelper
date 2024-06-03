//
//  BaseCollectionView.swift
//  EduConnect
//
//  Created by Akylai Bekbolsunova on 18/4/24.
//

import UIKit

class BaseCollectionViewCell: UICollectionViewCell {
    
    private var isCreate = false
    
    override func layoutSubviews() {
        if !isCreate {
            setupView()
            
            setupSubViews()
            
            isCreate = true
        }
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
