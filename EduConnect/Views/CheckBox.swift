//
//  CheckBox.swift
//  EduConnect
//
//  Created by Akylai Bekbolsunova on 7/4/24.
//

import Foundation
import UIKit

class CheckBox: BaseImage {
    
    public var enable = false
    
    init() {
        super.init(frame: .zero)
        
        image = UIImage(named: "CheckBoxDisable")
        
        onTab { [self] in
            enable = !enable
            
            action(enable)
            
            if enable {
                image = UIImage(named: "CheckBoxEnable")
                
                show()
            } else {
                image = UIImage(named: "CheckBoxDisable")
                
                show()
            }
        }
    }
    
    private var action: (Bool) -> Void = { _ in}
    
    func onChange(action: @escaping (Bool) -> Void) {
        self.action = action
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
