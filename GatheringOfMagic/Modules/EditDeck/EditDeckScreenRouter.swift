//
//  EditDeckScreenRouter.swift
//  GatheringOfMagic
//
//  Created by Eduardo Oliveira on 12/10/22.
//

import Foundation

import UIKit

class EditDeckScreenRouter: BaseRouter {
    
    static func makeModule(deck: CD_Deck) -> UIViewController {
        
        let viewController = EditDeckScreenViewController()
        let router = EditDeckScreenRouter(viewController: viewController)
        let presenter = EditDeckScreenPresenter(deck: deck, delegate: viewController, router: router)
        viewController.presenter = presenter
        
        return viewController
    }
}
