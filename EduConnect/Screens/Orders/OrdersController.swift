//
//  OrdersController.swift
//  EduConnect
//
//  Created by Akylai Bekbolsunova on 16/5/24.
//

import UIKit
import SnapKit

class OrdersController: BaseController<OrdersPresenter> {
    
    private lazy var toolbar: ToolbarView = {
        let view = ToolbarView()
        view.titleView.text = "Orders"
        return view
    }()
    
    private lazy var ordersList = OrdersListView()
    
    override func setupController() {
        toolbar.onTapBack { self.router?.back() }
        
        ordersList.onItemClick { [self] item in
            router?.open(DetailsOrderBuilder.create(model: item))
        }
        
        if UserServices.shered.getUser()?.status == "admin" {
            toolbar.onTapAdded { [self] in
                router?.open(SendOrderBuilder.create())
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
        
        view.addSubview(ordersList)
        ordersList.snp.makeConstraints { make in
            make.top.equalTo(toolbar.snp.bottom)
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
}

extension OrdersController: OrdersDelegate {
    func showOrders(model: [OrderModel]) {
        ordersList.fill(models: model)
    }
}
