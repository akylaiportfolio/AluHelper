//
//  NewsListView.swift
//  EduConnect
//
//  Created by Akylai Bekbolsunova on 16/5/24.
//

import UIKit
import SnapKit

class NewsListView: BaseView {
        
    private lazy var topGradient = GradientView(orintaion: .top)

    private lazy var tableView: UITableView = {
        let view = UITableView()
        view.delegate = self
        view.dataSource = self
        
        view.backgroundColor = .clear
        
        view.separatorStyle = .none
                
        view.register(OrdersListItem.self, forCellReuseIdentifier: "OrdersListItem")
        
        return view
    }()
    
    private lazy var labelEmpty: BaseLabel = {
        let view = BaseLabel()
        view.textColor = .init(hex: "#000000")
        view.font = .systemFont(ofSize: 16, weight: .bold)
        view.text = "Empty info"
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
        
        addSubview(labelEmpty)
        labelEmpty.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    private var selectAction: (NewsModel) -> Void = { _ in}
    
    func onItemClick(selectAction: @escaping (NewsModel) -> Void) {
        self.selectAction = selectAction
    }
    
    var models: [NewsModel] = []
    
    func fill(models: [NewsModel]) {
        self.labelEmpty.isHidden = !models.isEmpty
        
        self.models = models
        
        tableView.reloadData()
    }
}

extension NewsListView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = NewsCell()
        let model = models[indexPath.row]
        
        cell.fill(model: model)
        
        cell.onTab { [self] in
            selectAction(model)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 165
    }
}
