//
//  FavoriteListScreenRouter.swift
//  GatheringOfMagic
//
//  Created by Eduardo Oliveira on 08/10/22.
//

import UIKit

class FavoriteListScreenRouter: BaseRouter {
    
    static func makeModule() -> UIViewController {
        let viewController = FavoriteListScreenViewController()
        let router = FavoriteListScreenRouter(viewController: viewController)
        let presenter = FavoriteListScreenPresenter(delegate: viewController, router: router)
        let navigation = UINavigationController(rootViewController: viewController)
        navigation.isNavigationBarHidden = false
        viewController.presenter = presenter
        
        return navigation
    }
    
    func navigateToCardDetail(cardId: String, completion: (() -> Void)?) {
        self.present(CardDetailScreenRouter.makeModule(cardId: cardId, isFavorited: true, completion: completion), animated: true)
    }
}
