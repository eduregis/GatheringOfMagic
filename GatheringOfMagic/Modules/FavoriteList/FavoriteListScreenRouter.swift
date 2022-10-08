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
        viewController.presenter = presenter
        return viewController
    }
    
    func navigateToCardDetail(cardId: String, isFavorited: Bool, completion: (() -> Void)?) {
        self.present(CardDetailScreenRouter.makeModule(cardId: cardId, isFavorited: isFavorited, completion: completion), animated: true)
    }
}
