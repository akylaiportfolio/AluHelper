//
//  RouterController.swift
//  EduConnect
//
//  Created by Akylai Bekbolsunova on 7/4/24.
//

import UIKit
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth
import FirebaseDatabase

class RouterController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationBar.isHidden = true
        interactivePopGestureRecognizer?.isEnabled = true
    }
    
    func open(_ controller: UIViewController, animated: Bool = true) {
        pushViewController(controller, animated: animated)
    }
    
    func new(_ controller: UIViewController, animated: Bool = true) {
        setViewControllers([controller], animated: animated)
    }
    
    func back() {
        popViewController(animated: true)
    }
}
