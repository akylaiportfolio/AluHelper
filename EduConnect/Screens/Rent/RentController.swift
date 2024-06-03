//
//  RentController.swift
//  EduConnect
//
//  Created by Akylai Bekbolsunova on 2/6/24.
//

import UIKit
import SnapKit

class RentController: BaseController<RentPresenter> {
    
    private lazy var toolbar: ToolbarView = {
        let view = ToolbarView()
        view.titleView.text = "Office rental"
        return view
    }()
    
    private lazy var rentList = RentListView()
    
    override func setupController() {
        toolbar.onTapBack {
            self.router?.back()
        }
        
        toolbar.onTapAdded {
            self.router?.open(SentRentBuilder.create())
        }
        
        rentList.onItemClick { [self] model in
            if UserServices.shered.getUser()?.status == "admin" {
                let controller = UIAlertController(title: "Rent update", message: nil, preferredStyle: .actionSheet)
                
                controller.addAction(UIAlertAction(title: "Disable", style: .default, handler: { _ in
                    self.presenter?.disableRent(id: model.id)
                }))
                
                controller.addAction(UIAlertAction(title: "Approve", style: .default, handler: { _ in
                    self.presenter?.approveRent(id: model.id)
                }))
                
                controller.addAction(UIAlertAction(title: "Remove", style: .default, handler: { _ in
                    self.presenter?.removeRent(id: model.id)
                }))
                
                controller.addAction(UIAlertAction(title: "Cansel", style: .destructive, handler: nil))
                
                present(controller, animated: true)
            } else if model.uid == UserServices.shered.getUser()?.uid {
                let controller = UIAlertController(title: "Rent update", message: nil, preferredStyle: .actionSheet)
                
                controller.addAction(UIAlertAction(title: "Remove", style: .default, handler: { _ in
                    self.presenter?.removeRent(id: model.id)
                }))
                
                controller.addAction(UIAlertAction(title: "Cansel", style: .destructive, handler: nil))
                
                present(controller, animated: true)
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        presenter?.getAllRent()
    }
    
    override func setupSubViews() {
        view.addSubview(toolbar)
        toolbar.snp.makeConstraints { make in
            make.top.equalTo(view.safeArea.top)
            make.left.right.equalToSuperview()
            make.height.equalTo(53)
        }
        
        view.addSubview(rentList)
        rentList.snp.makeConstraints { make in
            make.top.equalTo(toolbar.snp.bottom)
            make.left.right.bottom.equalToSuperview()
        }
    }
}

extension RentController: RentDelegate {
    func showRents(model: [RentRoom]) {
        rentList.fill(model: model)
    }
}
