//
//  CardDetailScreenRouter.swift
//  GatheringOfMagic
//
//  Created by Eduardo Oliveira on 05/10/22.
//

import UIKit

class CardDetailScreenRouter: BaseRouter {
    
    static func makeModule(cardId: String, isFavorited: Bool, isComingFromDeckDetail: Bool? = false) -> UIViewController {
        
        let viewController = CardDetailScreenViewController()
        let router = CardDetailScreenRouter(viewController: viewController)
        let presenter = CardDetailScreenPresenter(cardId: cardId, isFavorited: isFavorited, isCommingFromDeckDetail: isComingFromDeckDetail, delegate: viewController, router: router)
        viewController.presenter = presenter
        
        return viewController
    }
    
    func navigateToAddToDeckScreen(card: CardDetail) {
        self.present(DeckListScreenRouter.makeModule(isComingFromTabBar: false, cardToAddInDeck: card), animated: true)
    }
}
