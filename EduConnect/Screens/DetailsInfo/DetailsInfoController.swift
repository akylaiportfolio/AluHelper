//
//  DetailsInfoController.swift
//  EduConnect
//
//  Created by Akylai Bekbolsunova on 17/5/24.
//

import Foundation

class DetailsInfoController: BaseController<DetailsInfoPresenter> {
    
    private lazy var toolbar: ToolbarView = {
        let view = ToolbarView()
        view.titleView.text = "Details announcements"
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
    
    private lazy var userLabel: BaseLabel = {
        let view = BaseLabel()
        view.textColor = .init(hex: "#000000")
        view.font = .systemFont(ofSize: 15, weight: .bold)
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
    
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(toolbar.snp.bottom).offset(2)
            make.left.right.equalToSuperview().inset(16)
        }
        
        view.addSubview(decriptionLabel)
        decriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.left.right.equalToSuperview().inset(16)
        }
        
        view.addSubview(userLabel)
        userLabel.snp.makeConstraints { make in
            make.top.equalTo(decriptionLabel.snp.bottom).offset(10)
            make.left.right.equalToSuperview().inset(16)
        }
        
        titleLabel.text = presenter?.model?.title
        decriptionLabel.text = presenter?.model?.message
        
        userLabel.text = "Author: \(presenter?.model?.userName ?? "") (\(presenter?.model?.group ?? ""))"
    }
}

extension DetailsInfoController: DetailsInfoDelegate {
    
}
