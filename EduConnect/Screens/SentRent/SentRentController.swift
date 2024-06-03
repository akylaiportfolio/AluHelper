//
//  SentRentController.swift
//  EduConnect
//
//  Created by Akylai Bekbolsunova on 2/6/24.
//

import UIKit
import SnapKit

class SentRentController: BaseController<SentRentPresenter> {
    
    private lazy var toolbar: ToolbarView = {
        let view = ToolbarView()
        view.titleView.text = "Send office rental"
        return view
    }()
    
    private lazy var titleField: ContenerEditField = {
        let view = ContenerEditField()
        
        view.setTitle(text: "Room")
        
        view.editField.placeholder = "Room"
        view.editField.isUserInteractionEnabled = false
        view.editField.autocapitalizationType = .none
        return view
    }()
    
    private lazy var messageField: ContenerEditField = {
        let view = ContenerEditField()
        
        view.setTitle(text: "Message")
        
        view.editField.placeholder = "Massage"
        view.editField.autocapitalizationType = .none
        return view
    }()
    
    private lazy var timeStartField: ContenerEditField = {
        let view = ContenerEditField()
        
        view.setTitle(text: "Start rent time")
        
        view.editField.placeholder = "DD/MM/YYYY HH:MM"
        view.editField.isUserInteractionEnabled = false
        view.editField.autocapitalizationType = .none
        return view
    }()
    
    private lazy var endTimeField: ContenerEditField = {
        let view = ContenerEditField()
        
        view.setTitle(text: "End rent time")
        
        view.editField.placeholder = "DD/MM/YYYY HH:MM"
        view.editField.isUserInteractionEnabled = false
        view.editField.autocapitalizationType = .none
        return view
    }()
    
    private lazy var send: BrandButton = {
        let view = BrandButton()
        view.setEnable(true)
        view.setTitle("Send office rental")
        return view
    }()
        
    override func setupController() {
        toolbar.onTapBack { self.router?.back() }
        
        if UserServices.shered.getUser()?.status == "admin" {
            toolbar.onTapAdded {
                self.router?.open(RoomsBuilder.create())
            }
        }
        
        send.onEnableTab { [self] in
            presenter?.sendRent(
                room: titleField.editField.text ?? "",
                message: messageField.editField.text ?? ""
            )
        }
        
        titleField.onTab { [self] in
            presenter?.fetchRooms()
        }
        
        timeStartField.onTab { [self] in
            let myDatePicker: UIDatePicker = UIDatePicker()
            myDatePicker.timeZone = .current
            myDatePicker.datePickerMode = .dateAndTime
            myDatePicker.preferredDatePickerStyle = .wheels
            myDatePicker.frame = CGRect(x: 0, y: 15, width: 270, height: 200)
            let alertController = UIAlertController(title: "\n\n\n\n\n\n\n\n", message: nil, preferredStyle: .alert)
            alertController.view.addSubview(myDatePicker)
            let selectAction = UIAlertAction(title: "Ok", style: .default, handler: { _ in
                let formatter = DateFormatter()
                formatter.dateFormat = "dd.MM.yyyy HH:mm"
                
                self.presenter?.endDate = nil
                self.presenter?.startDate = myDatePicker.date
                
                self.endTimeField.editField.text = ""
                self.timeStartField.editField.text = formatter.string(from: myDatePicker.date)
            })
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            alertController.addAction(selectAction)
            alertController.addAction(cancelAction)
            present(alertController, animated: true)
        }
        
        endTimeField.onTab { [self] in
            if presenter?.startDate != nil {
                let myDatePicker: UIDatePicker = UIDatePicker()
                myDatePicker.timeZone = .current
                myDatePicker.datePickerMode = .dateAndTime
                myDatePicker.minimumDate = presenter?.startDate
                myDatePicker.maximumDate = (presenter?.startDate ?? Date()) + (3600 * 24)
                myDatePicker.preferredDatePickerStyle = .wheels
                myDatePicker.frame = CGRect(x: 0, y: 15, width: 270, height: 200)
                let alertController = UIAlertController(title: "\n\n\n\n\n\n\n\n", message: nil, preferredStyle: .alert)
                alertController.view.addSubview(myDatePicker)
                let selectAction = UIAlertAction(title: "Ok", style: .default, handler: { _ in
                    let formatter = DateFormatter()
                    formatter.dateFormat = "dd.MM.yyyy HH:mm"
                    
                    self.presenter?.endDate = myDatePicker.date
                    
                    self.endTimeField.editField.text = formatter.string(from: myDatePicker.date)
                })
                let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
                alertController.addAction(selectAction)
                alertController.addAction(cancelAction)
                present(alertController, animated: true)
            } else {
                let controller = UIAlertController(title: "Select start date", message: nil, preferredStyle: .alert)
                
                controller.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                
                present(controller, animated: true)
            }
        }
    }
    
    override func setupSubViews() {
        view.addSubview(toolbar)
        toolbar.snp.makeConstraints { make in
            make.top.equalTo(view.safeArea.top)
            make.left.right.equalToSuperview()
            make.height.equalTo(53)
        }
        
        view.addSubview(titleField)
        titleField.snp.makeConstraints { make in
            make.top.equalTo(toolbar.snp.bottom).offset(10)
            make.left.right.equalToSuperview().inset(16)
            make.height.equalTo(64)
        }
        
        view.addSubview(messageField)
        messageField.snp.makeConstraints { make in
            make.top.equalTo(titleField.snp.bottom).offset(8)
            make.left.right.equalToSuperview().inset(16)
            make.height.equalTo(64)
        }
        
        view.addSubview(timeStartField)
        timeStartField.snp.makeConstraints { make in
            make.top.equalTo(messageField.snp.bottom).offset(8)
            make.left.right.equalToSuperview().inset(16)
            make.height.equalTo(64)
        }
        
        view.addSubview(endTimeField)
        endTimeField.snp.makeConstraints { make in
            make.top.equalTo(timeStartField.snp.bottom).offset(8)
            make.left.right.equalToSuperview().inset(16)
            make.height.equalTo(64)
        }
        
        view.addSubview(send)
        send.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeArea.bottom).offset(-8)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(45)
        }
    }
}

extension SentRentController: SentRentDelegate {
    func showErrorAlert(message: String) {
        let controller = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        
        controller.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        present(controller, animated: true)
    }
    
    func showSendRent() {
        let controller = UIAlertController(title: "Your application has been successfully sent", message: nil, preferredStyle: .alert)
        
        controller.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
            self.router?.back()
        }))
        
        present(controller, animated: true)
    }
    
    func showRoom(rooms: [String]) {
        let controller = UIAlertController(title: "Select room", message: nil, preferredStyle: .actionSheet)
        
        rooms.forEach { item in
            controller.addAction(UIAlertAction(title: item, style: .default, handler: { action in
                self.titleField.editField.text = action.title
            }))
        }
        
        controller.addAction(UIAlertAction(title: "Cansel", style: .destructive, handler: nil))
        
        present(controller, animated: true)
    }
    
    
}
