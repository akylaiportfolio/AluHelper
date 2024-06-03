//
//  OrdersListView.swift
//  EduConnect
//
//  Created by Akylai Bekbolsunova on 16/5/24.
//

import UIKit
import SnapKit

class OrdersListView: BaseView {
        
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
    }
    
    private var selectAction: (OrderModel) -> Void = { _ in }
    
    func onItemClick(selectAction: @escaping (OrderModel) -> Void) {
        self.selectAction = selectAction
    }
    
    private var models: [OrderModel] = []
    
    func fill(models: [OrderModel]) {
        self.models = models
        
        tableView.reloadData()
    }
}

extension OrdersListView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = OrdersListItem()
        let models = models[indexPath.row]
        
        cell.fill(model: models)
        
        cell.onTab { [self] in
            selectAction(models)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 145
    }
}

class OrdersListItem: BaseTableCell {
    
    private lazy var contener: BaseView = {
        let view = BaseView()
        view.backgroundColor = .white
        view.layer.shadowOpacity = 0.1
        view.layer.shadowRadius = 3
        view.layer.shadowOffset = .zero

        view.layer.cornerRadius = 16
        return view
    }()
    
    private lazy var nameImage = BaseImage(image: UIImage(named: "Book"))
    
    private lazy var nameTitle: BaseLabel = {
        let view = BaseLabel()
        view.textColor = .init(hex: "#000000")
        view.font = .systemFont(ofSize: 14, weight: .medium)
        view.text = "Equations Math Physics"
        view.numberOfLines = 2
        return view
    }()
    
    private lazy var messageTitle: BaseLabel = {
        let view = BaseLabel()
        view.textColor = .init(hex: "#000000")
        view.font = .systemFont(ofSize: 12, weight: .thin)
        view.text = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley "
        view.numberOfLines = 5
        return view
    }()
    
    private lazy var timeImage = BaseImage(image: UIImage(named: "Calendar"))
    
    private lazy var timeTitle: BaseLabel = {
        let view = BaseLabel()
        view.textColor = .init(hex: "#000000")
        view.font = .systemFont(ofSize: 12, weight: .regular)
        view.text = "Create 18.08.2023"
        view.numberOfLines = 1
        return view
    }()
    
    override func setupSubViews() {
        addSubview(contener)
        contener.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(4)
            
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        contener.addSubview(nameImage)
        nameImage.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(15)
            make.left.equalToSuperview().offset(13)
            
            make.width.height.equalTo(16)
        }
        
        contener.addSubview(nameTitle)
        nameTitle.snp.makeConstraints { make in
            make.top.equalTo(nameImage)
            make.left.equalTo(nameImage.snp.right).offset(12)
            make.right.equalToSuperview().offset(-16)
        }
        
        contener.addSubview(messageTitle)
        messageTitle.snp.makeConstraints { make in
            make.top.equalTo(nameTitle.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        contener.addSubview(timeImage)
        timeImage.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-15)
            make.left.equalToSuperview().offset(13)
            
            make.width.height.equalTo(16)
        }
        
        contener.addSubview(timeTitle)
        timeTitle.snp.makeConstraints { make in
            make.top.equalTo(timeImage)
            make.left.equalTo(timeImage.snp.right).offset(6)
            make.right.equalToSuperview().offset(-16)
        }
    }
    
    func fill(model: OrderModel) {
        nameTitle.text = model.title
        messageTitle.text = model.decription
        timeTitle.text = "Create: \(model.create ?? "")"
    }
}

// TODO: FULL
