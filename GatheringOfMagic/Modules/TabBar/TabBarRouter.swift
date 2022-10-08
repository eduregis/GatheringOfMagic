//
//  TabBarRouter.swift
//  GatheringOfMagic
//
//  Created by Eduardo Oliveira on 08/10/22.
//

import UIKit

class TabBarRouter: BaseRouter {
    
    static func makeModule() -> UIViewController {
        
        let viewController1 = CardListScreenRouter.makeModule()
        let tabOneBarItem1 = UITabBarItem(title: "Tab 1", image: UIImage(systemName: "star"), selectedImage: UIImage(systemName: "star.fill"))
        viewController1.tabBarItem = tabOneBarItem1

        let viewController2 = CardListScreenRouter.makeModule()
        let tabOneBarItem2 = UITabBarItem(title: "Tab 1", image: UIImage(systemName: "star"), selectedImage: UIImage(systemName: "star.fill"))
        viewController2.tabBarItem = tabOneBarItem2

        let tabBar = UITabBarController()
        tabBar.viewControllers = [viewController1, viewController2]

        return tabBar
    }
}
