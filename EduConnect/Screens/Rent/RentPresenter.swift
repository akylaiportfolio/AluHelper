//
//  RentPresenter.swift
//  EduConnect
//
//  Created by Akylai Bekbolsunova on 2/6/24.
//

import Foundation

protocol RentDelegate: AnyObject {
    func showRents(model: [RentRoom])
}

class RentPresenter: BasePresenter<RentDelegate> {
    
    private var api = UserServices.shered

    func getAllRent() {
        api.getRentRoomData { rents in
            self.delegate?.showRents(model: rents)
        }
    }
    
    func removeRent(id: Int) {
        api.getRentRoomData { [self] rents in
            var rents = rents.filter { item in
                return item.id != id
            }
            
            api.putRentRoom(rents) {
                self.getAllRent()
            }
        }
    }
    
    func approveRent(id: Int) {
        api.getRentRoomData { [self] rents in
            var rent = rents.first { item in
                return item.id == id
            }
            
            rent?.status = "Approved"
            
            var rents = rents.filter { item in
                return item.id != id
            }
            
            if let rent = rent {
                rents.append(rent)
                
                api.putRentRoom(rents) {
                    self.getAllRent()
                }
            }
        }
    }
    
    func disableRent(id: Int) {
        api.getRentRoomData { [self] rents in
            var rent = rents.first { item in
                return item.id == id
            }
            
            rent?.status = "Disable"
            
            var rents = rents.filter { item in
                return item.id != id
            }
            
            if let rent = rent {
                rents.append(rent)
                
                api.putRentRoom(rents) {
                    self.getAllRent()
                }
            }
        }
    }
    
}
