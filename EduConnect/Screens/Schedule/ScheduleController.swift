//
//  ScheduleController.swift
//  EduConnect
//
//  Created by Akylai Bekbolsunova on 16/5/24.
//

import UIKit
import SnapKit

class ScheduleController: BaseController<SchedulePresenter> {
    
    private lazy var toolbar: ToolbarView = {
        let view = ToolbarView()
        view.titleView.text = "Schedule"
        return view
    }()
    
    private lazy var scheduleWeekdayView = ScheduleWeekdayView()
    
    private lazy var scheduleListView = ScheduleListView()
    
    override func setupController() {
        toolbar.onTapBack { self.router?.back() }
        
        presenter?.fetchData()
        
        scheduleWeekdayView.onSelect { weekday in
            self.presenter?.selectWeekend(model: weekday)
        }
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

extension ScheduleController: ScheduleDelegate {
    func showSchedule(lession: [Lesson]) {
        scheduleListView.fill(model: lession)
    }
}
