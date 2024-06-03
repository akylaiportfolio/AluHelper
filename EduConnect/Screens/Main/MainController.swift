//
//  AdminController.swift
//  EduConnect
//
//  Created by Akylai Bekbolsunova on 18/4/24.
//

import Foundation
import UIKit

class MainController: UITabBarController {
    
    private lazy var home = TabBarItem(name: "Home", title: "Home")
    private lazy var guide = TabBarItem(name: "Guide", title: "Guide")
    private lazy var info = TabBarItem(name: "Info", title: "Info")
    private lazy var profile = TabBarItem(name: "Profile", title: "Profile")
    
    
    override func viewDidLoad() {
        setupController()
        
        setupTabs()
    }
    
    func setupController() {
        delegate = self

        viewControllers = [
            HomeBuilder.create(),
            GuideBuilder.create(),
            InfoBuilder.create(),
            ProfileBuilder.create()
        ]
        
        setupTabs()
    }
    
    func setupTabs() {
        tabBar.style()
        
        home.action()
        
        home.addTab(
            tab: tabBar,
            index: 0, count: 4
        )
        
        guide.addTab(
            tab: tabBar,
            index: 1, count: 4
        )
        
        info.addTab(
            tab: tabBar, 
            index: 2, count: 4
        )
        
        profile.addTab(
            tab: tabBar,
            index: 3, count: 4
        )
    }
}

extension MainController: UITabBarControllerDelegate {
    func tabBarController(_ controller: UITabBarController, didSelect _: UIViewController) {
        controller.tabBar.disableTabs()

        switch controller.selectedIndex {
        case 0:
            home.action()
        case 1:
            guide.action()
        case 2:
            info.action()
        case 3:
            profile.action()
        default:
            break
        }
    }
}

