//
//  GuideListView.swift
//  EduConnect
//
//  Created by Akylai Bekbolsunova on 17/5/24.
//

import UIKit

class GuideListView: BaseView {
    
    private lazy var topGradient = GradientView(orintaion: .top)
    
    private lazy var tableView: UITableView = {
        let view = UITableView()
        view.delegate = self
        view.dataSource = self
        
        view.backgroundColor = .clear
        
        view.separatorStyle = .none
        
        view.register(GuideItemView.self, forCellReuseIdentifier: "GuideItemView")
        
        return view
    }()
    
    private lazy var labelEmpty: BaseLabel = {
        let view = BaseLabel()
        view.textColor = .init(hex: "#000000")
        view.font = .systemFont(ofSize: 16, weight: .bold)
        view.text = "Empty guide"
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
    
    private var models: [GuideModel] = []
    
    private var selectAction: (GuideModel) -> Void = { _ in}
    
    func onItemClick(selectAction: @escaping (GuideModel) -> Void) {
        self.selectAction = selectAction
    }
    
    func fill(models: [GuideModel]) {
        labelEmpty.isHidden = !models.isEmpty
        
        self.models = models
        
        tableView.reloadData()
    }
}

extension GuideListView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = GuideItemView()
        let model = models[indexPath.row]
        
        cell.fill(model: model)
        
        cell.onTab { [self] in
            selectAction(model)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 280
    }
}

class GuideItemView: BaseTableCell {
    private lazy var contener: BaseView = {
        let view = BaseView()
        view.backgroundColor = .white
        view.layer.shadowOpacity = 0.1
        view.layer.shadowRadius = 3
        view.layer.shadowOffset = .zero

        view.layer.cornerRadius = 16
        return view
    }()
    
    private lazy var imageNews: BaseImage = {
        let view = BaseImage()
        view.contentMode = .center
        view.layer.cornerRadius = 16
        view.layer.masksToBounds = true
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
    
    private lazy var messageView: BaseLabel = {
        let view = BaseLabel()
        view.textColor = .init(hex: "#000000")
        view.font = .systemFont(ofSize: 12, weight: .thin)
        view.text = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset she"
        view.numberOfLines = 3
        return view
    }()
    
    func fill(model: GuideModel) {
        titleView.text = model.title
        messageView.text = model.message
        
        if let url = URL(string: model.url ?? "") {
            imageNews.kf.setImage(with: url)
        }
    }
    
    override func setupSubViews() {
        addSubview(contener)
        contener.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(3)
            make.bottom.equalToSuperview().inset(10)
            
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        contener.addSubview(imageNews)
        imageNews.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(16)
            
            make.left.right.equalToSuperview().inset(16)
            
            make.height.equalTo(160)
        }
        
        contener.addSubview(titleView)
        titleView.snp.makeConstraints { make in
            make.top.equalTo(imageNews.snp.bottom).offset(14)
            make.right.left.equalToSuperview().inset(16)
        }
        
        contener.addSubview(messageView)
        messageView.snp.makeConstraints { make in
            make.top.equalTo(titleView.snp.bottom).offset(5)
            make.right.left.equalToSuperview().inset(16)
        }
    }
}

