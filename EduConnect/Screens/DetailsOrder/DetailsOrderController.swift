//
//  DetailsOrder.swift
//  EduConnect
//
//  Created by Akylai Bekbolsunova on 16/5/24.
//

import UIKit
import SnapKit
import PDFKit
import WebKit

class DetailsOrderController: BaseController<DetailsOrderPresenter> {
    
    private lazy var toolbar: ToolbarView = {
        let view = ToolbarView()
        view.titleView.text = "Order"
        return view
    }()
    
    private lazy var pdfViewer = PDFView()
    
    override func setupController() {
        toolbar.onTapBack { self.router?.back() }
        
        if let url = URL(string: presenter?.model?.file ?? "") {
            pdfViewer.document = PDFDocument(url: url)
        }
    }
    
    override func setupSubViews() {
        view.addSubview(toolbar)
        toolbar.snp.makeConstraints { make in
            make.top.equalTo(view.safeArea.top)
            make.left.right.equalToSuperview()
            make.height.equalTo(53)
        }
        
        view.addSubview(pdfViewer)
        pdfViewer.snp.makeConstraints { make in
            make.top.equalTo(toolbar.snp.bottom)
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
}

extension DetailsOrderController: DetailsOrderDelegate {
    
}
