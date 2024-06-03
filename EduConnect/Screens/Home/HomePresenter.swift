//
//  StudentPresenter.swift
//  EduConnect
//
//  Created by Akylai Bekbolsunova on 18/4/24.
//

import Foundation

enum AllType {
    case schedule
    case orders
    case news
}

enum MainContentType {
    case info(title: String, more: String?, type: AllType)
    case schedule(lessons: [Lesson])
    case orders(orders: [OrderModel])
    case news(news: NewsModel)
}

protocol HomeDelegate: AnyObject {
    func showView(cells: [MainContentType])
    func showCurrentUser(model: UserModel)
}

class HomePresenter: BasePresenter<HomeDelegate> {
    
    private let userServices = UserServices.shered

    private var lessons: [Lesson]? = nil
    private var orders: [OrderModel]? = nil
    private var news: [NewsModel]? = nil

    private var weekday = String()
    
    func fecthData() {
        getCurrentUser()
        
        getGroup()
        
        getNews()
        
        getOrders()
    }
    
    func getCurrentUser() {
        if let model = userServices.getUser() {
            delegate?.showCurrentUser(model: model)
        }
    }
    
    func getGroup() {
        userServices.getMyGroup { [self] groups in
            switch getWeekday() {
            case .sunday:
                weekday = "Sunday"
                
                self.lessons = groups.schedule?.sunday ?? []
                
            case .monday:
                weekday = "Monday"

                self.lessons = groups.schedule?.monday ?? []

            case .tuesday:
                weekday = "Tuesday"

                self.lessons = groups.schedule?.tuesday ?? []

            case .wednesday:
                weekday = "Wednesday"

                self.lessons = groups.schedule?.wednesday ?? []

            case .thursday:
                weekday = "Thursday"

                self.lessons = groups.schedule?.thursday ?? []

            case .friday:
                weekday = "Friday"

                self.lessons = groups.schedule?.friday ?? []

            case .saturday:
                weekday = "Saturday"

                self.lessons = groups.schedule?.saturday ?? []
            }
            
            showCell()
        }
    }
    
    func getOrders() {
        userServices.getAllOrder { [self] orders in
            self.orders = orders
            
            showCell()
        }
    }
    
    func getNews() {
        userServices.getAllNews { [self] news in
            self.news = news
            
            showCell()
        }
    }
    
    func showCell() {
        if let orders = orders, let news = news, let lessons = lessons {
            var cell: [MainContentType] = []
            
            if UserServices.shered.getUser()?.status == "admin" {
                cell = [
                    .info(title: "Orders", more: "All", type: .orders),
                    .orders(orders: orders),
                    .info(title: "News", more: "All", type: .news),
                ]
            } else {
                cell = [
                    .info(title: "Schedule (\(weekday))", more: "All", type: .schedule),
                    .schedule(lessons: lessons),
                    .info(title: "Orders", more: "All", type: .orders),
                    .orders(orders: orders),
                    .info(title: "News", more: "All", type: .news),
                ]
            }
            
            news.enumerated().forEach { (index, item) in
                if UserServices.shered.getUser()?.status == "admin" {
                    if index < 5 {
                        cell.append(.news(news: item))
                    }
                } else {
                    if index < 3 {
                        cell.append(.news(news: item))
                    }
                }
            }
            
            delegate?.showView(cells: cell)
        }
    }
}
