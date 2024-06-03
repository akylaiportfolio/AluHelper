//
//  PagingIndecator.swift
//  EduConnect
//
//  Created by Akylai Bekbolsunova on 20/4/24.
//

import UIKit
import SnapKit

class PagingIndecator: BaseView {
    
    private var stack: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 5
        return view
    }()
    
    private var items: [PagingIndecatorItem] = []
    
    override func setupView() {
        snp.makeConstraints { make in
            make.height.equalTo(8)
        }
    }
    
    override func setupSubViews() {
        addSubview(stack)
        stack.snp.makeConstraints { make in
            make.centerX.top.bottom.equalToSuperview()
        }
    }
    
    func fill(count: Int) {
        stack.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        items.removeAll()
        
        for _ in 0 ..< count {
            let item = PagingIndecatorItem()
            
            stack.addArrangedSubview(item)
            
            self.items.append(item)
        }
    }
    
    func set(index: Int) {
        DispatchQueue.main.async { [self] in
            items.forEach { item in
                item.setupDisaple()
            }
            
            if items.count > index {
                items[index].setupActive()
            }
        }
    }
}

class PagingIndecatorItem: BaseView {
    
    private lazy var item = BaseView()
    
    private var isCreate = false
    
    override func setupView() {
        if !isCreate {
            isCreate = true
            
            snp.makeConstraints { make in
                make.height.width.equalTo(8)
            }
            
            item.backgroundColor = .init(hex: "#D9D9D9")
            item.layer.cornerRadius = 2.5
            
            addSubview(item)
            item.snp.makeConstraints { make in
                make.center.equalToSuperview()
                
                make.height.width.equalTo(5)
            }
        }
    }
    
    func setupActive() {
        item.backgroundColor = .init(hex: "#5068BD")
        
        item.snp.remakeConstraints { make in
            make.height.width.equalTo(8)
            
            make.center.equalToSuperview()
        }
        
        UIView.animate(withDuration: 0.1) { [self] in
            item.layer.cornerRadius = 4

            item.layoutIfNeeded()
        }
    }
    
    func setupDisaple() {
        item.backgroundColor = .init(hex: "#D9D9D9")
        
        item.snp.remakeConstraints { make in
            make.height.width.equalTo(5)
            
            make.center.equalToSuperview()
        }
        
        UIView.animate(withDuration: 0.1) { [self] in
            item.layer.cornerRadius = 2.5

            item.layoutIfNeeded()
        }
    }
}
