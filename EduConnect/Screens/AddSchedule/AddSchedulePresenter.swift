//
//  AddSchedulePresenter.swift
//  EduConnect
//
//  Created by Akylai Bekbolsunova on 4/6/24.
//

import Foundation

protocol AddScheduleDelegate: AnyObject {
    func showRoom(rooms: [String])
    
    func showTeacher(model: [UserModel])
    
    func showError(message: String)
    
    func showAdded()
}

class AddSchedulePresenter: BasePresenter<AddScheduleDelegate> {
    
    public var nameGroup = String()
    
    private let api = UserServices.shered

    public var startDate: Date? = nil
    public var endDate: Date? = nil
    
    public var teacher: UserModel? = nil
    public var weekday: Weekday? = nil

    func putLesson(name: String, cabinet: String) {
        if let startDate = startDate, let endDate = endDate, let teacher = teacher, let weekday = weekday {
            let formatter = DateFormatter()
            formatter.dateFormat = "HH:mm"
            
            let lesson = Lesson(
                title: name,
                teacher: teacher.uid,
                start: formatter.string(from: startDate),
                end: formatter.string(from: endDate),
                cabinet: cabinet,
                id: Int.random(in: 0 ..< Int.max)
            )
            
            api.getAllGroup { group in
                group.forEach { item in
                    var item = item
                    
                    if item.name == self.nameGroup {
                        if item.schedule == nil {
                            item.schedule = Schedule()
                        }
                        
                        switch weekday {
                        case .sunday:
                            if item.schedule?.sunday == nil {
                                item.schedule?.sunday = [lesson]
                            } else {
                                item.schedule?.sunday?.append(lesson)
                            }
                            
                        case .monday:
                            if item.schedule?.monday == nil {
                                item.schedule?.monday = [lesson]
                            } else {
                                item.schedule?.monday?.append(lesson)
                            }
                            
                        case .tuesday:
                            if item.schedule?.tuesday == nil {
                                item.schedule?.tuesday = [lesson]
                            } else {
                                item.schedule?.tuesday?.append(lesson)
                            }
                            
                        case .wednesday:
                            if item.schedule?.wednesday == nil {
                                item.schedule?.wednesday = [lesson]
                            } else {
                                item.schedule?.wednesday?.append(lesson)
                            }
                            
                        case .thursday:
                            if item.schedule?.thursday == nil {
                                item.schedule?.thursday = [lesson]
                            } else {
                                item.schedule?.thursday?.append(lesson)
                            }
                            
                        case .friday:
                            if item.schedule?.friday == nil {
                                item.schedule?.friday = [lesson]
                            } else {
                                item.schedule?.friday?.append(lesson)
                            }
                            
                        case .saturday:
                            if item.schedule?.saturday == nil {
                                item.schedule?.saturday = [lesson]
                            } else {
                                item.schedule?.saturday?.append(lesson)
                            }
                        }
                    
                        self.api.putGroup(name: self.nameGroup, group: item) {
                            self.delegate?.showAdded()
                        }
                    }
                }
            }
        } else {
            delegate?.showError(message: "Complete the lesson completely")
        }
    }
    
    func fetchRooms() {
        api.getRooms { [self] rooms in
            delegate?.showRoom(rooms: rooms)
        }
    }
    
    func fetchTeacher() {
        api.getAllUsers { users in
            let user = users?.filter { user in
                return user.status == "teacher"
            }
            
            if let user = user {
                self.delegate?.showTeacher(model: user)
            }
        }
    }
}
