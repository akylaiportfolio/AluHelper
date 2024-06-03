//
//  SchedulePresenter.swift
//  EduConnect
//
//  Created by Akylai Bekbolsunova on 16/5/24.
//

import Foundation

protocol ScheduleDelegate: AnyObject {
    func showSchedule(lession: [Lesson])
}

class SchedulePresenter: BasePresenter<ScheduleDelegate> {
    
    private let api = UserServices.shered
    
    lazy var current: Weekday = getWeekday()
    
    private var groupModel: GroupModel? = nil
    
    func selectWeekend(model: Weekday) {
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
    
    func fetchData() {
        api.getMyGroup { [self] group in
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
