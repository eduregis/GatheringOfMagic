//
//  CardDetailScreenRouter.swift
//  GatheringOfMagic
//
//  Created by Eduardo Oliveira on 05/10/22.
//

import UIKit

class CardDetailScreenRouter: BaseRouter {
    
    static func makeModule(cardId: String, isFavorited: Bool, completion: (() -> Void)?) -> UIViewController {
        
        let viewController = CardDetailScreenViewController()
        let router = CardDetailScreenRouter(viewController: viewController)
        let presenter = CardDetailScreenPresenter(cardId: cardId, isFavorited: isFavorited, completion: completion, delegate: viewController, router: router)
        viewController.presenter = presenter
        
        return viewController
    }
    
    func backToList() {
        
    }
}
