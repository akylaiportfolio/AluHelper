//
//  ScheduleController.swift
//  EduConnect
//
//  Created by Akylai Bekbolsunova on 16/5/24.
//

import UIKit
import SnapKit

class UpdateScheduleController: BaseController<UpdateSchedulePresenter> {
    
    private lazy var toolbar: ToolbarView = {
        let view = ToolbarView()
        view.titleView.text = "Update \(presenter?.name ?? "") schedule"
        return view
    }()
    
    private lazy var scheduleWeekdayView = ScheduleWeekdayView()
    
    private lazy var scheduleListView = ScheduleListView()
    
    override func setupController() {
        toolbar.onTapBack { self.router?.back() }
        
        toolbar.onTapAdded { self.router?.open(AddScheduleBuilder.create(name: self.presenter?.name ?? "")) }
                
        scheduleWeekdayView.onSelect { weekday in
            self.presenter?.selectWeekend(model: weekday)
        }
        
        scheduleListView.onItemClick { lession in
            let controller = UIAlertController(title: "Schedule update", message: nil, preferredStyle: .actionSheet)
            
            controller.addAction(UIAlertAction(title: "Remove", style: .default, handler: { _ in
                self.presenter?.deleteLession(lesson: lession)
            }))
            
            controller.addAction(UIAlertAction(title: "Cansel", style: .destructive, handler: nil))
            
            self.present(controller, animated: true)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        presenter?.fetchData()
    }
    
    override func setupSubViews() {
        view.addSubview(toolbar)
        toolbar.snp.makeConstraints { make in
            make.top.equalTo(view.safeArea.top)
            make.left.right.equalToSuperview()
            make.height.equalTo(53)
        }
        
        view.addSubview(scheduleWeekdayView)
        scheduleWeekdayView.snp.makeConstraints { make in
            make.top.equalTo(toolbar.snp.bottom)
            make.left.right.equalToSuperview()
            make.height.equalTo(70)
        }
        
        view.addSubview(scheduleListView)
        scheduleListView.snp.makeConstraints { make in
            make.top.equalTo(scheduleWeekdayView.snp.bottom).offset(5)
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
}

extension UpdateScheduleController: UpdateScheduleDelegate {
    func showSchedule(lession: [Lesson]) {
        scheduleListView.fill(model: lession)
    }
}
