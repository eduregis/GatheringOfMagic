//
//  CardListScreenRouter.swift
//  GatheringOfMagic
//
//  Created by Eduardo Oliveira on 05/10/22.
//

import UIKit

class CardListScreenRouter: BaseRouter {
    
    static func makeModule() -> UIViewController {
        let viewController = CardListScreenViewController()
        let router = CardListScreenRouter(viewController: viewController)
        let presenter = CardListScreenPresenter(delegate: viewController, router: router)
        viewController.presenter = presenter
        return viewController
    }
    
    func navigateToCardDetail(cardId: String, isFavorited: Bool, completion: (() -> Void)?) {
        self.present(CardDetailScreenRouter.makeModule(cardId: cardId, isFavorited: isFavorited, completion: completion), animated: true)
    }
}
