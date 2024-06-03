//
//  AddScheduleController.swift
//  EduConnect
//
//  Created by Akylai Bekbolsunova on 4/6/24.
//

import UIKit
import SnapKit

class AddScheduleController: BaseController<AddSchedulePresenter> {
    
    private lazy var toolbar: ToolbarView = {
        let view = ToolbarView()
        view.titleView.text = "Add schedule"
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
        
        view.setTitle(text: "Name")
        
        view.editField.placeholder = "Name"
        view.editField.autocapitalizationType = .none
        return view
    }()
    
    private lazy var timeStartField: ContenerEditField = {
        let view = ContenerEditField()
        
        view.setTitle(text: "Start lesson time")
        
        view.editField.placeholder = "HH:MM"
        view.editField.isUserInteractionEnabled = false
        view.editField.autocapitalizationType = .none
        return view
    }()
    
    private lazy var endTimeField: ContenerEditField = {
        let view = ContenerEditField()
        
        view.setTitle(text: "End lesson time")
        
        view.editField.placeholder = "HH:MM"
        view.editField.isUserInteractionEnabled = false
        view.editField.autocapitalizationType = .none
        return view
    }()
    
    private lazy var weekdayField: ContenerEditField = {
        let view = ContenerEditField()
        
        view.setTitle(text: "Weekday")
        
        view.editField.placeholder = "Weekday"
        view.editField.isUserInteractionEnabled = false
        view.editField.autocapitalizationType = .none
        return view
    }()
    
    private lazy var teacherField: ContenerEditField = {
        let view = ContenerEditField()
        
        view.setTitle(text: "Teacher")
        
        view.editField.placeholder = "Teacher"
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
        
        weekdayField.onTab { [self] in
            let controller = UIAlertController(title: "Select room", message: nil, preferredStyle: .actionSheet)
            
            Weekday.list().forEach { item in
                controller.addAction(UIAlertAction(title: item.getName(), style: .default, handler: { action in
                    self.presenter?.weekday = item
                    
                    self.weekdayField.editField.text = action.title
                }))
            }
            
            controller.addAction(UIAlertAction(title: "Cansel", style: .destructive, handler: nil))
            
            present(controller, animated: true)
        }
        
        send.onEnableTab { [self] in
            if messageField.editField.text?.isEmpty == false && titleField.editField.text?.isEmpty == false {
                presenter?.putLesson(
                    name: messageField.editField.text ?? "",
                    cabinet: titleField.editField.text ?? ""
                )
            } else {
                showError(message: "Complete the lesson completely")
            }
        }
        
        titleField.onTab { [self] in
            presenter?.fetchRooms()
        }
        
        teacherField.onTab {
            self.presenter?.fetchTeacher()
        }
        
        timeStartField.onTab { [self] in
            let myDatePicker: UIDatePicker = UIDatePicker()
            myDatePicker.timeZone = .current
            myDatePicker.datePickerMode = .time
            myDatePicker.preferredDatePickerStyle = .wheels
            myDatePicker.frame = CGRect(x: 0, y: 15, width: 270, height: 200)
            let alertController = UIAlertController(title: "\n\n\n\n\n\n\n\n", message: nil, preferredStyle: .alert)
            alertController.view.addSubview(myDatePicker)
            let selectAction = UIAlertAction(title: "Ok", style: .default, handler: { _ in
                let formatter = DateFormatter()
                formatter.dateFormat = "HH:mm"
                
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
                myDatePicker.datePickerMode = .time
                myDatePicker.minimumDate = presenter?.startDate
                myDatePicker.maximumDate = (presenter?.startDate ?? Date()) + (3600 * 24)
                myDatePicker.preferredDatePickerStyle = .wheels
                myDatePicker.frame = CGRect(x: 0, y: 15, width: 270, height: 200)
                let alertController = UIAlertController(title: "\n\n\n\n\n\n\n\n", message: nil, preferredStyle: .alert)
                alertController.view.addSubview(myDatePicker)
                let selectAction = UIAlertAction(title: "Ok", style: .default, handler: { _ in
                    let formatter = DateFormatter()
                    formatter.dateFormat = "HH:mm"
                    
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
        
        view.addSubview(weekdayField)
        weekdayField.snp.makeConstraints { make in
            make.top.equalTo(endTimeField.snp.bottom).offset(8)
            make.left.right.equalToSuperview().inset(16)
            make.height.equalTo(64)
        }
        
        view.addSubview(teacherField)
        teacherField.snp.makeConstraints { make in
            make.top.equalTo(weekdayField.snp.bottom).offset(8)
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

extension AddScheduleController: AddScheduleDelegate {
    func showError(message: String) {
        let controller = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        
        controller.addAction(UIAlertAction(title: "OK", style: .destructive, handler: nil))
        
        present(controller, animated: true)
    }
    
    func showAdded() {
        let controller = UIAlertController(title: "You have successfully added a lesson", message: nil, preferredStyle: .alert)
        
        controller.addAction(UIAlertAction(title: "OK", style: .destructive, handler: { _ in
            self.router?.back()
        }))
        
        present(controller, animated: true)
    }
    
    func showTeacher(model: [UserModel]) {
        let controller = UIAlertController(title: "Select teacher", message: nil, preferredStyle: .actionSheet)
        
        model.forEach { item in
            self.presenter?.teacher = item
            
            controller.addAction(UIAlertAction(title: item.fullName, style: .default, handler: { action in
                self.teacherField.editField.text = item.fullName
            }))
        }
        
        controller.addAction(UIAlertAction(title: "Cansel", style: .destructive, handler: nil))
        
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
