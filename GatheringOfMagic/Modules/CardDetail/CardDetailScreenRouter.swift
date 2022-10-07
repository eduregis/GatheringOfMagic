//
//  CardDetailScreenRouter.swift
//  GatheringOfMagic
//
//  Created by Eduardo Oliveira on 05/10/22.
//

import Foundation

import UIKit

class CardDetailScreenRouter: BaseRouter {
    
    static func makeModule(cardId: String) -> UIViewController {
        
        let viewController = CardDetailScreenViewController()
        let router = CardDetailScreenRouter(viewController: viewController)
        let presenter = CardDetailScreenPresenter(cardId: cardId, delegate: viewController, router: router)
        viewController.presenter = presenter
        
        return viewController
    }
    
    func backToList() {
        
    }
}
