//
//  NewsCell.swift
//  EduConnect
//
//  Created by Akylai Bekbolsunova on 20/4/24.
//

import SnapKit
import UIKit

class NewsCell: BaseTableCell {
    
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
        view.numberOfLines = 5
        return view
    }()
    
    private lazy var timeView: BaseLabel = {
        let view = BaseLabel()
        view.textColor = .init(hex: "#000000")
        view.font = .systemFont(ofSize: 14, weight: .medium)
        view.text = "10.08.2004"
        view.numberOfLines = 1
        return view
    }()
    
    
    override func setupView() {
        
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
            make.top.bottom.equalToSuperview().inset(16)
            
            make.left.equalToSuperview().offset(16)
            
            make.height.equalTo(imageNews.snp.width)
        }
        
        contener.addSubview(titleView)
        titleView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(16)
            make.right.equalToSuperview().offset(16)
            
            make.left.equalTo(imageNews.snp.right).inset(-16)
        }
        
        contener.addSubview(messageView)
        messageView.snp.makeConstraints { make in
            make.top.equalTo(titleView.snp.bottom).offset(10)
            make.right.equalToSuperview().offset(-16)
            
            make.left.equalTo(imageNews.snp.right).inset(-16)
        }
        
        contener.addSubview(timeView)
        timeView.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-16)
            make.right.equalToSuperview().offset(-16)
            
            make.left.equalTo(imageNews.snp.right).inset(-16)
        }
    }
    
    private var model: NewsModel? = nil
    
    func fill(model: NewsModel) {
        self.model = model
        
        if let url = URL(string: model.image ?? "") {
            imageNews.kf.setImage(with: url)
        }
        
        titleView.text = model.title
        messageView.text = model.decription
        timeView.text = model.time
    }
}
