//
//  NewsController.swift
//  EduConnect
//
//  Created by Akylai Bekbolsunova on 16/5/24.
//

import UIKit
import SnapKit

class NewsController: BaseController<NewsPresenter> {
    
    private lazy var toolbar: ToolbarView = {
        let view = ToolbarView()
        view.titleView.text = "News"
        return view
    }()
    
    private lazy var newsList = NewsListView()
    
    override func setupController() {
        toolbar.onTapBack { self.router?.back() }
        
        newsList.onItemClick { [self] item in
            if UserServices.shered.getUser()?.status == "admin" {
                let alert = UIAlertController(title: "Admin setting info", message: nil, preferredStyle: .actionSheet)
                alert.addAction(UIAlertAction(title: "Remove", style: .default) { _ in
                    self.presenter?.remove(id: item.id ?? 0)
                })
                
                alert.addAction(UIAlertAction(title: "Open", style: .default) { _ in
                    router?.open(DatailsNewsBuilder.create(item))
                })
                
                alert.addAction(UIAlertAction(title: "Close", style: .cancel, handler: nil))
                present(alert, animated: true)
            } else {
                router?.open(DatailsNewsBuilder.create(item))
            }
        }
        
        if UserServices.shered.getUser()?.status == "admin" {
            toolbar.onTapAdded {
                self.router?.open(SendNewsBuilder.create())
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
        
        view.addSubview(newsList)
        newsList.snp.makeConstraints { make in
            make.top.equalTo(toolbar.snp.bottom)
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
}

extension NewsController: NewsDelegate {
    func showNews(models: [NewsModel]) {
        newsList.fill(models: models)
    }
}
