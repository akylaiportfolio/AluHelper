//
//  GuideController.swift
//  EduConnect
//
//  Created by Akylai Bekbolsunova on 17/5/24.
//

import UIKit

class GuideController: BaseController<GuidePresenter> {
    
    private lazy var toolbar: ToolbarView = {
        let view = ToolbarView()
        view.titleView.text = "Guide"
        return view
    }()
    
    private lazy var guideList = GuideListView()
    
    override func setupController() {        
        guideList.onItemClick { [self] item in
            if UserServices.shered.getUser()?.status == "admin" {
                let alert = UIAlertController(title: "Admin setting info", message: nil, preferredStyle: .actionSheet)
                alert.addAction(UIAlertAction(title: "Remove", style: .default) { _ in
                    self.presenter?.remove(id: item.id)
                })
                
                alert.addAction(UIAlertAction(title: "Open", style: .default) { _ in
                    router?.open(DetailsGuideBuilder.create(item))
                })
                
                alert.addAction(UIAlertAction(title: "Close", style: .cancel, handler: nil))
                present(alert, animated: true)
            } else {
                router?.open(DetailsGuideBuilder.create(item))
            }
        }
        
        if UserServices.shered.getUser()?.status == "admin" {
            toolbar.onTapAdded { [self] in
                router?.open(SendGuideBuilder.create())
            }
        }
        
        presenter?.fetchData()
    }
    
    override func setupSubViews() {
        view.addSubview(toolbar)
        toolbar.snp.makeConstraints { make in
            make.top.equalTo(view.safeArea.top)
            make.left.right.equalToSuperview()
            make.height.equalTo(53)
        }
        
        view.addSubview(guideList)
        guideList.snp.makeConstraints { make in
            make.top.equalTo(toolbar.snp.bottom)
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
}

extension GuideController: GuideDelegate {
    func showGuide(models: [GuideModel]) {
        guideList.fill(models: models)
    }
}
