//
//  RentListView.swift
//  EduConnect
//
//  Created by Akylai Bekbolsunova on 3/6/24.
//

import UIKit
import SnapKit

class RentListView: BaseView {
    
    private lazy var topGradient = GradientView(orintaion: .top)
    
    private lazy var tableView: UITableView = {
        let view = UITableView()
        view.delegate = self
        view.dataSource = self
        
        view.backgroundColor = .clear
        
        view.separatorStyle = .none
        
        view.register(RentCellView.self, forCellReuseIdentifier: "RentCellView")
        
        return view
    }()
    
    private lazy var labelEmpty: BaseLabel = {
        let view = BaseLabel()
        view.textColor = .init(hex: "#000000")
        view.font = .systemFont(ofSize: 16, weight: .bold)
        view.text = "Empty rents"
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
    
    private var selectAction: (RentRoom) -> Void = { _ in}
    
    private var model: [RentRoom] = []
    
    func onItemClick(selectAction: @escaping (RentRoom) -> Void) {
        self.selectAction = selectAction
    }
    
    func fill(model: [RentRoom]) {
        labelEmpty.isHidden = !model.isEmpty
        
        self.model = model
        
        tableView.reloadData()
    }
}

extension RentListView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = RentCellView()
        let model = model[indexPath.row]
        
        cell.fill(model)
        
        cell.onTab { [self] in
            selectAction(model)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

class RentCellView: BaseTableCell {
    
    private lazy var contener: BaseView = {
        let view = BaseView()
        view.backgroundColor = .white
        view.layer.shadowOpacity = 0.1
        view.layer.shadowRadius = 3
        view.layer.shadowOffset = .zero

        view.layer.cornerRadius = 16
        return view
    }()
    
    private lazy var titleView: BaseLabel = {
        let view = BaseLabel()
        view.textColor = .init(hex: "#000000")
        view.font = .systemFont(ofSize: 14, weight: .medium)
        view.text = "Equations Math Physics"
        view.numberOfLines = 1
        return view
    }()
    
    private lazy var status: BaseLabel = {
        let view = BaseLabel()
        view.textColor = .init(hex: "#000000")
        view.font = .systemFont(ofSize: 14, weight: .medium)
        view.numberOfLines = 1
        return view
    }()
    
    private lazy var messageView: BaseLabel = {
        let view = BaseLabel()
        view.textColor = .init(hex: "#000000")
        view.font = .systemFont(ofSize: 12, weight: .thin)
        view.text = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset she"
        view.numberOfLines = 0
        return view
    }()
    
    private lazy var startLabelView: BaseLabel = {
        let view = BaseLabel()
        view.textColor = .init(hex: "#000000")
        view.font = .systemFont(ofSize: 12, weight: .medium)
        view.text = "Lorem"
        view.numberOfLines = 1
        return view
    }()
    
    private lazy var endLabelView: BaseLabel = {
        let view = BaseLabel()
        view.textColor = .init(hex: "#000000")
        view.font = .systemFont(ofSize: 12, weight: .medium)
        view.text = "Lorem"
        view.numberOfLines = 1
        return view
    }()
    
    init() {
        super.init(style: .default, reuseIdentifier: nil)
        
        addSubview(contener)
        contener.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(3)
            make.bottom.equalToSuperview().inset(10)
            
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        contener.addSubview(titleView)
        titleView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(9)
            make.left.equalToSuperview().offset(16)
            
            make.right.equalToSuperview().offset(-70)
        }
        
        contener.addSubview(status)
        status.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(9)
            make.right.equalToSuperview().offset(-16)
        }
        
        contener.addSubview(messageView)
        messageView.snp.makeConstraints { make in
            make.top.equalTo(titleView.snp.bottom).offset(5)
            make.right.left.equalToSuperview().inset(16)
        }
        
        contener.addSubview(startLabelView)
        startLabelView.snp.makeConstraints { make in
            make.top.equalTo(messageView.snp.bottom).offset(5)
            make.right.left.equalToSuperview().inset(16)
        }
        
        contener.addSubview(endLabelView)
        endLabelView.snp.makeConstraints { make in
            make.top.equalTo(startLabelView.snp.bottom).offset(5)
            make.right.left.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().offset(-9)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func fill(_ model: RentRoom) {
        titleView.text = model.room
        messageView.text = model.message
        
        status.text = model.status
        
        startLabelView.text = "Start time rent - \(model.startTime)"
        endLabelView.text = "End time rent - \(model.endTime)"
        
        contener.layoutIfNeeded()
    }
}


