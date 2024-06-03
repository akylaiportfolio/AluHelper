//
//  InfoController.swift
//  EduConnect
//
//  Created by Akylai Bekbolsunova on 17/5/24.
//

import UIKit
import SnapKit

class InfoController: BaseController<InfoPresenter> {
    
    private lazy var toolbar: ToolbarView = {
        let view = ToolbarView()
        view.titleView.text = "Announcements"
        return view
    }()
    
    private lazy var infoList = InfoListView()
    
    override func setupController() {
        infoList.onItemClick { [self] item in
            if UserServices.shered.getUser()?.status == "admin" {
                let alert = UIAlertController(title: "Admin setting info", message: nil, preferredStyle: .actionSheet)
                alert.addAction(UIAlertAction(title: "Remove", style: .default) { _ in
                    self.presenter?.remove(id: item.id)
                })
                
                alert.addAction(UIAlertAction(title: "Сonfirm", style: .default) { _ in
                    self.presenter?.confirm(id: item.id)
                })
                
                alert.addAction(UIAlertAction(title: "Cansel", style: .default) { _ in
                    self.presenter?.cansel(id: item.id)
                })
                
                alert.addAction(UIAlertAction(title: "Open", style: .default) { _ in
                    self.router?.open(DetailsInfoBuilder.create(item))
                })
                
                alert.addAction(UIAlertAction(title: "Close", style: .cancel, handler: nil))
                present(alert, animated: true)
            } else {
                router?.open(DetailsInfoBuilder.create(item))
            }
        }
        
        toolbar.onTapAdded { [self] in
            router?.open(SendInfoBuilder.create())
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
        
        view.addSubview(infoList)
        infoList.snp.makeConstraints { make in
            make.top.equalTo(toolbar.snp.bottom)
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
}

extension InfoController: InfoDelegate {
    func showInfoList(model: [InfoModel]) {
        infoList.fill(model: model)
    }
}
