//
//  Student.swift
//  EduConnect
//
//  Created by Akylai Bekbolsunova on 18/4/24.
//

import UIKit
import SnapKit

class HomeController: BaseController<HomePresenter> {
    
    private lazy var toolbar = UserToolbar()
    
    private lazy var content = MainContentView()
        
    override func setupController() {
        presenter?.fecthData()
        
        content.onTab { [self] type in
            switch type {
            case .info(let title, let more, let type):
                switch type {
                case .schedule:
                    router?.open(ScheduleBuilder.create())
                    
                case .orders:
                    router?.open(OrdersBuilder.create())
                    
                case .news:
                    router?.open(NewsBuilder.create())
                }
            case .news(let news):
                router?.open(DatailsNewsBuilder.create(news))
                
            case .schedule(lesson: let lesson):
                router?.open(ScheduleBuilder.create())
                
            case .orders(order: let order):
                router?.open(DetailsOrderBuilder.create(model: order))
            }
        }
    }
    
    override func setupSubViews() {
        view.addSubview(toolbar)
        toolbar.snp.makeConstraints { make in
            make.top.equalTo(view.safeArea.top)
            make.left.right.equalToSuperview()
            make.height.equalTo(53)
        }
        
        view.addSubview(content)
        content.snp.makeConstraints { make in
            make.top.equalTo(toolbar.snp.bottom)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(view.safeArea.bottom)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        presenter?.getCurrentUser()
    }
}

extension HomeController: HomeDelegate {
    func showView(cells: [MainContentType]) {
        content.fill(cells)
    }
    
    func showCurrentUser(model: UserModel) {
        toolbar.fill(model: model)
    }
}
