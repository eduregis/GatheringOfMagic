//
//  DeckListScreenRouter.swift
//  GatheringOfMagic
//
//  Created by Eduardo Oliveira on 08/10/22.
//

import UIKit

class DeckListScreenRouter: BaseRouter {
    
    static func makeModule(isComingFromTabBar: Bool, cardToAddInDeck: CardDetail? = nil) -> UIViewController {
        let viewController = DeckListScreenViewController()
        let router = DeckListScreenRouter(viewController: viewController)
        let presenter = DeckListScreenPresenter(delegate: viewController, router: router, isComingFromTabBar: isComingFromTabBar, cardToAddInDeck: cardToAddInDeck)
        
        if (isComingFromTabBar) {
            let navigation = UINavigationController(rootViewController: viewController)
            navigation.isNavigationBarHidden = false
            viewController.presenter = presenter
            return navigation
        } else {
            viewController.presenter = presenter
            return viewController
        }
    }
    
    func navigateToDeckDetail(deck: CD_Deck, completion: (() -> Void)?) {
        self.push(DeckDetailScreenRouter.makeModule(deck: deck, completion: completion), animated: true)
    }
}
