//
//  MessagingListView.swift
//  EduConnect
//
//  Created by Akylai Bekbolsunova on 21/4/24.
//

import UIKit
import SnapKit

protocol MessagingModel {
    
}

struct TestMessagingModel: MessagingModel {
    var text: String
    var date: String

    var isMyMessaging: Bool = true
}

struct DateMessagingModel: MessagingModel {
    var date: String
}

class MessagingListView: BaseView {
    
    var messagingsModel: [MessagingModel] = [
        DateMessagingModel(
            date: "Сб, 3 Февраля"
        ),
        TestMessagingModel(
            text: "Господа, перспективное планирование, в своём классическом представлении, допускает внедрение анализа существующих паттернов поведения.",
            date: "11:01",
            isMyMessaging: false
        ),
        TestMessagingModel(
            text: "Задача организации, в особенности же граница обучения кадров играет определяющее значение для системы массового участия.",
            date: "11:04",
            isMyMessaging: false
        ),
        TestMessagingModel(
            text: "Внезапно, небо темнеет",
            date: "11:05"
        ),
        TestMessagingModel(
            text: "Внезапно, небо темнеет и это очень плохо)))))",
            date: "11:07"
        ),
        TestMessagingModel(
            text: "ХАВХХАХАХАХАХ :D",
            date: "12:44",
            isMyMessaging: false
        ),
    ]
    
    public lazy var tableView: UITableView = {
        let view = UITableView()
        view.delegate = self
        view.dataSource = self
        
        view.backgroundColor = .clear
        
        view.showsVerticalScrollIndicator = false
        view.transform = CGAffineTransform(rotationAngle: -(CGFloat)(Double.pi))
        view.selectionFollowsFocus = false
                
        view.sectionHeaderTopPadding = 0
        
        view.register(TestMessaginCell.self, forCellReuseIdentifier: "TestMessaginCell")
        view.register(DateMessaginCell.self, forCellReuseIdentifier: "DateMessaginCell")
        
        return view
    }()
    
    override func setupView() {
        
    }
    
    override func setupSubViews() {
        addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

extension MessagingListView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messagingsModel.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = messagingsModel.reversed()[indexPath.row]

        if let model = (model as? TestMessagingModel) {
            let cell = TestMessaginCell()
            
            cell.fill(model)
            
            return cell
        } else if let model = (model as? DateMessagingModel) {
            let cell = DateMessaginCell()

            cell.fill(model)
            
            return cell
        } else {
            return UITableViewCell()
        }
    }
}

class TestMessaginCell: BaseTableCell {
    
    private lazy var contenerText: BaseView = {
        let view = BaseView()
        view.backgroundColor = .init(hex: "#FFFFFF")
        view.layer.cornerRadius = 10
        return view
    }()
    
    private lazy var messageLabel: BaseLabel = {
        let view = BaseLabel()
        view.font = .systemFont(ofSize: 16)
        view.textColor = .init(hex: "#000000")
        view.numberOfLines = 0
        view.textAlignment = .left
        return view
    }()
    
    private lazy var dateLabel: BaseLabel = {
        let view = BaseLabel()
        view.font = .systemFont(ofSize: 10, weight: .regular)
        view.textColor = .init(hex: "#686868")
        return view
    }()
    
    private lazy var tail: BaseImage = {
        return BaseImage()
    }()
    
    override func setupView() {
        backgroundColor = .clear
        
        transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi))
    }
    
    override func setupSubViews() {
        contentView.addSubview(tail)
        tail.snp.makeConstraints { make in
            make.height.equalTo(18)
            make.width.equalTo(20)
        
            make.bottom.equalToSuperview().offset(-5)

            if model?.isMyMessaging ?? false {
                make.right.equalToSuperview().offset(-14)
            } else {
                make.left.equalToSuperview().offset(14)
            }
        }
        
        contentView.addSubview(contenerText)
        contenerText.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(5)
            
            if model?.isMyMessaging ?? false {
                make.right.equalToSuperview().offset(-20)
            } else {
                make.left.equalToSuperview().offset(20)
            }
            
            make.width.equalTo(UIScreen.main.bounds.width * 0.8)
                
            make.bottom.equalToSuperview().offset(-5)
        }
        
        contenerText.addSubview(dateLabel)
        dateLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-8)
            make.right.equalToSuperview().offset(-8)
        }
        
        contenerText.addSubview(messageLabel)
        messageLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.bottom.equalToSuperview().offset(-8)
            make.left.equalToSuperview().offset(8)
            make.right.equalToSuperview().offset(-8)
        }
    }
    
    var model: TestMessagingModel? = nil
    
    func fill(_ model: TestMessagingModel) {
        self.model = model
        
        messageLabel.text = model.text
                 
        if model.isMyMessaging {
            tail.image = UIImage(named: "TailRight")
        } else {
            tail.image = UIImage(named: "TailLeft")
        }
        
        if model.isMyMessaging {
            contenerText.backgroundColor = .init(hex: "#D4DDFF")
        } else {
            contenerText.backgroundColor = .init(hex: "#FFFFFF")
        }
        
        dateLabel.text = model.date
        
        setNeedsLayout()
        layoutIfNeeded()
    }
}

class DateMessaginCell: BaseTableCell {
    
    private lazy var dateContener: BaseView = {
        return BaseView()
    }()
    
    private lazy var dateLabel: BaseLabel = {
        let view = BaseLabel()
        view.font = .systemFont(ofSize: 13, weight: .regular)
        view.textColor = .init(hex: "#686868")
        return view
    }()
    
    override func setupView() {
        backgroundColor = .clear
        
        transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi))
    }
    
    override func setupSubViews() {
        contentView.addSubview(dateContener)
        dateContener.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            
            make.top.equalToSuperview().offset(2)
            make.bottom.equalToSuperview().offset(-2)
            
            make.height.equalTo(14)
        }
        
        dateContener.addSubview(dateLabel)
        dateLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            
            make.leading.trailing.equalToSuperview().inset(12)
        }
    }
    
    func fill(_ model: DateMessagingModel) {
        dateLabel.text = model.date
    }
}
