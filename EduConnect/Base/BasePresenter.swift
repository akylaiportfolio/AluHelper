//
//  BasePresenter.swift
//  EduConnect
//
//  Created by Akylai Bekbolsunova on 7/4/24.
//

import Foundation

enum Weekday: Int {
    case sunday = 1
    case monday = 2
    case tuesday = 3
    case wednesday = 4
    case thursday = 5
    case friday = 6
    case saturday = 7
    
    static func list() -> [Weekday] {
        return [
            .sunday,
            .monday,
            .tuesday,
            .wednesday,
            .thursday,
            .friday,
            .saturday
        ]
    }
    
    func getName() -> String {
        switch self {
        case .sunday:
            return "Sun"
        case .monday:
            return "Mon"
        case .tuesday:
            return "Tue"
        case .wednesday:
            return "Wed"
        case .thursday:
            return "Thu"
        case .friday:
            return "Fri"
        case .saturday:
            return "Sat"
        
        }
    }
    
    static func getWeekdayFromName(name: String) -> Weekday {
        switch name {
        case "Sun":
            return .sunday
        case "Mon":
            return .monday
        case "Tue":
            return .tuesday
        case "Wed":
            return .wednesday
        case "Thu":
            return .thursday
        case "Fri":
            return .friday
        case "Sat":
            return .saturday
        default:
            return .wednesday
        }
    }
}

class BasePresenter<T> {
    var delegate: T? = nil
    
    init(delegate: T) {
        self.delegate = delegate
    }
    
    func getWeekday() -> Weekday {
        var weekday = Calendar.current.component(.weekday, from: Date())
        let hour = Calendar.current.component(.hour, from: Date())
        
        if hour > 18 {
            if weekday == 7 {
                weekday = 1
            } else {
                weekday = weekday + 1
            }
        }
        
        switch weekday {
        case 1:
            return .sunday
        case 2:
            return .monday
        case 3:
            return .tuesday
        case 4:
            return .wednesday
        case 5:
            return .thursday
        case 6:
            return .friday
        case 7:
            return .saturday
        default:
            return .sunday
        }
    }
}
