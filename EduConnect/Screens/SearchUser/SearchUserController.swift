//
//  SearchUserController.swift
//  EduConnect
//
//  Created by Akylai Bekbolsunova on 21/4/24.
//

import Foundation

class SearchUserController: BaseController<SearchUserPresenter> {
    
    private lazy var toolbar = SearchToolbar()
    
    private lazy var emptySearchView: EmptySearchView = {
        let view = EmptySearchView()
        view.title.isUserInteractionEnabled = true
        view.title.becomeFirstResponder()
        return view
    }()
    
    private lazy var searchUserListResult = SearchUserListResult()

    private var timer: Timer? = nil
    
    override func setupController() {
        toolbar.back.onTab { [self] in
            router?.back()
        }
        
        emptySearchView.title.onEditing { [self] text in
            timer?.invalidate()
            
            timer = Timer.scheduledTimer(withTimeInterval: 0.3, repeats: false) { [self] timer in
                presenter?.searchUser(text: text)
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
        
        view.addSubview(emptySearchView)
        emptySearchView.snp.makeConstraints { make in
            make.top.equalTo(toolbar.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(45)
        }
        
        view.addSubview(searchUserListResult)
        searchUserListResult.snp.makeConstraints { make in
            make.top.equalTo(emptySearchView.snp.bottom).offset(8)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(view.safeArea.bottom)
        }
    }
    
}

extension SearchUserController: SearchUserDelegate {
    func showResult(models: [UserModel]) {
        searchUserListResult.fill(models: models)
    }
}
