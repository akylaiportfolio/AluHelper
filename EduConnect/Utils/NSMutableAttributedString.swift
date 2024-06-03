//
//  NSMutableAttributedString.swift
//  EduConnect
//
//  Created by Akylai Bekbolsunova on 7/4/24.
//

import Foundation
import UIKit

extension NSMutableAttributedString {
    
    func changeColor(_ text: String, of color: String, hex: String) {
        let range = (string as NSString).range(of: color)
        
        addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor(hex: hex), range: range)
    }
}
