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
        let navigation = UINavigationController(rootViewController: viewController)
        navigation.isNavigationBarHidden = false
        viewController.presenter = presenter
        
        return navigation
    }
    
    func navigateToCardDetail(cardId: String, isFavorited: Bool) {
        self.push(CardDetailScreenRouter.makeModule(cardId: cardId, isFavorited: isFavorited), animated: true)
    }
}
