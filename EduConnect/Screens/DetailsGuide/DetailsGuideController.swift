//
//  DetailsGuideController.swift
//  EduConnect
//
//  Created by Akylai Bekbolsunova on 17/5/24.
//

import Foundation

class DetailsGuideController: BaseController<DetailsGuidePresenter> {
    
    private lazy var toolbar: ToolbarView = {
        let view = ToolbarView()
        view.titleView.text = "Guide"
        return view
    }()
    
    private lazy var newsImage: BaseImage = {
        let view = BaseImage()
        view.contentMode = .center
        view.layer.cornerRadius = 8
        view.image = .init(named: "GuideTestImage")
        view.layer.masksToBounds = true
        return view
    }()
    
    private lazy var titleLabel: BaseLabel = {
        let view = BaseLabel()
        view.textColor = .init(hex: "#000000")
        view.font = .systemFont(ofSize: 15, weight: .bold)
        view.text = "Equations Math Physics"
        view.numberOfLines = 0
        return view
    }()
    
    private lazy var decriptionLabel: BaseLabel = {
        let view = BaseLabel()
        view.textColor = .init(hex: "#000000")
        view.font = .systemFont(ofSize: 12)
        view.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
        view.numberOfLines = 0
        return view
    }()
    
    override func setupController() {
        toolbar.onTapBack { self.router?.back() }
    }
    
    override func setupSubViews() {
        view.addSubview(toolbar)
        toolbar.snp.makeConstraints { make in
            make.top.equalTo(view.safeArea.top)
            make.left.right.equalToSuperview()
            make.height.equalTo(53)
        }
        
        view.addSubview(newsImage)
        newsImage.snp.makeConstraints { make in
            make.top.equalTo(toolbar.snp.bottom).offset(8)
            make.left.right.equalToSuperview().inset(16)
            make.height.equalTo(160)
        }
        
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(newsImage.snp.bottom).offset(15)
            make.left.right.equalToSuperview().inset(16)
        }
        
        view.addSubview(decriptionLabel)
        decriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.left.right.equalToSuperview().inset(16)
        }
        
        titleLabel.text = presenter?.model?.title
        decriptionLabel.text = presenter?.model?.message

        if let url = URL(string: presenter?.model?.url ?? "") {
            newsImage.kf.setImage(with: url)
        }
    }
}

extension DetailsGuideController: DetailsGuideDelegate {
    
}
