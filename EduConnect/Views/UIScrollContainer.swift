//
//  UIScrollContainer.swift
//  EduConnect
//
//  Created by Akylai Bekbolsunova on 17/4/24.
//

import UIKit
import SnapKit

class UIScrollContainer: BaseView {
    
    public lazy var scrollView = UIScrollView()
    
    private lazy var contentView: UIView = {
        return UIView()
    }()
    
    private lazy var topGradient = GradientView(orintaion: .top)
    
    private lazy var bottomGradient = GradientView(orintaion: .bottom)

    override func layoutSubviews() {
        addSubview(scrollView)
        scrollView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        scrollView.addSubview(contentView)
        contentView.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(scrollView)
            make.left.right.equalTo(self)
        }
        
        addSubview(topGradient)
        topGradient.snp.makeConstraints { make in
            make.top.equalToSuperview()
            
            make.left.right.equalToSuperview()
            
            make.height.equalTo(10)
        }
        
        addSubview(bottomGradient)
        bottomGradient.snp.makeConstraints { make in
            make.bottom.equalToSuperview()

            make.left.right.equalToSuperview()
            
            make.height.equalTo(10)
        }
    }
    
    public func addView(_ view: UIView) {
        contentView.addSubview(view)
    }
}
