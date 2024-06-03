//
//  BaseTabController.swift
//  EduConnect
//
//  Created by Akylai Bekbolsunova on 18/4/24.
//

import UIKit

class BaseTabController<P: AnyObject>: UITabBarController {
    
    lazy var router: RouterController? = {
        return navigationController as? RouterController
    }()
    
    var presenter: P? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .init(hex: "#FFFFFF")
        
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(hideKeyboard)))
        
        setupController()
        
        setupSubViews()
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            
            keyboardShow(height: keyboardRectangle.height)
        }
    }
    
    @objc private func keyboardWillHide(notification: Notification) {
        keyboardHide()
    }
    
    func keyboardShow(height: Double) {
        
    }
    
    func keyboardHide() {
        
    }
    
    @objc func hideKeyboard() {
        view.endEditing(true)
    }
    
    func setupController() {
        
    }
    
    func setupSubViews() {
        
    }
}
