//
//  TabBarItem.swift
//  EduConnect
//
//  Created by Akylai Bekbolsunova on 18/4/24.
//

import UIKit

extension UITabBar {
    func disableTabs() {
        subviews.forEach { it in
            if let view = it as? TabBarItem {
                view.disable()
            }
        }
    }
    
    func style() {
        backgroundColor = .init(hex: "#FFFFFF")
        
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowRadius = 6
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.1
    }
}

class TabBarItem: UIView {
    
    public var name: String
    
    public var title: String
    
    public lazy var label: BaseLabel = {
        let view = BaseLabel()
        view.font = UIFont.systemFont(ofSize: 12)
        view.textColor = .init(hex: "#848484")
        view.textAlignment = .center
        view.isUserInteractionEnabled = false
        return view
    }()

    public lazy var image: BaseImage = {
        return BaseImage()
    }()
    
    init(name: String, title: String) {
        self.name = name
        self.title = title
        
        super.init(frame: .zero)
        
        setupAppearance()
    }
    
    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func addTab(tab: UITabBar, index: CGFloat, count: Int) {
        tab.addSubview(self)
                
        self.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(index * (tab.frame.width / CGFloat(count)))
            make.top.equalToSuperview()
            make.width.equalTo(tab.frame.width / CGFloat(count))
            make.height.equalTo(tab.frame.height)
        }
    }
    
    public func setupAppearance() {
        self.isUserInteractionEnabled = false

        label.text = title

        addSubview(label)
        label.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            
            make.centerX.equalToSuperview()
        }
        
        image.image = UIImage(named: name)
        
        addSubview(image)
        image.snp.makeConstraints { make in
            make.width.height.equalTo(22)
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(8)
        }
    }
    
    public func action() {
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        
        label.textColor = .init(hex: "#5068BD")

        image.image = UIImage(named: "\(name)Active")
    }
    
    public func disable() {
        label.font = UIFont.systemFont(ofSize: 12)
        
        label.textColor = .init(hex: "#848484")
        
        image.image = UIImage(named: name)
    }
}
