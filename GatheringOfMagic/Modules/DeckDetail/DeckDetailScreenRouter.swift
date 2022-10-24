//
//  DeckDetailScreenRouter.swift
//  GatheringOfMagic
//
//  Created by Eduardo Oliveira on 08/10/22.
//

import UIKit

class DeckDetailScreenRouter: BaseRouter {
    
    static func makeModule(deck: CD_Deck, completion: (() -> Void)?) -> UIViewController {
        
        let viewController = DeckDetailScreenViewController()
        let router = DeckDetailScreenRouter(viewController: viewController)
        let presenter = DeckDetailScreenPresenter(deck: deck, completion: completion, delegate: viewController, router: router)
        viewController.presenter = presenter
        
        return viewController
    }
    
    func navigateToEditDeck(deck: CD_Deck) {
        self.push(EditDeckScreenRouter.makeModule(deck: deck), animated: true)
    }
    
    func navigateToCardDetail(cardId: String) {
        self.present(CardDetailScreenRouter.makeModule(cardId: cardId, isFavorited: false, isComingFromDeckDetail: true), animated: true)
    }
}
