//
//  DeckListScreenRouter.swift
//  GatheringOfMagic
//
//  Created by Eduardo Oliveira on 08/10/22.
//

import UIKit

class DeckListScreenRouter: BaseRouter {
    
    static func makeModule() -> UIViewController {
        let viewController = DeckListScreenViewController()
        let router = DeckListScreenRouter(viewController: viewController)
        let presenter = DeckListScreenPresenter(delegate: viewController, router: router)
        let navigation = UINavigationController(rootViewController: viewController)
        navigation.isNavigationBarHidden = false
        viewController.presenter = presenter
        
        return navigation
    }
    
    func navigateToCardDetail(cardId: String, completion: (() -> Void)?) {
//        self.present(CardDetailScreenRouter.makeModule(cardId: cardId, isFavorited: true, completion: completion), animated: true)
    }
}
