//
//  ContenerEditField.swift
//  EduConnect
//
//  Created by Akylai Bekbolsunova on 7/4/24.
//

import UIKit

class ContenerEditField: BaseView {
    
    lazy var title: BaseLabel = {
        let view = BaseLabel()
        view.font = .systemFont(ofSize: 12)
        view.textColor = .init(hex: "#727272")
        return view
    }()
    
    lazy var editField = EditField()
    
    init() {
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setupView() {
        editField.onChange { [self] text in
            state(.normal)
            
            action(text)
        }
    }
    
    private var text = String()
    
    func setTitle(text: String) {
        self.text = text
        
        title.text = text
    }
    
    func state(_ state: StateField) {
        UIView.animate(withDuration: 0.3) { [self] in
            editField.state(state)
            
            switch state {
            case .normal:
                title.text = text
                
                title.textColor = .init(hex: "#727272")
                
            case .error(let message):
                title.text = message
                
                title.show()
                
                title.textColor = .init(hex: "#973535")
            }
        }
    }
    
    var action: (String) -> Void = { _ in }
    
    func onChange(action: @escaping (String) -> Void) {
        self.action = action
    }
    
    override func setupSubViews() {
        addSubview(title)
        title.snp.makeConstraints { make in
            make.top.leading.equalToSuperview()
        }
        
        addSubview(editField)
        editField.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            
            make.height.equalTo(45)
        }
    }
}
