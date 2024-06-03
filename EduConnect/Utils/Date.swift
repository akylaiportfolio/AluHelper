//
//  DAte.swift
//  EduConnect
//
//  Created by Akylai Bekbolsunova on 16/5/24.
//

import Foundation

extension Date {
    func isCurrent() -> Bool {
        let calendar = Calendar.current
        let currentDate = Date()
        let components = calendar.dateComponents([.year, .month, .day], from: self)
        let currentComponents = calendar.dateComponents([.year, .month, .day], from: currentDate)
        
        return components == currentComponents
    }
}
