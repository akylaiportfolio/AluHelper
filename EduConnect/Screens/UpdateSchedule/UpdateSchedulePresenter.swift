//
//  SchedulePresenter.swift
//  EduConnect
//
//  Created by Akylai Bekbolsunova on 16/5/24.
//

import Foundation

protocol UpdateScheduleDelegate: AnyObject {
    func showSchedule(lession: [Lesson])
}

class UpdateSchedulePresenter: BasePresenter<UpdateScheduleDelegate> {
    
    private let api = UserServices.shered
    
    var name: String = ""
    
    lazy var current: Weekday = getWeekday()
    
    private var groupModel: GroupModel? = nil
    
    func selectWeekend(model: Weekday) {
        current = model
        
        switch model {
        case .sunday:
            if let lession = groupModel?.schedule?.sunday {
                delegate?.showSchedule(lession: lession)
            } else {
                delegate?.showSchedule(lession: [])
            }
        case .monday:
            if let lession = groupModel?.schedule?.monday {
                delegate?.showSchedule(lession: lession)
            } else {
                delegate?.showSchedule(lession: [])
            }
        case .tuesday:
            if let lession = groupModel?.schedule?.tuesday {
                delegate?.showSchedule(lession: lession)
            } else {
                delegate?.showSchedule(lession: [])
            }
        case .wednesday:
            if let lession = groupModel?.schedule?.wednesday {
                delegate?.showSchedule(lession: lession)
            } else {
                delegate?.showSchedule(lession: [])
            }
        case .thursday:
            if let lession = groupModel?.schedule?.thursday {
                delegate?.showSchedule(lession: lession)
            } else {
                delegate?.showSchedule(lession: [])
            }
        case .friday:
            if let lession = groupModel?.schedule?.friday {
                delegate?.showSchedule(lession: lession)
            } else {
                delegate?.showSchedule(lession: [])
            }
        case .saturday:
            if let lession = groupModel?.schedule?.saturday {
                delegate?.showSchedule(lession: lession)
            } else {
                delegate?.showSchedule(lession: [])
            }
        }
    }
    
    func deleteLession(lesson: Lesson) {
        var grout = groupModel
        
        if var group = grout {
            var group: GroupModel = group
            
            switch current {
            case .sunday:
                let lesson = group.schedule?.sunday?.filter { item in
                    return item.id != lesson.id
                }
                
                group.schedule?.sunday = lesson
                
            case .monday:
                let lesson = group.schedule?.monday?.filter { item in
                    return item.id != lesson.id
                }
                
                group.schedule?.monday = lesson
                
            case .tuesday:
                let lesson = group.schedule?.tuesday?.filter { item in
                    return item.id != lesson.id
                }
                
                group.schedule?.tuesday = lesson
                
            case .wednesday:
                let lesson = group.schedule?.wednesday?.filter { item in
                    return item.id != lesson.id
                }
                
                group.schedule?.wednesday = lesson
                
            case .thursday:
                let lesson = group.schedule?.thursday?.filter { item in
                    return item.id != lesson.id
                }
                
                group.schedule?.thursday = lesson
                
            case .friday:
                let lesson = group.schedule?.friday?.filter { item in
                    return item.id != lesson.id
                }
                
                group.schedule?.friday = lesson
                
            case .saturday:
                let lesson = group.schedule?.saturday?.filter { item in
                    return item.id != lesson.id
                }
                
                group.schedule?.saturday = lesson
                
            }
            
            api.putGroup(name: name, group: group) {
                
            }
        }
    }
    
    func fetchData() {
        api.getFromNameGroup(name: name) { [self] group in
            groupModel = group
            
            switch current {
            case .sunday:
                if let lession = groupModel?.schedule?.sunday {
                    delegate?.showSchedule(lession: lession)
                } else {
                    delegate?.showSchedule(lession: [])
                }
            case .monday:
                if let lession = groupModel?.schedule?.monday {
                    delegate?.showSchedule(lession: lession)
                } else {
                    delegate?.showSchedule(lession: [])
                }
            case .tuesday:
                if let lession = groupModel?.schedule?.tuesday {
                    delegate?.showSchedule(lession: lession)
                } else {
                    delegate?.showSchedule(lession: [])
                }
            case .wednesday:
                if let lession = groupModel?.schedule?.wednesday {
                    delegate?.showSchedule(lession: lession)
                } else {
                    delegate?.showSchedule(lession: [])
                }
            case .thursday:
                if let lession = groupModel?.schedule?.thursday {
                    delegate?.showSchedule(lession: lession)
                } else {
                    delegate?.showSchedule(lession: [])
                }
            case .friday:
                if let lession = groupModel?.schedule?.friday {
                    delegate?.showSchedule(lession: lession)
                } else {
                    delegate?.showSchedule(lession: [])
                }
            case .saturday:
                if let lession = groupModel?.schedule?.saturday {
                    delegate?.showSchedule(lession: lession)
                } else {
                    delegate?.showSchedule(lession: [])
                }
            }
        }
    }
}
