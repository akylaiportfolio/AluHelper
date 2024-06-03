//
//  GradientView.swift
//  EduConnect
//
//  Created by Akylai Bekbolsunova on 17/4/24.
//

import UIKit

class GradientView: BaseView {
    
    enum Orintation {
        case top
        case bottom
    }
    
    private var orintaion: Orintation
    
    init(orintaion: Orintation) {
        self.orintaion = orintaion

        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setupView() {
        let gradient = CAGradientLayer()
                
        switch orintaion {
        case .top:
            gradient.colors = [
                UIColor(hex: "#FFFFFF").cgColor,
                UIColor(hex: "#1AFFFFFF").cgColor
            ]
            
            gradient.locations = [0.0, 1.0]
        case .bottom:
            gradient.colors = [
                UIColor(hex: "#1AFFFFFF").cgColor,
                UIColor(hex: "#FFFFFF").cgColor
            ]
            
            gradient.locations = [0.0, 1.0]
        }
                
        gradient.frame = self.bounds
        
        self.layer.addSublayer(gradient)
    }
}
