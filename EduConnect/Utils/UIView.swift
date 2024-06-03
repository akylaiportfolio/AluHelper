//
//  UIView.swift
//  EduConnect
//
//  Created by Akylai Bekbolsunova on 7/4/24.
//

import UIKit
import SnapKit

extension UIView {
    
    var safeArea: ConstraintBasicAttributesDSL {
#if swift(>=3.2)
        if #available(iOS 11.0, *) {
            return self.safeAreaLayoutGuide.snp
        }
        return self.snp
#else
        return self.snp
#endif
    }
    
    func hide(completion: @escaping () -> Void = {}) {
        isHidden = false
        alpha = 1
        
        UIView.animate(withDuration: 0.3) { [self] in
            alpha = 0
        } completion: { [self] _ in
            isHidden = true
            
            completion()
        }
    }
    
    func show(completion: @escaping () -> Void = {}) {
        isHidden = false
        alpha = 0
        
        UIView.animate(withDuration: 0.3) { [self] in
            alpha = 1
        } completion: { _ in
            completion()
        }
    }
}
