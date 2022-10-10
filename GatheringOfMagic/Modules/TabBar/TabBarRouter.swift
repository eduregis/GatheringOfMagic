//
//  TabBarRouter.swift
//  GatheringOfMagic
//
//  Created by Eduardo Oliveira on 08/10/22.
//

import UIKit

class TabBarRouter: BaseRouter {
    
    static func makeModule() -> UIViewController {
        
        let cardListScreenViewController = CardListScreenRouter.makeModule()
        let tabOneBarItem = UITabBarItem(title: "Cards", image: UIImage(systemName: "square.stack.3d.down.right"), selectedImage: UIImage(systemName: "square.stack.3d.down.right.fill"))
        cardListScreenViewController.tabBarItem = tabOneBarItem

        let favoriteListScreenViewController = FavoriteListScreenRouter.makeModule()
        let tabTwoBarItem = UITabBarItem(title: "Favorites", image: UIImage(systemName: "star"), selectedImage: UIImage(systemName: "star.fill"))
        favoriteListScreenViewController.tabBarItem = tabTwoBarItem
        
        let deckListScreenViewController = DeckListScreenRouter.makeModule()
        let tabThreeBarItem = UITabBarItem(title: "Decks", image: UIImage(systemName: "tray"), selectedImage: UIImage(systemName: "tray.fill"))
        deckListScreenViewController.tabBarItem = tabThreeBarItem


        let tabBar = UITabBarController()
        tabBar.viewControllers = [cardListScreenViewController, favoriteListScreenViewController, deckListScreenViewController]

        return tabBar
    }
}
