//
//  UserListView.swift
//  EduConnect
//
//  Created by Akylai Bekbolsunova on 4/6/24.
//

import UIKit
import SnapKit

class UserListView: BaseView {
    
    private lazy var topGradient = GradientView(orintaion: .top)
    
    private lazy var tableView: UITableView = {
        let view = UITableView()
        view.delegate = self
        view.dataSource = self
        
        view.backgroundColor = .clear
        
        view.separatorStyle = .none
        
        view.register(UserCellView.self, forCellReuseIdentifier: "UserCellView")
        
        return view
    }()
    
    private lazy var labelEmpty: BaseLabel = {
        let view = BaseLabel()
        view.textColor = .init(hex: "#000000")
        view.font = .systemFont(ofSize: 16, weight: .bold)
        view.text = "Empty users"
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
        
    private var model: [UserModel] = []
    
    private var selectAction: (UserModel) -> Void = { _ in}
    
    func onItemClick(selectAction: @escaping (UserModel) -> Void) {
        self.selectAction = selectAction
    }
    
    func fill(model: [UserModel]) {
        labelEmpty.isHidden = !model.isEmpty
        
        self.model = model
        
        tableView.reloadData()
    }
}

extension UserListView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UserCellView()
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

class UserCellView: BaseTableCell {
    
    private lazy var contener = ProfileCellUserView()
    
    init() {
        super.init(style: .default, reuseIdentifier: nil)
        
        addSubview(contener)
        contener.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(3)
            make.bottom.equalToSuperview().inset(10)
            
            make.leading.trailing.equalToSuperview().inset(16)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func fill(_ model: UserModel) {
        contener.fill(model: model)
        
        contener.layoutIfNeeded()
    }
}

class ProfileCellUserView: BaseView {
    
    private lazy var logo: BaseImage = {
        let view = BaseImage()
        view.layer.cornerRadius = 25
        view.backgroundColor = .gray
        view.layer.masksToBounds = true
        return view
    }()
    
    override func setupView() {
        backgroundColor = .white
        layer.shadowOpacity = 0.1
        layer.shadowRadius = 3
        layer.shadowOffset = .zero

        layer.cornerRadius = 16
    }
    
    public lazy var nameView: BaseLabel = {
        let view = BaseLabel()
        view.textColor = .init(hex: "#000000")
        view.font = .systemFont(ofSize: 16, weight: .bold)
        return view
    }()
    
    public lazy var groupView: BaseLabel = {
        let view = BaseLabel()
        view.textColor = .init(hex: "#000000")
        view.font = .systemFont(ofSize: 14)
        return view
    }()
    
    lazy var changeView: BaseLabel = {
        let view = BaseLabel()
        view.textColor = .init(hex: "#973535")
        view.text = "Change"
        view.font = .systemFont(ofSize: 14, weight: .bold)
        return view
    }()
    
    override func setupSubViews() {
        addSubview(logo)
        logo.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.width.height.equalTo(50)
            make.top.bottom.equalToSuperview().inset(16)
        }
        
        addSubview(nameView)
        nameView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(22)
            make.left.equalTo(logo.snp.right).offset(10)
        }
        
        addSubview(groupView)
        groupView.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-22)
            make.left.equalTo(logo.snp.right).offset(10)
        }
        
        addSubview(changeView)
        changeView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-16)
        }
    }
    
    func fill(model: UserModel) {
        nameView.text = model.fullName
        
        if model.status == "teacher" {
            groupView.text = "Teacher"
        } else {
            groupView.text = "\(model.group)"
        }
        
        changeView.text = "Status: \(model.status)"
        
        logo.kf.setImage(with: URL(string: model.avatar))
    }
}


