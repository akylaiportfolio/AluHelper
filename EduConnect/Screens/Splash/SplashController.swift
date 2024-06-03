//
//  SplashController.swift
//  EduConnect
//
//  Created by Akylai Bekbolsunova on 7/4/24.
//

import UIKit

class SplashController: BaseController<SplashPresenter> {
    
    private lazy var image: BaseImage = {
        return BaseImage(image: UIImage(named: "AppMainIcon"))
    }()
    
    private lazy var contener = BaseView()
    
    override func setupController() {
        Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { [self] _ in
            presenter?.checkNavigate()
        }
    }
    
    override func setupSubViews() {
        view.addSubview(contener)
        contener.snp.makeConstraints { make in
            make.top.equalTo(view.safeArea.top)
            make.bottom.equalTo(view.safeArea.bottom)
            make.left.right.equalToSuperview()
        }
        
        contener.addSubview(image)
        image.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}

extension SplashController: SplashDelegate {
    func navigateToMain() {
        image.hide { [self] in
            router?.new(MainBuilder.create())
        }
    }
    
    func navigateToLogin() {
        image.hide { [self] in
            router?.new(LoginBuilder.create(), animated: false)
        }
    }
}
