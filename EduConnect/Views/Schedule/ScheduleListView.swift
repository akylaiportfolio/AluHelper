//
//  ScheduleListView.swift
//  EduConnect
//
//  Created by Akylai Bekbolsunova on 16/5/24.
//

import UIKit
import SnapKit

class ScheduleListView: BaseView {
    
    private var cells: [MainContentType] = []
    
    private lazy var topGradient = GradientView(orintaion: .top)

    private lazy var tableView: UITableView = {
        let view = UITableView()
        view.delegate = self
        view.dataSource = self
        
        view.backgroundColor = .clear
        
        view.separatorStyle = .none
                
        view.register(ScheduleListItem.self, forCellReuseIdentifier: "ScheduleListItem")
        
        return view
    }()
    
    private lazy var emptyTitle: BaseLabel = {
        let view = BaseLabel()
        view.text = "Empty"
        view.textColor = .init(hex: "#000000")
        view.font = .systemFont(ofSize: 20, weight: .bold)
        view.isHidden = true
        return view
    }()
    
    override func setupSubViews() {
        addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.bottom.left.right.equalToSuperview()
        }
        
        addSubview(topGradient)
        topGradient.snp.makeConstraints { make in
            make.top.equalToSuperview()
            
            make.left.right.equalToSuperview()
            
            make.height.equalTo(10)
        }
        
        addSubview(emptyTitle)
        emptyTitle.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    private var model: [Lesson] = []
    
    func fill(model: [Lesson]) {
        emptyTitle.isHidden = !model.isEmpty
        
        self.model = model
        
        tableView.reloadData()
    }
    
    private var selectAction: (Lesson) -> Void = { _ in}
    
    func onItemClick(selectAction: @escaping (Lesson) -> Void) {
        self.selectAction = selectAction
    }
}

extension ScheduleListView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ScheduleListItem()
        let model = model[indexPath.row]
        
        cell.fill(model: model)
        
        cell.onTab { [self] in
            selectAction(model)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
}

class ScheduleListItem: BaseTableCell {
    
    func fill(model: Lesson) {
        timeLabel.text = "\(model.start ?? "") - \(model.end ?? "")"
        
        lessonName.text = model.title
        
        cabinetTitle.text = "\(model.cabinet ?? "not set") - cabinet"
        
        if let user = model.teacher {
            UserServices.shered.findUser(user) { user in
                self.tihcer.text = "Mr. \(user?.fullName ?? "")"
            }
        }
    }
    
    private lazy var contener: BaseView = {
        let view = BaseView()
        view.backgroundColor = .white
        view.layer.shadowOpacity = 0.1
        view.layer.shadowRadius = 3
        view.layer.shadowOffset = .zero

        view.layer.cornerRadius = 16
        return view
    }()
    
    private lazy var leftView: BaseView = {
        let view = BaseView()
        
        switch Int.random(in: 0..<5) {
        case 0:
            view.backgroundColor = .init(hex: "#E59743")
        case 1:
            view.backgroundColor = .init(hex: "#5BB269")
        case 2:
            view.backgroundColor = .init(hex: "#43ABE5")
        case 3:
            view.backgroundColor = .init(hex: "#CE43E5")
        default:
            view.backgroundColor = .init(hex: "#CE43E5")
        }
        
        view.layer.cornerRadius = 6
        view.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner]
        return view
    }()
    
    private lazy var lessonName: BaseLabel = {
        let view = BaseLabel()
        view.textColor = .init(hex: "#000000")
        view.font = .systemFont(ofSize: 14, weight: .bold)
        view.numberOfLines = 2
        view.text = "Equations Math Physics"
        return view
    }()
    
    private lazy var cabinetTitle: BaseLabel = {
        let view = BaseLabel()
        view.textColor = .init(hex: "#000000")
        view.font = .systemFont(ofSize: 14)
        view.numberOfLines = 1
        view.text = "504 - cabinet"
        return view
    }()
    
    private lazy var tihcer: BaseLabel = {
        let view = BaseLabel()
        view.textColor = .init(hex: "#000000")
        view.font = .systemFont(ofSize: 14)
        view.numberOfLines = 1
        view.text = ""
        return view
    }()
    
    private lazy var timeView: BaseView = {
        let view = BaseView()
        view.backgroundColor = .init(hex: "#F6F6F9")
        view.layer.cornerRadius = 13
        return view
    }()
    
    private lazy var timeLabel: BaseLabel = {
        let view = BaseLabel()
        view.textColor = .init(hex: "#6A6A6A")
        view.font = .systemFont(ofSize: 14)
        view.numberOfLines = 1
        view.text = "07:30 - 09:20"
        return view
    }()
    
    override func setupSubViews() {
        addSubview(contener)
        contener.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(4)
            
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        contener.addSubview(leftView)
        leftView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(25)
            make.left.equalToSuperview()
            make.width.equalTo(4)
        }
        
        contener.addSubview(lessonName)
        lessonName.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(15)
            make.left.right.equalToSuperview().inset(16)
        }
        
        contener.addSubview(cabinetTitle)
        cabinetTitle.snp.makeConstraints { make in
            make.top.equalTo(lessonName.snp.bottom).offset(8)
            make.left.right.equalToSuperview().inset(16)
        }
        
        contener.addSubview(tihcer)
        tihcer.snp.makeConstraints { make in
            make.top.equalTo(cabinetTitle.snp.bottom).offset(5)
            make.left.right.equalToSuperview().inset(16)
        }
        
        contener.addSubview(timeView)
        timeView.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-15)
            make.left.equalToSuperview().inset(16)
        }
        
        timeView.addSubview(timeLabel)
        timeLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(6)
            make.left.right.equalToSuperview().inset(13)
        }
    }
}

// TODO: FULL
