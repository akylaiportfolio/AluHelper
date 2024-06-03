//
//  ChatsController.swift
//  EduConnect
//
//  Created by Akylai Bekbolsunova on 18/4/24.
//

import Foundation

class ChatsController: BaseController<ChatsPresenter> {
    
    private lazy var toolbarView: ToolbarView = {
        let view = ToolbarView()
        view.titleView.text = "Chats"
        return view
    }()
    
    private lazy var selectorView = SelectorView()
    
    private lazy var emptySearchView = EmptySearchView()
    
    private lazy var chatsList = ChatsList()
        
    override func setupController() {
        chatsList.onItemTap { [self] in
            router?.open(ChatBuilder.create())
        }
        
        emptySearchView.onTab { [self] in
            router?.open(SearchUserBuilder.create(), animated: false)
        }
        
        emptySearchView.title.onEditing { [self] text in
            
        }
    }
    
    override func setupSubViews() {
        view.addSubview(toolbarView)
        toolbarView.snp.makeConstraints { make in
            make.top.equalTo(view.safeArea.top)
            make.left.right.equalToSuperview()
            make.height.equalTo(53)
        }
        
        view.addSubview(selectorView)
        selectorView.snp.makeConstraints { make in
            make.top.equalTo(toolbarView.snp.bottom)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(45)
        }
        
        view.addSubview(emptySearchView)
        emptySearchView.snp.makeConstraints { make in
            make.top.equalTo(selectorView.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(45)
        }
        
        view.addSubview(chatsList)
        chatsList.snp.makeConstraints { make in
            make.top.equalTo(emptySearchView.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(view.safeArea.bottom)
        }
    }
}

extension ChatsController: ChatsDelegate {
    
}
