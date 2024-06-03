//
//  MainContentView.swift
//  EduConnect
//
//  Created by Akylai Bekbolsunova on 20/4/24.
//

import UIKit
import SnapKit

enum MainContentTypeAction {
    case info(title: String, more: String?, type: AllType)
    case schedule(lesson: Lesson)
    case orders(order: OrderModel)
    case news(news: NewsModel)
}

class MainContentView: BaseView {
    
    private var cells: [MainContentType] = []
    
    private lazy var topGradient = GradientView(orintaion: .top)

    private lazy var tableView: UITableView = {
        let view = UITableView()
        view.delegate = self
        view.dataSource = self
        
        view.backgroundColor = .clear
        
        view.separatorStyle = .none
                
        view.register(ScheduleCell.self, forCellReuseIdentifier: "ScheduleCell")
        view.register(InfoView.self, forCellReuseIdentifier: "InfoView")
        view.register(OrdersCell.self, forCellReuseIdentifier: "OrdersCell")
        view.register(NewsCell.self, forCellReuseIdentifier: "NewsCell")
        
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
    }
    
    func fill(_ cells: [MainContentType]) {
        self.cells = cells
        
        tableView.reloadData()
    }
    
    var onSelectItem: (MainContentTypeAction) -> Void = { _ in }
    
    func onTab(onItem: @escaping (MainContentTypeAction) -> Void) {
        self.onSelectItem = onItem
    }
}

extension MainContentView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cells = cells[indexPath.row]
        
        switch cells {
        case .info(title: let title, more: let more, type: let type):
            let cell = tableView.dequeueReusableCell(withIdentifier: "InfoView") as! InfoView
            
            cell.fill(title: title, more: more)
            
            cell.onTab { self.onSelectItem(.info(title: title, more: more, type: type)) }
            
            return cell
        case .schedule(let lessons):
            let cell = tableView.dequeueReusableCell(withIdentifier: "ScheduleCell") as! ScheduleCell
            
            cell.fill(model: lessons)
            
            cell.onSelectItem { lesson in self.onSelectItem(.schedule(lesson: lesson)) }
            
            return cell
        case .orders(let orders):
            let cell = tableView.dequeueReusableCell(withIdentifier: "OrdersCell") as! OrdersCell
            
            cell.fill(model: orders)
            
            cell.onSelectItem { order in self.onSelectItem(.orders(order: order)) }

            return cell
        case .news(let news):
            let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell") as! NewsCell
            
            cell.fill(model: news)
            
            cell.onTab { self.onSelectItem(.news(news: news)) }

            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch cells[indexPath.row] {
        case .info(_, _, _):
            return 43
        case .schedule:
            return 174
        case .orders:
            return 174
        case .news:
            return 162
        }
    }
}
