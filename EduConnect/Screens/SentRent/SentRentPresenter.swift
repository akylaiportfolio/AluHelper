//
//  SentRentPresenter.swift
//  EduConnect
//
//  Created by Akylai Bekbolsunova on 2/6/24.
//

import Foundation

protocol SentRentDelegate: AnyObject {
    func showRoom(rooms: [String])
    
    func showErrorAlert(message: String)
    
    func showSendRent()
}

class SentRentPresenter: BasePresenter<SentRentDelegate> {
    
    private let api = UserServices.shered
    
    public var startDate: Date? = nil
    public var endDate: Date? = nil
    
    func fetchRooms() {
        api.getRooms { [self] rooms in
            delegate?.showRoom(rooms: rooms)
        }
    }
    
    func sendRent(room: String, message: String) {
        if !room.isEmpty,
           !message.isEmpty,
           let startDate = startDate,
           let endDate = endDate {
            
            let formatter = DateFormatter()
            formatter.dateFormat = "dd.MM.yyyy HH:mm"
            
            let model = RentRoom(
                id: Int.random(in: 0 ..< Int.max),
                uid: api.getUser()?.uid ?? "",
                room: room,
                message: message,
                startTime: formatter.string(from: startDate),
                endTime: formatter.string(from: endDate),
                status: "Pending"
            )
            
            api.getRentRoomData { [self] rents in
                var models = rents
                
                models.append(model)
                
                api.putRentRoom(models) { [self] in
                    self.delegate?.showSendRent()
                }
            }
            
        } else {
            delegate?.showErrorAlert(message: "Completely fill out the application for booking rooms")
        }
    }
}
