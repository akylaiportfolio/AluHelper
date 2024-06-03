//
//  RoomsPresenter.swift
//  EduConnect
//
//  Created by Akylai Bekbolsunova on 4/6/24.
//

import Foundation

protocol RoomsDelegate: AnyObject {
    func showAllRooms(rooms: [String])
}

class RoomsPresenter: BasePresenter<RoomsDelegate> {
    
    private let api = UserServices.shered
    
    func fetchRooms() {
        api.getRooms { rooms in
            self.delegate?.showAllRooms(rooms: rooms)
        }
    }
    
    func addRooms(room: String) {
        api.getRooms { [self] rooms in
            var rooms = rooms
            
            if !rooms.contains(room) {
                rooms.append(room)
                
                api.putRooms(data: rooms) {
                    self.fetchRooms()
                }
            }
        }
    }
    
    func removeRooms(room: String) {
        api.getRooms { [self] rooms in
            var rooms = rooms.filter { item in
                return item != room
            }
            
            api.putRooms(data: rooms) {
                self.fetchRooms()
            }
        }
    }
}
